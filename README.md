# BSR.jl

The `BSR.jl` library wraps code from the UC Berkeley [Contour Detection and Image Segmentation Resources](http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/resources.html) page and exposes it for easy use within Julia. This is a work in progress as only a subset of functionality is exposed (pull requests are welcome!). The following algorithms are currently wrapped:

* Global probability of boundary (gPb)

Please note that you will need a MATLAB license to use this package, as the original code is written in MATLAB.

If you use this package, please give credit to the original authors by citing the following paper:

Contour Detection and Hierarchical Image Segmentation
P. Arbelaez, M. Maire, C. Fowlkes and J. Malik.
IEEE TPAMI, Vol. 33, No. 5, pp. 898-916, May 2011.
[[PDF]](http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/papers/amfm_pami2010.pdf) [[BibTex]](http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/papers/amfm_pami2011.bib)
