# Helper functions for automated file administration and data wrangling
This package accompanies the scripts I wrote for easier file management and
wrangling of EEG data files. It is taylored to the needs of the BioPsy 
group, but maybe some of the functions might be helpful on their own. See a list of functions, current development and to do in the [Documentation](https://github.com/einGlasRotwein/ForBioPsy/tree/master/inst/README.md).

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
Toes". Any packages used are listed in the description of the respective script.
However, I've been rather thrifty with additional packages to ensure reliable
performance of the scripts in the future. They should not depend on any changes
in the packages they use.

I assume the standard folder structure in the BioPsy group. That doesn't really 
matter, though - there are functions included that will help you determine the 
file paths you need. The only important thing is that you have two folders: One 
where your exported EEG data lies (in our case, .dat or .txt files exported from 
the [Brain Vision Analyzer](https://www.brainproducts.com/downloads.php?kid=9)) 
and one (empty) folder where the final (processed) data is supposed to go. Note 
that I assume that the preprocessing of the EEG data (like artifact correction) 
has already taken place within the Brain Vision Analyzer and you exported some 
segments of that data.

Of course, some of the functions included in this package don't need a full 
folder structure or specific EEG-files to run on.

When you want to start with exported data and process it, all you really have to 
do is to create a new project in R (ideally, in a new folder where your data 
analysis happens) and open it. In RStudio, that e.g. works like this:

Click on File -> New Project... -> Existing Directory

And then pick the folder you want your project to live in. You can then just 
open it by double clicking it in the folder and your working directory will be 
all set up.
