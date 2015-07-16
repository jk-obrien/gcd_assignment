# This script reads all the data files and merges them into a single data set.

# First make sure that the "data_files" vector is present and not empty.
if ( !exists("data_files") || ( length(data_files) < 8 ) ) {
    stop("ERROR! data_files vector absent or too short.")
}

# The basenames of the files are unique, so use those (minus the file
# extensions) as object names and read the file contents into them.


# The basename() function returns just the file name without the directory path.
# The sub() regular expression removes the .txt file extension.
var_names <- sub("([^.]+)[.]txt$", "\\1", basename(data_files))

# This loop reads the contents of each file into a dataframe with the same name.
# For example the file "UCI HAR Dataset/activity_labels.txt" is read into the
# dataframe "activity_labels".
message("Loading data...")
for (i in 1:length(var_names)) {
    # fread repeatedly crashed here, so use read.table instead.
    assign(var_names[i], read.table(data_files[i]))
}
rm(list=c("var_names", "data_files", "i"))

# Now we have all our data, it's time to start merging it together. See
# "UCI HAR Dataset/README.txt" for a description of how the data files are
# related to each other.

# First add a column to identify the data set as test or trial and another to
# identify the subject.
X_test <- cbind(
    dset=rep_len("test", dim(X_test)[1]),
    subj_id=subject_test,
    X_test
)

X_train <- cbind(
    dset=rep_len("trial", dim(X_train)[1]),
    subj_id=subject_train,
    X_train
)

# Then join the "test" and "trial" data sets into one.
full_set <- rbind(X_test, X_train)

rm(list=c("X_train", "X_test", "subject_train", "subject_test"))
