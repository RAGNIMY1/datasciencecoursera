# GettingCleaningData_W4Project
Getting and Cleaning Data Course Project

#  PURPOSE
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

# DATASET
__Human Activity Recognition Using Smartphones__ : built from the recordings of 30 subjects performing activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while carrying a waist-mounted smartphone with embedded inertial sensors. The obtained dataset has been randomly partitioned into two sets, generating the training data and the test data

# FILES
The project repository contains the following files:
* __run_analysis.R__ : R script that performs the following actions as per project specifications:
   * Merges the training and the test sets to create one data set
   * Extracts only the measurements on the mean and standard deviation for each measurement
   * Uses descriptive activity names to name the activities in the data set
   * Appropriately labels the data set with descriptive variable names
   * Creates a tidy dataset with the average of each variable for each activity and each subject.
* __CodeBook.md__ : a code book that describes the variables, the data, and any transformations or work performed to clean up the data 
* __CleanData.txt__ : the exported final tidy data
* __CleanData.xls__ : the final tidy data in Excel format
