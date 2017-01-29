# samsung-datacleaning
Getting and Cleaning Data Course Project - Peer Graded Assignment


One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This repo contains one R script called run_analysis.R that does the following.
1. Downloads zip folder from URL shown above to a folder called Assignment.  Unzips the zip file to a subfolder of Assignment folder called UCI HAR Dataset.

2. Create one data set, mergexdata by merging the training and the test sets from files "./Assignment/UCI HAR Dataset/train/X_train.txt" and "./Assignment/UCI HAR Dataset/test/X_test.txt".

3. From data set, mergexdata, extracts only the measurements on the mean and standard deviation for each measurement.  This filtering is carried out using information obtained in file "./Assignment/UCI HAR Dataset/features.txt". 

4. Uses descriptive activity names to name the activities in the data set.  The activity names are obtained  by merging the training and the test sets activity names from files "./Assignment/UCI HAR Dataset/train/Y_train.txt" and "./Assignment/UCI HAR Dataset/test/Y_test.txt". Descriptive labels are added based on the mapping shown in file: "Assignment\UCI HAR Dataset\activity_labels.txt". meanstdwithlable is a dataframe which has a column "Activity" which describes the activity performed in each row

5. Appropriately labels the data set with descriptive variable names. Data frame meanstdwithlable column  names are updated with descriptive variable names taken from file "Assignment\UCI HAR Dataset\feature.txt".

6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject. aggdata is the dataframe containing the output of this final step and has been stored in file "./Assignment/SummaryMeans.txt".  
