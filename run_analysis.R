#Unzip data set
 unzip(zipfile="./data/Dataset.zip",exdir="./data")
#Load requiered package
library(dplyr)
library(dplyr)
library(data.table)
#Read files of folder 'UCI HAR Dataset' and create tables
 filesPath <- "C:\\Users\\MiguelAngel\\Downloads\\UCI HAR Dataset"
#Read Subject Files
 dataSubjectTrain <- tbl_df(read.table(file.path(filesPath, "train", "subject_train.txt")))
 dataSubjectTest <- tbl_df(read.table(file.path(filesPath, "test", "subject_test.txt")))
#Read Activity Files
 dataActivityTrain <- tbl_df(read.table(file.path(filesPath, "train", "Y_train.txt")))
 dataActivityTest <- tbl_df(read.table(file.path(filesPath, "test", "Y_test.txt")))
#Read Data Files
dataTrain <- tbl_df(read.table(file.path(filesPath, "train", "X_train.txt" )))
dataTest  <- tbl_df(read.table(file.path(filesPath, "test" , "X_test.txt" )))
#Merges the training and the test sets to create data set
alldataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(alldataSubject, "V1", "subject")
alldataActivity<- rbind(dataActivityTrain, dataActivityTest)
setnames(alldataActivity, "V1", "activityNum")
#Combine  the Data training and test files
dataTable <- rbind(dataTrain, dataTest)
#Name variables according to feature
dataFeatures <- tbl_df(read.table(file.path(filesPath, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(dataTable) <- dataFeatures$featureName
#Column names for activity labels
activityLabels<- tbl_df(read.table(file.path(filesPath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))
#Merge Columns
alldataSubjAct<- cbind(alldataSubject, alldataActivity)
dataTable <- cbind(alldataSubjAct, dataTable)
#Extracts the measurements on the mean and standard deviation for each measurement
dataFeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",dataFeatures$featureName,value=TRUE) #var name
dataFeaturesMeanStd <- union(c("subject","activityNum"), dataFeaturesMeanStd)
dataTable<- subset(dataTable,select=dataFeaturesMeanStd) 
#Uses descriptive activity names to name the activities in the data set
dataTable <- merge(activityLabels, dataTable , by="activityNum", all.x=TRUE)
dataTable$activityName <- as.character(dataTable$activityName)
dataTable$activityName <- as.character(dataTable$activityName)
dataAggr<- aggregate(. ~ subject - activityName, data = dataTable, mean) 
dataTable<- tbl_df(arrange(dataAggr,subject,activityName))
#Appropriately labels the data set with descriptive variable names
head(str(dataTable),2)
names(dataTable)<-gsub("std()", "SD", names(dataTable))
names(dataTable)<-gsub("mean()", "MEAN", names(dataTable))
names(dataTable)<-gsub("^t", "time", names(dataTable))
names(dataTable)<-gsub("^f", "frequency", names(dataTable))
names(dataTable)<-gsub("Acc", "Accelerometer", names(dataTable))
names(dataTable)<-gsub("Gyro", "Gyroscope", names(dataTable))
names(dataTable)<-gsub("Mag", "Magnitude", names(dataTable))
names(dataTable)<-gsub("BodyBody", "Body", names(dataTable))
head(str(dataTable),6)
#From de data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
write.table(dataTable, "TidyData.txt", row.name=FALSE)
