# Give access to BSR lib code
pkgdir = joinpath(Pkg.dir(), "BSR")
bsrlibdir = joinpath(pkgdir, "deps/downloads/BSR/grouping/lib")
@mput bsrlibdir
@matlab addpath(bsrlibdir)

##############################################################################
##
## gpb
##
##############################################################################

function gpb{T<:Real}(img::Array{T})
    # img can either be grayscale (two dimensions) or color (three dimensions)
    @mput img
    @mquiet gpb_orient = globalPb_im(img)
    @mget gpb_orient
end

##############################################################################
##
## gpb-owt-ucm
##
##############################################################################

function gpb_owt_ucm_labels_ucm2{T<:Real}(img::Array{T}; scale::T=0.0)
    gpb_res = gpb(img)
    @mput gpb_res
    eval_string("ucm2 = contours2ucm(gpb_res, 'doubleSize');")
    eval_string("labels2 = bwlabel(ucm2 <= $scale);")
    eval_string("labels = labels2(2:2:end, 2:2:end);")

    labels = convert(Matrix{Int}, @mget labels)
    ucm2 = @mget ucm2

    labels, ucm2
end

function gpb_owt_ucm{T<:Real}(img::Array{T}; scale::T=0.0)
    gpb_owt_ucm_labels_ucm2(img, scale=scale)[1]
end

function gpb_owt_ucm_strength{T<:Real}(img::Array{T}; scale::T=0.0)
    # return label along with corresponding strengths between
    # each region
    labels, ucm2 = gpb_owt_ucm_labels_ucm2(img, scale=scale)

    hstrength = ucm2[2:2:end, 3:2:end]
    vstrength = ucm2[3:2:end, 2:2:end]

    nsp = maximum(labels)
    strengthdict = Dict{NTuple{2,Int},Float64}()
    nrows, ncols = size(labels)
    for j = 1:ncols
        for i = 1:nrows
            # left to right
            if j <= ncols - 1
                left = labels[i, j]
                right = labels[i, j+1]
                if left != right
                    strengthdict[(left, right)] = 
                    strengthdict[(right, left)] = 
                        hstrength[i, j]
                end
            end
            
            # top to bottom
            if i <= nrows - 1
                top = labels[i, j]
                bottom = labels[i+1, j]
                if top != bottom
                    strengthdict[(top, bottom)] =
                    strengthdict[(bottom, top)] =
                        vstrength[i, j]
                end
            end
        end
    end

    labels, strengthdict
end
