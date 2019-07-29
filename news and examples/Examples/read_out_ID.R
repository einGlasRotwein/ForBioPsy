
library(ForBioPsy)

# Examples for `read_out_ID()`: Reading out participants' IDs in a specified
# format from file names in a given folder. I assume that your R-project lies
# in the folder where this script lies. And furthermore, that this folder
# contains the folder "read participant ID example files", like the one you can
# find in this folder, i.e. with all its subfolders.

# In the different subfolders of "read participant ID example files", you will 
# find various (empty) textfiles, while each folder has a different system for 
# labelling participants with a unique ID. 
# It is indicated by the folders name: Each 0 stands for a digit, X for a 
# letter. So, in folder "00_XXX" we find IDs like 01_ABC or 02_TBC. In folder 
# "XXX00", we find IDs like ABC12 or JTF99. The function `read_out_ID()` is now 
# supposed to read out those IDs from the file names. Crucially, there are some 
# files included which don't contain IDs - or IDs in the wrong format. In the 
# folder "00_XXX", for example, we obviously don't want to catch the file 
# "dont_catch_me.txt". We also don't want to catch "ABG_dont_catch_me.txt", 
# because the numbers and the underscore at the beginning are missing. We also 
# see that we have two files for ID 03_TOF - but we want to list him only once 
# in our participant list.

# There are many folders you can try out - I will only show you some of them in 
# this script, because the concept itself always stays the same.

# EXAMPLE 1 - FOLDER 00__XX00XX - default mode
# We tell the function where to look for the files and specify the format our ID 
# is supposed to have via the argument `ID_format`. It works like the folder 
# names I just showed you: 0 is a digit, X is a letter (upper or lower case) and 
# _ is, well ... an underscore.
# Note that in my folders, the ID is always separated from the file name by an 
# underscore at the end for clarification, so I include that in `ID_format`. By 
# default, `read_out_ID()` gets rid of any underscores at the end of an ID.
folderpath <- "./read participant ID example files/00_XX00XX"
read_out_ID(ID_format = "00_XX00XX_", folderpath = folderpath)
# [1] "01_AB12CD" "02_TB19CG" "03_TO10FK" "04_JT99PW" "05_MP66KL"

# If you want, you can give back the file names rather than just the IDs.
read_out_ID(ID_format = "00_XX00XX_", folderpath = folderpath, filenames = TRUE)
# [1] "01_AB12CD_some_data.txt"  "01_AB12CD_some_data2.txt" "02_TB19CG_some_data.txt" 
# [4] "03_TO10FK_some_data.txt"  "04_JT99PW_some_data.txt"  "05_MP66KL_some_data.txt" 

# EXAMPLE 2 - FOLDER 00_XXX - keep underscores
# And you can of course keep any trailing underscores if you want to.
folderpath <- "./read participant ID example files/00_XXX"
read_out_ID(ID_format = "00_XXX_", folderpath, remove_ = FALSE)
# [1] "01_ABC_" "02_TBC_" "03_TOF_" "04_JTP_" "05_MPK_"

# EXAMPLE 3 - FOLDER XXX - why underscores are helpful
# I'd recommend using underscores for separation, though - and indicating it 
# in `ID_format`, because it makes reading in the ID pattern easier. You can see 
# that without the separating _, "don" and "scr" get included in our participant 
# IDs - from the files "dont_catch_me.txt" and "script_dontcatchme.txt".
folderpath <- "./read participant ID example files/XXX"
read_out_ID(ID_format = "XXX", folderpath)
# [1] "ABC" "don" "JTP" "MPK" "scr" "TBC" "TOF"

# It's a good thing that our ID is always separated by a _, because we can 
# easily prevent that by including it in `ID_format` and `read_out_ID()` will 
# automatically take care of the trailing underscore.
read_out_ID(ID_format = "XXX_", folderpath)
# [1] "ABC" "JTP" "MPK" "TBC" "TOF"

# ... unless you don't want it to, of course.
read_out_ID(ID_format = "XXX_", folderpath, remove_ = FALSE)
# [1] "ABC_" "JTP_" "MPK_" "TBC_" "TOF_"

# EXAMPLE 4 - ALL FOLDERS - multiple (sub)folders
# One more thing: Feel free to search a given folder recursively if your 
# participants' data is distributed via various subfolders. It doesn't make much 
# sense to search all of the folders in our folder "read participant ID example 
# files" because they all follow a different ID system, but at least two of them 
# follow the same logic. It would be a more elegant way to just seach both of 
# these folders:
folderpath1 <- "./read participant ID example files/XXX"
folderpath2 <- "./read participant ID example files/XXX different IDs"
read_out_ID(ID_format = "XXX_", c(folderpath1, folderpath2))
# [1] "ABC" "DIF" "JTP" "MPK" "TBC" "TOF" "WUP" "YIP"

# But you could also go all in and seach the whole of "read participant ID 
# example files" recursively and go through all of its subfolders. For example, 
# folder 00_XXX also contains a file "PPP_dont_catch_me.txt". While this file 
# should not be matched if we searched this folder for its intended ID 
# structure (00_XXX), it fits the ID structure of XXX and will be included in 
# our participant IDs when we search recursively.
folderpath <- "./read participant ID example files"
read_out_ID("XXX_", folderpath, recursive = TRUE)
# [1] "ABG" "PPP" "DIF" "TOF" "WUP" "YIP" "ABC" "JTP" "MPK" "TBC"

# EXAMPLE 5 - file names
# You can also just provide a (vector of) file name(s) directly:
my_files <- c("LF00AP_data.txt", "JT13MP_data.txt", "MT99KD_data.txt",
              "dont_catch_me.txt")
read_out_ID("XX00XX_", my_files)
# [1] "LF00AP" "JT13MP" "MT99KD"
