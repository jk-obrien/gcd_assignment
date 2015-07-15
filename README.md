# Project Description

The files in this repository were submitted to meet the requirements for the
course project in the "Getting and Cleaning Data" module of the Coursera [Data 
Science](https://www.coursera.org/specialization/jhudatascience/1) specialization.

The general aim of the assignment is to read various datafiles, arrange the data
therein according to the principles of tidy data and to create a summary table 
from that tidy data.

To use this software download the data (see below) into the same directory as
the R scripts and then call

> R < run_analysis.R

The rest of this file gives a description of the scripts and files used in the
project.


## Data Files

The data files were downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The download was unzipped and contained a directory tree of various text files 
containing the project data and descriptions of the data. The data files are not
included in the github repository for this project. Only the files relevant to
this project are described here. A full description of the entire dataset can be
read [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


## Scripts

The following R scripts were used to complete this project.

* run_analysis.R

    This is the main script that calls all other scripts below in turn.
    
    The scripts are really only split up for modularity, there's no reason they
couldn't all be rolled up into one.

    As each script is called by run_analysis.R it creates R objects that remain in the environment for use by subsequent scripts. Each script takes care of tidying up after itself, only leaving behind objects that are needed downstream.
                    
* fetch_data.R

    Downloads and unzips the data files.

* merge_data.R

    Reads the various data files into a single R object.

* subset_data.R

    Extracts the variables required for the project.

* name_activities.R

    Give descriptive names to the activities in the dataset.

* label_data.R

    Assign descriptive labels to the variables in the dataset.

* summarize_data.R

    Produce means of each variable by subject and activity.

## Other files

* README.md    - This file.
* .git         - The directory used by the version control software git.
* .gitignore   - A list of files not covered by git.
* CodeBook.txt - A description of the variables in the final data set.
* Final.txt    - The data produced as an end result of this assignment.

