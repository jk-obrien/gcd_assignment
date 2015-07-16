# This script performs the analysis required for the assignment. It is broken
# into five sections, each corresponding to the five steps listed in the
# assignment instructions. The order of those steps has been changed slightly
# and a zeroth step has been added. The order of steps is given here.

# 0) Download and unpack the data zip file.
# 1) Merge the training and the test sets to create one data set.
# 2) Appropriately label the data set with descriptive variable names.
# 3) Use descriptive activity names to name the activities in the data set.
# 4) Extract only the measurements on the mean and standard deviation for each
#    measurement.
# 5) From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.


#####                                                                      #####
#                                                                              #
# In this section the script looks for the project zip file and unzips it. If  #
# the zip file is missing it downloads it from the original source and then    #
# unzips it. Lastly the script makes a list of all data files.                 #
#                                                                              #
# It expects to find the files in the current working directory - getwd().     #
#                                                                              #
#####                                                                      #####


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

# And some .txt files aren't needed (too low-level) for this assignment.
data_files <- data_files[grep("Inertial", data_files, invert=TRUE)]


# Clean up objects that will no longer be needed.
rm(list=c("url", "zip_file"))



#####                                                                      #####
#                                                                              #
# In this section the script reads all the text files into R objects. Since    #
# the basenames of the text files are unique, the script uses these to name    #
# each object. The script then merges them all into a single data.frame.       #
#                                                                              #
# See "UCI HAR Dataset/README.txt" for a description of how the data files are #
# related to each other.                                                       #
#                                                                              #
#####                                                                      #####


# Make a list of the basenames of the files - without the .txt extension.
var_names <- sub("([^.]+)[.]txt$", "\\1", basename(data_files))

# This loop reads the contents of each file into a dataframe with the same name.
# For example the file "UCI HAR Dataset/activity_labels.txt" is read into the
# dataframe "activity_labels".
message("Loading data...")
for (i in 1:length(var_names)) {
    # fread repeatedly crashed here, so use read.table instead.
    assign(var_names[i], read.table(data_files[i]))
}

# Tidy as we go.
rm(list=c("var_names", "data_files", "i"))


# Now we have all our data, it's time to start merging it together.
# The two main objects are X_test and X_train.

# Create variables to identify the data set as test or train.
label_test  <- data.frame(dset = rep_len("test",  dim(X_test)[1] ) )
label_train <- data.frame(dset = rep_len("train", dim(X_train)[1]) )

# Add columns to X_test and X_train to identify the subject, the activity, and
# the data set.
X_test  <- cbind(subject_test,  y_test,  label_test,  X_test)
X_train <- cbind(subject_train, y_train, label_train, X_train)

# Then join the "test" and "trial" data sets into one.
full_set <- rbind(X_test, X_train)

rm(list=c("X_train", "y_train","subject_train", "label_train",
          "X_test",  "y_test", "subject_test",  "label_test")
)

# Some of the feature names have parentheses and hyphens.
features <- gsub("[()]", "",  features)
features <- gsub("-",    "_", features)

# Add column names for the subject id, the feature id and the data set labels.
features <- c("subj_id", "activity_id", "data_set", features)

# Use the cleaned features vector to name the full_set columns
names(full_set) <- features




rm(list=c("activity_lables", "features"))
