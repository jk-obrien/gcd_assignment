# This script looks for the project zip file and unzips it. If the zip file
# is missing it downloads it from the original source and then unzips it. Lastly
# the script makes a list of all data files.

# It expects to find the files in the current working directory - getwd().

# First define two constants, holding the relative path to the zip file, and
# the download url for the zipfile.
zip_file <- "getdata_projectfiles_UCI HAR Dataset.zip"
url <- paste0(
    "https://d396qusza40orc.cloudfront.net/",
    "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
)


# Make sure the zip file is present.
if (!file.exists(zip_file)) {

    # If not download it.
    message("Downloading...")
    download.file(url, zip_file, method="curl")
}


# Then unzip the contents.
message("Unzipping...")
unzip(zip_file)


# The data files are all .txt files, so get a list of those.
data_files <- list.files(getwd(), pattern="[.]txt$", recursive=TRUE)


# A few .txt files aren't data files, so get rid of those.
data_files <- data_files[grep("CodeBook|README|_info", data_files, invert=TRUE)]

# And some .txt files aren't needed (lower-level) for this assignment.
data_files <- data_files[grep("Inertial", data_files, invert=TRUE)]


# Clean up objects that will no longer be needed.
rm(list=c("url", "zip_file"))
