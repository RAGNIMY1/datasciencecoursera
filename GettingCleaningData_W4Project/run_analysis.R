###################################################################################################################
##  GETTING AND CLEANING DATA - WEEK 4 Project Assignment   
## 31.07.2019
## Author: Myriam Ragni
###################################################################################################################

## ===============================================================================
## Set the environment
## ===============================================================================
library(dplyr)
setwd("c:/RAGNIMY1/datasciencecoursera") 
SrcFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
ProjectDir <- "./GettingCleaningData_W4Project"
DataFileZip <- "Coursera_GettingData_Project.zip"
PathDataFileZip <- paste(ProjectDir,"/",DataFileZip, sep="")

## =================================================================================
## Download and unzip the raw data file
##   Note: See the README.txt file for the detailed information on the dataset. 
##   The following files will be used in this assignement
##     - test/subject_test.txt
##     - test/X_test.txt
##     - test/y_test.txt
##     - train/subject_train.txt
##     - train/X_train.txt
##     - train/y_train.txt
##     - activity_labels.txt
##     - features.txt
## =================================================================================
#### Create the working repository if needed
if (!file.exists(ProjectDir)){
        dir.create(ProjectDir)
}
#### Check if zipped data file was already downloaded, if not, download the file
if (!file.exists(PathDataFileZip)){
                download.file(SrcFileURL, destfile=PathDataFileZip)
}  
#### Check if data folder exists, if not, unzip the data files
if (!file.exists(paste(ProjectDir,"/UCI HAR Dataset", sep=""))) { 
        unzip(PathDataFileZip, exdir=ProjectDir) 
}

## =================================================================================
## Read the data files and load them into data frames
## =================================================================================
pathfiles <- file.path(ProjectDir, "UCI HAR Dataset")
#### Read the Activity and Feature labels
Activity <- read.table(file.path(pathfiles, "activity_labels.txt"))
names(Activity) <- c("actcode", "activity")
Feature <- read.table(file.path(pathfiles, "features.txt"))
names(Feature) <- c("featureid","feature")

#### Read the Subject files from the "test" and "train" datasets
SubjectTest <- read.table(file.path(pathfiles, "test" , "subject_test.txt"))
SubjectTrain <- read.table(file.path(pathfiles, "train" , "subject_train.txt"))
names(SubjectTest) <- "subjectid"
names(SubjectTrain) <- "subjectid"

#### Read the Activity files from the "test" and "train" datasets
ActivityTest <- read.table(file.path(pathfiles, "test" , "y_test.txt"))
ActivityTrain <- read.table(file.path(pathfiles, "train" , "y_train.txt"))
names(ActivityTest) <- "actcode"
names(ActivityTrain) <- "actcode"

#### Read the Features files from the "test" and "train" datasets
FeatureTest <- read.table(file.path(pathfiles, "test" , "X_test.txt"))
FeatureTrain <- read.table(file.path(pathfiles, "train" , "X_train.txt"))
names(FeatureTest) <- Feature$feature
names(FeatureTrain) <- Feature$feature

## =================================================================================
## Merge the training and the test sets to create one data set
## =================================================================================
#### SubjectAll: 10299 obs. of 1 variable
SubjectAll <- rbind(SubjectTest,SubjectTrain,stringsAsFactors=FALSE)
#### FeatureAll: 10299 obs. of 561 variables
FeatureAll <- rbind(FeatureTest,FeatureTrain,stringsAsFactors=FALSE)
#### ActivityAll: 10299 obs. of 1 variable
ActivityAll <- rbind(ActivityTest,ActivityTrain,stringsAsFactors=FALSE)
#### AllData: 10299 obs. 563 vaiables
AllData <- cbind(SubjectAll,ActivityAll,FeatureAll) 

## =================================================================================
## Extract only the measurements on the mean and standard deviation for each 
## measurement --> Select feature columns which names contains "mean()" and "std()"
## =================================================================================
#### TidyData: 10299 obs. of 68 variable
TidyData <- AllData %>%
                subset %>%
                        select(subjectid,actcode, contains("mean()"), contains("std()"))

## =================================================================================
## Use descriptive activity names to name the activities in the data set --> Read
## descriptive activity names from "activity_labels.txt" (Activity data frame)
## =================================================================================
TidyData$actcode <- Activity[TidyData$actcode,2]


## =================================================================================
## Appropriately labels the data set with descriptive variable names
## =================================================================================
#### All variable names are converted to lower case
#### Label for activity variable replaced to reflect content
#### acc is replaced by accelerometer
#### gyro is replaced by gyroscope
#### bodybody is replaced by body
#### prefix f is replaced by frequency
#### prefix t is replaced by time
#### mean() is replaced by mean
#### std() is replaced by std
#### mag is replaced by magnitude
names(TidyData) <- tolower(names(TidyData))
names(TidyData)[2] <- "activity"
names(TidyData) <- gsub("acc","accelerometer",names(TidyData))
names(TidyData) <- gsub("gyro","gyroscope",names(TidyData))
names(TidyData) <- gsub("bodybody","body",names(TidyData))
names(TidyData) <- gsub("^f","frequency",names(TidyData))
names(TidyData) <- gsub("^t","time",names(TidyData))
names(TidyData) <- gsub("mean\\(\\)","mean",names(TidyData))
names(TidyData) <- gsub("std\\(\\)","std",names(TidyData))
names(TidyData) <- gsub("mag","magnitude",names(TidyData))

## =================================================================================
## Create an independent tidy data set with the average of each variable for 
## each activity and each subject
## =================================================================================
CleanData <- TidyData %>% group_by(subjectid,activity) %>%
        summarize_all(list(mean))
write.table(CleanData, file=file.path(ProjectDir,"CleanData.txt"),row.names=FALSE)
