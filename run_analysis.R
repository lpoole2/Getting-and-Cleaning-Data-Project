#download and unzip the file
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files

#read the activity, subject and features files from the data
dataActivityTest <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE) 
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

#look at the properties from the variables
str(dataActivityTest)
str(dataActivityTrain)
str(dataSubjectTrain)
str(dataSubjectTest)
str(dataFeaturesTest)
str(dataFeaturesTrain)

#integrate the data 
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#name variable
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

#merge data
dataCombine <- cbind(dataSubject, dataActivity)
Tiny <- cbind(dataFeatures, dataCombine)

#subset data awith mean or standard deviation
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#subset the data by features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Tiny<-subset(Tiny,select=selectedNames)

#check properties of data
str(Tiny)

#read the activity names
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

#check the activity names
head(Tiny$activity,30)

#name the data set
names(Tiny)<-gsub("^t", "time", names(Tiny))
names(Tiny)<-gsub("^f", "frequency", names(Tiny))
names(Tiny)<-gsub("Acc", "Accelerometer", names(Tiny))
names(Tiny)<-gsub("Gyro", "Gyroscope", names(Tiny))
names(Tiny)<-gsub("Mag", "Magnitude", names(Tiny))
names(Tiny)<-gsub("BodyBody", "Body", names(Tiny))

#check the names in data
names(Tiny)

#create and output second data set
library(plyr);
Tinier<-aggregate(. ~subject + activity, Tiny, mean)
Tinier<-Tinier[order(Tinier$subject,Tinier$activity),]
write.table(Tinier, file = "tinydata.txt",row.name=FALSE)

#create and output codebook
library(knitr)
knit2html("codebook.md")