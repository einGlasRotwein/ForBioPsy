
library(ForBioPsy)

# This example script will show you how to delete empty files in the folder
# deletion example files. Note that if you download the folder and run the code
# successfully, it doesn't make sense to run it again, because there won't be
# any more empty files left. Create a backup of the folder before you run the
# following functions or download it again from this repository. It makes sense 
# to "renew" the folder after every example run.
# Note that the .dat files are not real data, but random data from a normal
# distribution.

# I assume that your R project lies in the "Examples" folder, where the
# "deletion examples files" folder lies. You need to change the file path if to
# wherever your data lies if that's not the case.
folder_path <- "./deletion example files"

# Delete all .txt files that are truly empty, i.e. have a size of 0 or are 
# "blank" and contain neither data nor a header - nothing. After running this 
# code, the two truly empty .txt files will have been deleted, but the non 
# empty and the pseudo empty (only containing headers) are still there.
delete_empty_BA_files(folderpath = folder_path, filetype = "txt",
                      only_truly_empty = TRUE)

# Delete all .txt files that are empty - i.e. contain no data or nothing but a 
# header. Note that my text files contain a single line of information in the 
# first line which is not a header. We skip that.
# After running this code, we will be left with the only non empty .txt file.
delete_empty_BA_files(folderpath = folder_path, filetype = "txt", skip = 1)

# Note that the approach with `only_truly_empty = TRUE` relying on file size = 0 
# only really works for .txt files, because empty .csv and .dat files also have 
# a small size. Instead, `delete_empty_files()` will try to open those files and 
# if it encounters an error because they are empty, it will delete them. I 
# cannot guarantee that this will lead to unexpected results at some point, but 
# I'd always advise to backup your files before automatically and permanently 
# deleting stuff anyways.
delete_empty_BA_files(folderpath = folder_path, filetype = c("csv", "dat"),
                      only_truly_empty = TRUE)

# If we use the default `only_truly_empty = FALSE`. After running this code, all 
# empty and pseudo empty .csv and .dat files (i.e. that only contain a header,
# but no data) will have been removed.
delete_empty_BA_files(folderpath = folder_path, filetype = c("csv", "dat"))

# Actually, we shouldn't delete .txt files together with the other file types, 
# because in our case, the first line in the .txt files need to be skipped, 
# which isn't true for the other files. Better run separate calls suited to the 
# different "needs" of each file type, but here, something like this will still 
# do the trick.
delete_empty_BA_files(folderpath = folder_path, skip = 1)
