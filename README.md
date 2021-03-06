# Project Description

The files in this repository were submitted to meet the requirements for the
course project in the "Getting and Cleaning Data" module of the Coursera [Data
Science](https://www.coursera.org/specialization/jhudatascience/1) specialization.

The general aim of the assignment is to read various data files, arrange the 
data therein according to the principles of tidy data and to create a summary table from that tidy data.

The data are available in zip format from this address:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

If you have a working internet connection, the script will download and unpack
the data files it needs itself. If you do not have an internet connection or, if
for some reason the script fails at that step, you can download the file from
the above address (from another computer that does have internet connection if
need be) and copy it to your computer. If you do have to download the data
yourself, you should call the script from the same directory that holds the 
data.

Then, to use this software call:

> R --slave < run_analysis.R

The scipt uses the following CRAN packages (and versions):

* data.table v1.9.4 
* dplry v0.4.2
* tidyr v0.2.0

The script file is fully commented, giving a detailed description of how it
works. The basic outline is this:

1. Downloads the project data zip file and unzips it.
2. Reads the data files into memory then merges the training and test sets.
3. Labels the data set variables (columns) with meaningful names.
4. Replaces the activity codes in the data with descriptive text labels.
5. Selects the subset of the data set variables that hold means and standard
   deviations.
6. Produces averages of those variables, grouped by subject and activity.
7. Reshapes the data into long format, using subject_id, activity and feature as
   key variables and the average mean and average standard deviation columns as values.
8. Saves the output of step 7 into a tab-delimited text file called Final.txt.

The rest of this file gives a description of the scripts and files used in the
project.


## Data Files

The data files were downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The download was unzipped and contained a directory tree of various text files
containing the project data and descriptions of the data. The data files are not
included in the github repository for this project. Only the files relevant to
this project are described here. A full description of the entire dataset can be
read [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


## Project Files

* run_analysis.R - The R script that does the work.
* README.md      - This file.
* .git           - The directory used by the version control software git.
* .gitignore     - A list of files not covered by git.
* CodeBook.txt   - A description of the variables in the final data set.
* Final.txt      - The data produced as an end result of this assignment.
