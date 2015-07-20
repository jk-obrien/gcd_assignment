# Project Description

The files in this repository were submitted to meet the requirements for the
course project in the "Getting and Cleaning Data" module of the Coursera [Data 
Science](https://www.coursera.org/specialization/jhudatascience/1) specialization.

The general aim of the assignment is to read various datafiles, arrange the data
therein according to the principles of tidy data and to create a summary table 
from that tidy data.

To use this software download the data (see below) into the same directory as
the R scripts and then call

> R --slave < run_analysis.R

The scipt requires the CRAN packages data.table, dplry and tidyr.

The script file is fully commented, giving a detailed description of how it 
works. The basic outline is this:

1. Downloads the project data zip file and unzips it.
2. Reads the data files then merges the training and test sets.
3. Labels the data set variables.
4. Replaces the activity codes in the data with descriptive text labels.
5. Selects a subset of the data set variables.
6. Reshapes the data into long format and produces averages of every feature. 

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
