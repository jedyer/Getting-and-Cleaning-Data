## Getting and Cleaning Data Project

Jason Dyer

## Overview

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.  The goal is to prepare tidy data that can be used later for analysis.

The data can be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Background information regarding the data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Project Summary

The R script run_analysis.R does the following:
    1.  Load required packages	
    2.  Merges the training and the test sets to create one data set.
    3.  Extracts only the measurements on the mean and standard deviation for each measurement.
    4.  Uses descriptive activity names to name the activities in the data set
    5.  Appropriately labels the data set with descriptive variable names.
    6.  From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Additional Information

You can find additional information about variables and data transformation in the CodeBook.MD file
