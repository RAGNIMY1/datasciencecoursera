# GettingCleaningData_W4Project
__CODE BOOK__

# RAW DATA
The data used for the project is collected from the sensor signals (accelerometer and gyroscope) of the Samsung Galaxy S smartphone carried by 30 volunteers (aka subjects) performing activities like walking, laying, staying....
The obtained dataset has been randomly partitioned into two sets, generating the training data and the test data.
* Location : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following files, extracted from the zipped raw dataset, are used in the data transformation process:

FILE NAME | SHORT DESCRIPTION | DIMENSION
--------- | ----------------- | ---------
activity_labels.txt | list of activities performed by the subjects | 6 obd. 2 variables (activity code [1..6], activity name [WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING])
features.txt | labels of the 3-axial linear acceleration and 3-axial angular velocity measurements          | 561 obs. 2 variables (feature id, feature name)
test/subject_test.txt   | contains the identification of the subjects for the experiments reported in the test dataset | 2947 obs. 1 variable (subject id)
train/subject_train.txt | contains the identification of the subjects for the experiments reported in the train dataset| 7352 obs. 1 variable (subject id)
test/X_test.txt         | contains the measurements by feature for the experiments reported in the test dataset        | 2947 obs. 561 variables (1 variable by feature)
train/X_train.txt       | contains the measurements by feature for the experiments reported in the train dataset       | 7352 obs. 561 variables (1 variable by feature)
test/y_test.txt         | contains the activity list for the experiments reported in the test dataset                  | 2947 obs. 1 variable (activity code)     
train/y_train.txt       | contains the activity list for the experiments reported in the train dataset                 | 7352 obs. 1 variable (activity code)    


# DATA TRANSFORMATION
## REQUIRED PACKAGES
dplyr

## PROCESS STEPS

1. Preparation
 * Set the working environment
 * Download and unzip the raw datafile
 * Read all the files used in the transformation process and load the data into single data frames
 
 <table>
  <tbody>
    <tr>
      <th>FILE NAME</th>
      <th>DATA FRAME NAME AND STRUCTURE</th>
    </tr>
    <tr>
      <td>activity_labels.txt</td>
      <td>Activity<br>6 obs. of  2 variables: <br>$ activity: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1<br/></td>
    </tr>
	<tr>
      <td>features.txt</td>
      <td>Featuredata<br>'data.frame':	561 obs. of  2 variables: <br>$ featureid: int  1 2 3 4 5 6 7 8 9 10 ...<br>$ feature  : Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...	<br/></td>
    </tr>
    <tr>
      <td>test/subject_test.txt</td>
      <td>SubjectTest<br>'data.frame':	2947 obs. of  1 variable:<br>$ subjectid: int  2 2 2 2 2 2 2 2 2 2 ...  <br/></td>
    </tr>
	<tr>
	 <td>subject_train.txt</td>
	 <td>SubjectTrain<br>'data.frame': 7352 obs. of  1 variable:<br>$ subjectid: int  1 1 1 1 1 1 1 1 1 1 ... <br/><td/>
	<tr/>
  </tbody>
</table>
 
     X_test.txt              |FeatureTest
                             |'data.frame':	2947 obs. of  561 variables: (extract below)
                             |$ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
                             |$ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
                             |$ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
                             |$ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
                             |$ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
     X_train.txt             |FeatureTrain
                             |data.frame':	7352 obs. of  561 variables: (extract below)
                             |$ tBodyAcc-mean()-X                   : num  0.289 0.278 0.28 0.279 0.277 ...
                             |$ tBodyAcc-mean()-Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
                             |$ tBodyAcc-mean()-Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
                             |$ tBodyAcc-std()-X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
                             |$ tBodyAcc-std()-Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
     y_test.txt              |ActivityTest
                             |'data.frame':	2947 obs. of  1 variable:
                             |$ actcode: int  5 5 5 5 5 5 5 5 5 5 ...
     y_train.txt             |ActivityTrain
                             |'data.frame':	7352 obs. of  1 variable:
                             |$ actcode: int  5 5 5 5 5 5 5 5 5 5 ...
						
2. Merge the single dataframes into one dataframe combining the subject id, the activity id and all the measurements of all the features. This is done in three steps:
   * Merge the Subject Test and Train datasets by row into the SubjectAll data frame
   * Merge the Feature Test and Train datasets by row into the FeatureAll data frame
   * Merge the Activity Test and Train datasets by row into the ActivityAll data frame
   * Merge the SubjectAll, FeatureAll and ActivityAll datasets by column into the AllData data frame
   
     DATA FRAME NAME  |STRUCTURE               
     ---------------- | --------------------------------------------------------------------------------------
     SubjectAll       |'data.frame':	10299 obs. of  1 variable:
                      |$ subjectid: int  2 2 2 2 2 2 2 2 2 2 ...				
     FeatureAll       |'data.frame':	10299 obs. of  561 variables: (extract below)
                      |$ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
                      |$ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
                      |$ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
                      |$ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
                      |$ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
     ActivityAll      |'data.frame':	10299 obs. of  1 variable:
                      |$ actcode: int  5 5 5 5 5 5 5 5 5 5 ...
	 AllData          |'data.frame':	10299 obs. of  563 variables:
                      |$ subjectid                           : int  2 2 2 2 2 2 2 2 2 2 ...
                      |$ actcode                             : int  5 5 5 5 5 5 5 5 5 5 ...
                      |$ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
                      |$ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
                      |$ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
                      |$ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
                      |$ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...			  

