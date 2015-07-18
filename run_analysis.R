# This script performs the analysis required for the assignment. It is broken
# into five sections, each corresponding to the five steps listed in the
# assignment instructions. The order of those steps has been changed slightly
# and a zeroth step has been added. The new order of steps is given here.

# 0) Download and unpack the data zip file.
# 1) Merge the training and the test sets to create one data set.
# 2) Appropriately label the data set with descriptive variable names.
# 3) Use descriptive activity names to name the activities in the data set.
# 4) Extract only the measurements on the mean and standard deviation for each
#    measurement.
# 5) From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.


#####                     Get Data Files                                   #####
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
#unzip(zip_file)

# Clean up objects that will no longer be needed.
rm(list=c("url", "zip_file"))


# The data files are all .txt files, so get a list of those.
data_files <- list.files(getwd(), pattern="[.]txt$", recursive=TRUE)

# A few .txt files aren't data files, so get rid of those.
data_files <- data_files[grep("CodeBook|README|_info", data_files, invert=TRUE)]

# And some .txt files aren't needed (too low-level) for this assignment.
data_files <- data_files[grep("Inertial", data_files, invert=TRUE)]



#####                       Merge Data                                     #####
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
#rm(list=c("var_names", "data_files", "i"))


# Now we have all our data, it's time to start merging it together. The two
# main objects are X_test and X_train. We need to include columns for a subject
# id, an activity id, and a label for the data set (test/train).
library(data.table)
big_dt <- data.table(
    subj_id     = c(subject_test$V1, subject_train$V1),
    activity_id = c(y_test$V1,       y_train$V1),
    set_label   = c(
        rep_len("test",  nrow(X_test) ),
        rep_len("train", nrow(X_train))
    ),
    rbind(X_test, X_train)
)

#rm(list=c("X_train", "y_train","subject_train",
#          "X_test",  "y_test", "subject_test" )
#)



#####                     Set Variable Names                               #####
#                                                                              #
# The file "UCI HAR Dataset/features.txt" holds the variable names for X_test  #
# and X_train, but they need a little cleaning up.                             #
#                                                                              #
#####                                                                      #####


# Remove parentheses from the feature names.
features <- gsub("[()]", "",  features$V2)

# Replace commas and hypens with underscores.
features <- gsub("[,-]", "_", features)

# We already have names for the first three columns.
end <- length(names(big_dt))
setnames(big_dt, names(big_dt)[4:end], features)

# Tidy up before moving on.
#rm("features", "end")


#################
# GOOD TO HERE. #
# I THINK!      #
#################



#####                    Descriptive Activity Labels                       #####
#                                                                              #
# The file "UCI HAR Dataset/activity_labels.txt" maps the codes used in the    #
# data files to descriptive text labels. So use this to replace the codes in   #
# our "big_dt" data table.                                                     #
#                                                                              #
#####                                                                      #####

# Map the activity labels to the id codes in a new vector.
#act_label <- activity_labels$V2[full_set$activity_id]

# Add the new column on the left of the "full_set" data frame.
#full_set <- cbind(data.frame(activity=act_label), full_set)

# Keep things tidy.
#rm(list=c("act_label", "activity_labels"))



#####                   Extract means & std. deviations                    #####
#                                                                              #
# We're only interested in the variables concerning means and standard         #
# deviations (as well as the subject_id, activity label and data set label, of #
# course). So make a vector listing just that subset of "full_set" columns and #
# use it to extract those columns into a smaller data frame.                   #
#                                                                              #
#####                                                                      #####

# Use a regexp to make the vector list.
#regexp <- "activity|_id|_set|mean|_std_"
#subset <- grep(regexp, names(full_set), ignore.case=TRUE, value=TRUE)

# Pull those columns from "full_set".
#slim_df <- full_set[,subset]

#rm(list=c("full_set", "subset"))
