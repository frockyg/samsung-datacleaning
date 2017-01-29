setwd("C:/Users/Fionnuala/datasciencecoursera/Getting_and_Cleaning_Data/")


library(data.table)
library(dplyr)

if(!file.exists("./Assignment")){dir.create("./Assignment")}

fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile = "./Assignment/UCI HAR Dataset.zip")
unzip(zipfile="./Assignment/UCI HAR Dataset.zip")



#Task 1. Merges the training and the test sets to create one data set.
#mergexdata is a data frame comtaining merged data from the X_train and X_test files.
xtraindata<-read.table(file="./Assignment/UCI HAR Dataset/train/X_train.txt",header=FALSE)
xtestdata<-read.table(file="./Assignment/UCI HAR Dataset/test/X_test.txt",header=FALSE)

mergexdata<-rbind(xtraindata,xtestdata)

#Task 2 Extracts only the measurements on the mean and standard deviation for each measurement.
#read the dile "features.txt" and identify rows containing text strings "mean()" and "std()".
#Merge to create a single vector, subsetseries.
#subsetseries is used to  extract relevant columns from mergexdata  
#and produce dataframe meanstddata which only contains the measurements 
#on the mean and standard deviation for each measurement

features<-read.table(file="./Assignment/UCI HAR Dataset/features.txt",header=FALSE)

meanvec<-filter(features, grepl('mean()', features$V2))
stdvec<-filter(features, grepl('std()', features$V2))
meanvec_id<-data.frame(meanvec$V1)
meanvec_id<-rename(meanvec_id,V1=meanvec.V1)
stdvec_id<-data.frame(stdvec$V1)
stdvec_id<-rename(stdvec_id,V1=stdvec.V1)
  subsetseries<-rbind(meanvec_id,stdvec_id)$V1
  meanstddata<-mergexdata[,subsetseries] #output for step 2

#Task 3. Uses descriptive activity names to name the activities in the data set
#mergeydata is a data frame containing merged data from the Y_train and Y_test files 
#where we have added the descriptive activity labels.
#meanstdwithlable is a dataframe which has a column "Activity" which describes the activity performed in each row

ytraindata<-read.table(file="./Assignment/UCI HAR Dataset/train/Y_train.txt",header=FALSE)
ytestdata<-read.table(file="./Assignment/UCI HAR Dataset/test/Y_test.txt",header=FALSE)

mergeydata<-rbind(ytraindata,ytestdata)
mergeydata[mergeydata==1]<-"WALKING"
mergeydata[mergeydata==2]<-"WALKING_UPSTAIRS"
mergeydata[mergeydata==3]<-"WALKING_DOWNSTAIRS"
mergeydata[mergeydata==4]<-"SITTING"
mergeydata[mergeydata==5]<-"STANDING"
mergeydata[mergeydata==6]<-"LAYING"
mergeydata<-rename(mergeydata,activity=V1)

  meanstdwithlable<-cbind(mergeydata,meanstddata)

#4. Appropriately labels the data set with descriptive variable names.
#meanstdwithlable column  names are updated with descriptive variable names taken from feature.txt 

meanvec_name<-data.frame(meanvec$V2)
meanvec_name<-rename(meanvec_name,V1=meanvec.V2)
stdvec_name<-data.frame(stdvec$V2)
stdvec_name<-rename(stdvec_name,V1=stdvec.V2)
subsetseriesnames<-rbind(meanvec_name,stdvec_name)$V1
subsetseriesnames <- data.frame(lapply(subsetseriesnames, as.character), stringsAsFactors=FALSE)
seriesnames<-names(subsetseriesnames)
  setnames(meanstdwithlable, old = names(meanstddata), new = seriesnames)

#5 From the data set in step 4, creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.
# Merge the training and the test sets subject data to create one data set.
#mergexdata is a data frame comtaining merged data from the X_train and X_test files.
# aggregate data frame meanstdwithsubjectandactivity by subject and activity, returning means
# for numeric variables

subjecttraindata<-read.table(file="./Assignment/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
subjecttestdata<-read.table(file="./Assignment/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
mergesubjectdata<-rbind(subjecttraindata,subjecttestdata)
mergesubjectdata<-rename(mergesubjectdata,subject=V1)
meanstdwithsubjectandactivity<-cbind(mergesubjectdata,meanstdwithlable)

  aggdata <-aggregate(meanstdwithsubjectandactivity, by=list(meanstdwithsubjectandactivity$subject,meanstdwithsubjectandactivity$activity), FUN=mean, na.rm=TRUE)
  #remove subject and activity columns
  aggdata<-select(aggdata,-(subject:activity))
  #rename the grouping columns to subject and activity
  aggdata<-rename(aggdata,subject=Group.1,activity=Group.2)

write.table(aggdata,"./Assignment/SummaryMeans.txt",row.name=FALSE)
