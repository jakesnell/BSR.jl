# Give access to BSR lib code
pkgdir = joinpath(Pkg.dir(), "BSR")
bsrlibdir = joinpath(pkgdir, "deps/downloads/BSR/grouping/lib")
@mput bsrlibdir
@matlab addpath(bsrlibdir)

function gpb{T<:Real}(img::Array{T})
    # img can either be grayscale (two dimensions) or color (three dimensions)
    @mput img
    @mquiet gpb_orient = globalPb_im(img)
    @mget gpb_orient
end
