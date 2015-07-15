# This is the main script that produces the final analysis. A full description
# of the scripts used, the data files read and all other files used in this
# project is found in the file README.md

# 1) Merge the training and the test sets to create one data set.
source("fetch_data.R")
source("merge_data.R")

# 2) Extract only the measurements on the mean and standard deviation for each
# measurement.
source("subset_data.R")

# 3) Use descriptive activity names to name the activities in the data set.
source("name_activities.R")

# 4) Appropriately label the data set with descriptive variable names.
source("label_data.R")

# 5) From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.
source("summarize_data.R")
