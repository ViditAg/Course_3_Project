library(dplyr)
library(Hmisc)
#Url for data source
Dataurl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#download the zip file
download.file(Dataurl,destfile ='Project_Data.zip')
#Unzip data
unzip('Project_Data.zip')
# load features table
featuresList<-read.table('./UCI HAR Dataset/features.txt',col.names=c('id','feature_name'))
# load activity label data
ActivityLabels<-read.table('./UCI HAR Dataset/activity_labels.txt',col.names=c('label','activity'))
# load tables for features data, subject data, activity data
# load test data:  
test_features_data<-read.table('./UCI HAR Dataset/test/X_test.txt',col.names=featuresList[,2])
test_subject<-read.table('./UCI HAR Dataset/test/subject_test.txt',col.names='subject_id')
test_activity_data<-read.table('./UCI HAR Dataset/test/Y_test.txt',col.names='activity_label')
# load training data
train_features_data<-read.table('./UCI HAR Dataset/train/X_train.txt',col.names=featuresList[,2])
train_subject<-read.table('./UCI HAR Dataset/train/subject_train.txt',col.names='subject_id')
train_activity_data<-read.table('./UCI HAR Dataset/train/Y_train.txt',col.names='activity_label')
# Step 1. Merge train and test data
Combined_features<-rbind(train_features_data,test_features_data)
Combined_subject<-rbind(train_subject,test_subject)
Combined_activity<-rbind(train_activity_data,test_activity_data)
# Adding column for activity description for all rows
Combined_activity<-mutate(Combined_activity,Activity=factor(activity_label,labels=ActivityLabels[,2]))
Combined_activity$activity_label<-NULL
# subject id array
subjects<-unique(Combined_subject)
subjects<-subjects[order(subjects,decreasing=FALSE),]
# Extract columns with data for mean and std of different features
MeanStdIndex<-grep("+mean|std",names(Combined_features))
# Exclude index with meanFreq
MeanStdIndex<-MeanStdIndex[MeanStdIndex%in%grep("+meanFreq+",names(Combined_features),invert=TRUE)]
MeanStd_Features<-names(Combined_features)[MeanStdIndex]
# Features data with columns as mean and std for activities
MeanStd_Data<-Combined_features[,MeanStd_Features]
# Add columns for subject_id and Activity_label
MeanStd_Data<-cbind(MeanStd_Data,Combined_subject,Combined_activity)
# Group data by Activity and subjects
activity_group<-group_by(MeanStd_Data,Activity,subject_id)
# get mean for grouped data for every feature
# This final data is for each Activity and subject
#And I calculated mean for each of the 66 features
Tidy_data<-summarise_all(activity_group,mean)
write.table(Tidy_data,file="Tidy_data.txt",row.name=FALSE)
