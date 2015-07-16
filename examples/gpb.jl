using BSR
using Images, ImageView

function main()
    # load image from data directory
    pkgdir = joinpath(Pkg.dir(), "BSR")
    datadir = joinpath(pkgdir, "deps/downloads/BSR/grouping/data")
    imagefile = joinpath(datadir, "101087_small.jpg")
    img = permutedims(data(reinterpret(Float64, float64(imread(imagefile)))), [3, 2, 1])

    # display image
    view(img, pixelspacing = [1, 1])
    println("original image (press enter to continue)")
    readline()

    # compute gPb and display result
    println("computing gpb (this may take some time...)")
    gpbresponse = gpb(img)
    nrows = 2
    ncols = 4
    grid = canvasgrid(nrows, ncols)
    ops = [:pixelspacing => [1, 1]]
    for d = 1:size(gpbresponse, 3)
        row = div(d - 1, ncols) + 1
        col = mod1(d, ncols)
        view(grid[row, col], gpbresponse[:, :, d]; ops...)
    end
    println("gpb response (press enter to continue)")
    readline()
end

main()
