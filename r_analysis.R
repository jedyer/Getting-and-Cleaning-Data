library(tidyverse)
library(reshape2)
library(data.table)

#Download and unzip file
if(!file.exists("./UCI HAR Dataset")){
  URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(URL,destfile="./zipfile.zip")
  unzip("./zipfile.zip",files = NULL, list = FALSE, overwrite = TRUE,junkpaths = FALSE, exdir = ".", unzip = "internal",
        setTimes = FALSE)
}

#Load test sets
x_test<- read.csv("./UCI HAR Dataset/test/X_test.txt",sep="",header= FALSE)
y_test<- read.csv("./UCI HAR Dataset/test/Y_test.txt",sep="",header= FALSE)
s_test<- read.csv("./UCI HAR Dataset/test/subject_test.txt",sep="",header= FALSE)

#Load training sets
x_train<- read.csv("./UCI HAR Dataset/train/X_train.txt",sep="",header= FALSE)
y_train<- read.csv("./UCI HAR Dataset/train/Y_train.txt",sep="",header= FALSE)
s_train<- read.csv("./UCI HAR Dataset/train/subject_train.txt",sep="",header= FALSE)

#Merge test and training sets
merge_x<-rbind(x_test,x_train)
merge_y<-rbind(y_test,y_train)
merge_s<-rbind(s_test,s_train)

#Add feature names to merge_x
features<- read.csv("./UCI HAR Dataset/features.txt",sep="",header= FALSE,colClasses = c("character"))
names(merge_x)<- features$V2

#Select mean and standard mergdeviation columns only
subset_x<- merge_x[,grep("mean|std",colnames(merge_x))]

#Add Activity Name to merge_y
activity<- read.csv("./UCI HAR Dataset/activity_labels.txt",sep="",header= FALSE)
merge_y<-left_join(merge_y,activity,by="V1")

#Rename merge_y & merge_s column names
names(merge_y) <-c("ActivityID","ActivityName")
names(merge_s) <-"SubjectID"

#Combine all datasets into one dataset
combined<- cbind(merge_s,merge_y,subset_x)

#Convert to tidydata
labels_all<-c("SubjectID","ActivityID","ActivityName")
measurements<-names(-combined[,!names(combined) %in% labels_all])
melted_data<-melt(combined,id.vars=labels_all,measure.vars=measurements,na.rm=TRUE)
tidy<-dcast(melted_data,SubjectID+ActivityName~variable,fun=mean)

#Export tidydata
write.table(tidy,file="./tidy_data.txt",row.names=FALSE)




                   