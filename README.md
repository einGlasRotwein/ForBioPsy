# Helper functions for automated file administration and data wrangling
This package accompanies the scripts I wrote for easier file management and
wrangling of EEG data files. It is taylored to the needs of the BioPsy 
group, but maybe some of the functions might be helpful on their own. See a list of functions, current development and to do in the [Documentation](https://github.com/einGlasRotwein/ForBioPsy/tree/master/news%20and%20examples/README.md).

## Getting started
You can install this package by running the following code in your console:

```R
# If devtools is not installed, uncomment the next line and run it:
# install.packages("devtools")
devtools::install_github("einGlasRotwein/ForBioPsy")

library("ForBioPsy")
```

This packages' functions are used within scripts lying on the server of the
BioPsy group, so not everything will appear useful without context. All of these
scripts were created using `R` version 3.6.1 (2019-07-05) -- "Action of the
Toes".
