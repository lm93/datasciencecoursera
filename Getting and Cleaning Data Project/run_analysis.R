##This script presumes that the "UCI HAR Dataset" folder is in your current working directory
##Read all relevant files into R

#Get necessary packages
library(plyr)

setwd("UCI HAR Dataset/")
activityLabels <- read.table("activity_labels.txt", header = FALSE)
names(activityLabels) <- c("activityCode", "activityDesc")

features <- read.table("features.txt", header = FALSE)

setwd("test/")
test <- read.table("X_test.txt", header = FALSE)
testActivity <- read.table("y_test.txt", header = FALSE)
testSubject <- read.table("subject_test.txt", header = FALSE)

setwd("../train/")
train <- read.table("X_train.txt", header = FALSE)
trainActivity <- read.table("y_train.txt", header = FALSE)
trainSubject <- read.table("subject_train.txt", header = FALSE)

setwd("..")
setwd("..") ##Back in default working directory

##Label column names according to feature vector descriptions
names(test) <- features[,2]
names(train) <- features[,2]
rm(features)

##Append activityCode column
test["activityCode"] <- testActivity
train["activityCode"] <- trainActivity

#Rearrange columns
test <- test[c(562,1:561)]
train <- train[c(562,1:561)]


##Append subjectCode column
test["subjectCode"] <- testSubject
train["subjectCode"] <- trainSubject

##Append activityDesc matching activityCode
test <- merge(test, activityLabels, by="activityCode")
train <- merge(train, activityLabels, by="activityCode")

##Rearrange columns
test <- test[c(563,1,564,2:562)]
train <- train[c(563,1,564,2:562)]

rm(testActivity)
rm(trainActivity)

rm(testSubject)
rm(trainSubject)

rm(activityLabels)


##Merges training and test sets to create one data set
tidyData <- rbind(train, test)

##Arrange data by subjectCode, then by activityCode
tidyData <- arrange(tidyData, tidyData$subjectCode)

##Obtain columns that contain data on mean or standard deviation
col_mean <- grep("mean", names(tidyData))
col_std <- grep("std", names(tidyData))
col_extract <- c(1,2,3,col_mean, col_std)
col_extract <- sort(col_extract) ##Make sure that the columns retain the same order

tidyDataMeanStd <- tidyData[col_extract]


rm(col_mean)
rm(col_std)
rm(col_extract)


##Create the data set that is grouped by subject and activity, calculating the mean for other variables that were extracted
##for tidyDataMeanStd data set (e.g. averages for subject 1 when WALKING, etc.)

tidyDataMeanStd_Grouped <- ddply(tidyDataMeanStd, .(subjectCode, activityCode, activityDesc), numcolwise(mean))


##Comment this code out if you need to manipulate tidy "test" and "train" data sets
rm(test)
rm(train)


