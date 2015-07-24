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

function gpb_owt_ucm{T<:Real}(img::Array{T}, scale::T=0.0)
    gpb_res = gpb(img)
    @mput gpb_res
    eval_string("ucm2 = contours2ucm(gpb_res, 'doubleSize');")
    eval_string("labels2 = bwlabel(ucm2 <= $scale);")
    eval_string("labels = labels2(2:2:end, 2:2:end);")
    convert(Matrix{Int}, @mget labels)
end