3. Extract only the measurements on the mean and standard deviation for each measurement
   The TidyData data frame is a subset of the dataset AllData and contains the variables:
   * subjectid (identification of the subject)
   * actcode (activity code)
   * the measurement of the features that contain the expression "mean()" or "std()"
   
     DATA FRAME NAME  |STRUCTURE               
     ---------------- | --------------------------------------------------------------------------------------
     TidyData         | 'data.frame':	10299 obs. of  68 variables: (extract below)
                      | $ subjectid                  : int  2 2 2 2 2 2 2 2 2 2 ...
                      | $ actcode                    : int  5 5 5 5 5 5 5 5 5 5 ...
                      | $ tBodyAcc-mean()-X          : num  0.257 0.286 0.275 0.27 0.275 ...
                      | $ tBodyAcc-mean()-Y          : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
                      | $ tBodyAcc-mean()-Z          : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...

4. Replace the activity codes by descriptive activity names read from the "activity_labels.txt" (Activity data frame)

5. Label the data set with descriptive variable names
   I've applied the following best practices:
   * Make variable names human readable, reflecting the content
   * Convert all variable names to lower case.
   Therefore:    
   * acc was replaced by accelerometer 
   * gyro was replaced by gyroscope
   * bodybody was replaced by body
   * prefix f was replaced by frequency
   * prefix t was replaced by time
   * mean() was replaced by mean
   * std() was replaced by std
   * mag was replaced by magnitude
   * actcode was replaced by activity

6. Based on the data frame created in step 5., create an independent tidy data set with the average of each variable for each activity and each subject
   The final tidy dataset is obtained by calculating the average for all feature columns by subject and activity - this is achieved with the summarize_all and group_by functions.
   Finally the data is exported to a txt file.

# TIDY DATASET STRUCTURE
  The output file has 180 rows and 68 columns.
  Column 1      | subjectid = the identification of the test subject
                |             values: 1..30
  Column 2      | activity =  the type of activity performed when the corresponding measurements were taken 
                |             values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
  Columns 3:68  | the measurement of the selected features
				| 	timebodyaccelerometer-mean-x
				| 	timebodyaccelerometer-mean-y
				| 	timebodyaccelerometer-mean-z
				| 	timegravityaccelerometer-mean-x
				| 	timegravityaccelerometer-mean-y
				| 	timegravityaccelerometer-mean-z
				| 	timebodyaccelerometerjerk-mean-x
				| 	timebodyaccelerometerjerk-mean-y
				| 	timebodyaccelerometerjerk-mean-z
				| 	timebodygyroscope-mean-x
				| 	timebodygyroscope-mean-y
				| 	timebodygyroscope-mean-z
				| 	timebodygyroscopejerk-mean-x
				| 	timebodygyroscopejerk-mean-y
				| 	timebodygyroscopejerk-mean-z
				| 	timebodyaccelerometermagnitude-mean
				| 	timegravityaccelerometermagnitude-mean
				| 	timebodyaccelerometerjerkmagnitude-mean
				| 	timebodygyroscopemagnitude-mean
				| 	timebodygyroscopejerkmagnitude-mean
				| 	frequencybodyaccelerometer-mean-x
				| 	frequencybodyaccelerometer-mean-y
				| 	frequencybodyaccelerometer-mean-z
				| 	frequencybodyaccelerometerjerk-mean-x
				| 	frequencybodyaccelerometerjerk-mean-y
				| 	frequencybodyaccelerometerjerk-mean-z
				| 	frequencybodygyroscope-mean-x
				| 	frequencybodygyroscope-mean-y
				| 	frequencybodygyroscope-mean-z
				| 	frequencybodyaccelerometermagnitude-mean
				| 	frequencybodyaccelerometerjerkmagnitude-mean
				| 	frequencybodygyroscopemagnitude-mean
				| 	frequencybodygyroscopejerkmagnitude-mean
				| 	timebodyaccelerometer-std-x
				| 	timebodyaccelerometer-std-y
				| 	timebodyaccelerometer-std-z
				| 	timegravityaccelerometer-std-x
				| 	timegravityaccelerometer-std-y
				| 	timegravityaccelerometer-std-z
				| 	timebodyaccelerometerjerk-std-x
				| 	timebodyaccelerometerjerk-std-y
				| 	timebodyaccelerometerjerk-std-z
				| 	timebodygyroscope-std-x
				| 	timebodygyroscope-std-y
				| 	timebodygyroscope-std-z
				| 	timebodygyroscopejerk-std-x
				| 	timebodygyroscopejerk-std-y
				| 	timebodygyroscopejerk-std-z
				| 	timebodyaccelerometermagnitude-std
				| 	timegravityaccelerometermagnitude-std
				| 	timebodyaccelerometerjerkmagnitude-std
				| 	timebodygyroscopemagnitude-std
				| 	timebodygyroscopejerkmagnitude-std
				| 	frequencybodyaccelerometer-std-x
				| 	frequencybodyaccelerometer-std-y
				| 	frequencybodyaccelerometer-std-z
				| 	frequencybodyaccelerometerjerk-std-x
				| 	frequencybodyaccelerometerjerk-std-y
				| 	frequencybodyaccelerometerjerk-std-z
				| 	frequencybodygyroscope-std-x
				| 	frequencybodygyroscope-std-y
				| 	frequencybodygyroscope-std-z
				| 	frequencybodyaccelerometermagnitude-std
				| 	frequencybodyaccelerometerjerkmagnitude-std
				| 	frequencybodygyroscopemagnitude-std
				| 	frequencybodygyroscopejerkmagnitude-std
