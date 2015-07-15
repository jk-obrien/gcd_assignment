# This script checks to make sure all required data files are present. If any
# are missing it looks for the project zip file and unzips it. If the zip file
# is missing it downloads it from the original source and then unzips it.

# It expects to find the files in the current working directory - getwd().

# First define some constants, holding the relative paths to the data files, to
# the zip file, and the download url for the zipfile.
data_files <- c(
    "UCI HAR Dataset/activity_labels.txt",
    "UCI HAR Dataset/features.txt",
    "UCI HAR Dataset/test/subject_test.txt",
    "UCI HAR Dataset/test/X_test.txt",
    "UCI HAR Dataset/test/y_test.txt",
    "UCI HAR Dataset/train/subject_train.txt",
    "UCI HAR Dataset/train/X_train.txt",
    "UCI HAR Dataset/train/y_train.txt"
)

zip_file <- "getdata_projectfiles_UCI HAR Dataset.zip"

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


# Define a helper function to download and unpack the zip file if necessary.
checkZip <- function() {

    # Make sure the zip file is present.
    if (!file.exists(zip_file)) {

        # If not download it.
        message("Downloading...")
        download.file(url, zip_file, method="curl")
    }

    # Then unzip the contents.
    message("Unzipping...")
    unzip(zip_file)
}


# This is the main function. It looks for the data files, calling the helper
# above if any of them are missing. If a file is still missing after that it
# exits with an error message.
fetchData <- function() {

    # Check each data file in turn.
    for (dfile in data_files) {

        # If the file is there, all is well, so move on to the next file.
        if (file.exists(dfile)) next

        # If it's missing check if the zip file is there and unzip that.
        # We should only hit this line once in the entire loop.
        checkZip()

        # Then check again. If it's there now, move on.
        if (file.exists(dfile)) next

        # If it's still not there something serious is wrong.
        stop(paste("ERROR! Could not find or download", dfile))
    }
}


# Call the main function above.
fetchData()


# Clean up objects that will no longer be needed.
rm(list=c("url", "zip_file", "fetchData", "checkZip"))
