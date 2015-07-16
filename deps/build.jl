if !isdir("downloads")
    mkdir("downloads")
end
cd("downloads")

if !isdir("BSR")
    println("Downloading BSR code...")
    run(`wget http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/BSR/BSR_code.tgz`)
    println("Extracting...")
    run(`tar xvzf BSR_code.tgz`)
    rm("BSR_code.tgz")
end
