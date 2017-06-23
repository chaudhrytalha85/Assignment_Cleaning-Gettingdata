## Make sure directory conrains Samsung data (unzipped) and set it 
## as Working directory. This script assumes that its downloaded 
## and unzipped.
##
## Load the following packages, which are necessary 
## to run this script: dpylr, data.table
##
library(dplyr)
library(data.table)
##
## Now read the necessary files in the folder, with read.table
##                  
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
##
## Now read files in the test folder
##
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
features_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
##
## Now read files in the train folder
##
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
features_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
##
## Now appropiately assign feature names to the columns in test and train feature tables
##
names(features_test) <- features$V2
names(features_train) <- features$V2
##
## Assign the name 'Activity" to the column in test and train activity tables
##
names(activity_test) <- "Activity"
names(activity_train) <- "Activity"
##
## Assign the names 'Subject' to the column in test and 
## train subject tables
##
names(subject_test) <- "SubjectID"
names(subject_train) <- "SubjectID"
##
## Bind the test and train data together. Start with binding 
## train data in one
## set and test data in another. Then combine them.
##
alltestdata <- cbind(subject_test, activity_test, features_test)
alltraindata <- cbind(subject_train, activity_train, features_train)
alldata <- rbind(alltraindata, alltestdata)
##
## Now subset alldata by extracting columns that are mean and
## standard deviation measurements. Create a character vector
## from the features variable, use it to subset alldata.
##
mean_std <- grep("mean|std", features$V2, value=TRUE)
alldata_sub <- alldata[,c("SubjectID", "Activity", mean_std)]
##
## Now assign each activity value its descriptive name, preceded
## by arranging it by activity
##
act_descr <- alldata_sub %>% arrange(Activity) %>% 
               mutate(Activity= as.character(factor(Activity, 
                         levels=1:6, labels= activity_labels$V2)))
##
## Now rename column names to give them descriptive names for
## easy understanding
##
names(act_descr) <- gsub("tBodyAcc-", "Body Acceleration Signal in Time Domain-", names(act_descr))
names(act_descr) <- gsub("tGravityAcc-", "Gravity Acceleration Signal in Time Domain-", names(act_descr))
names(act_descr) <- gsub("tBodyAccJerk-", "Body Acceleration Jerk Signal in Time Domain-", names(act_descr))
names(act_descr) <- gsub("tBodyGyro-", "Body Gyroscopic Signal in Time Domain-", names(act_descr))
names(act_descr) <- gsub("tBodyGyroJerk-", "Body Gyroscopic Jerk Signal in Time Domain-", names(act_descr))
names(act_descr) <- gsub("tBodyAccMag-", "Magnitude of Body Acceleration Signals in Time Domain from (XYZ) Values-", names(act_descr))
names(act_descr) <- gsub("tGravityAccMag-", "Magnitude of Gravity Acceleration Signals in Time Domain from (XYZ) Values-", names(act_descr))
names(act_descr) <- gsub("tBodyAccJerkMag-", "Magnitude of Body Acceleration Jerk Signals in Time Domain from (XYZ) Values-", names(act_descr))
names(act_descr) <- gsub("tBodyGyroMag", "Magnitude of Body Gyroscopic Signals in Time Domain from (XYZ) Values-", names(act_descr))
names(act_descr) <- gsub("tBodyGyroJerkMag-", "Magnitude of Body Gyroscopic Jerk Signals in Time Domain from (XYZ) Values-", names(act_descr))
names(act_descr) <- gsub("fBodyAcc-", "FFT applied Body Acceleration Signals-", names(act_descr))
names(act_descr) <- gsub("fBodyAccJerk-", "FFT applied Body Acceleration Jerk Signals-", names(act_descr))
names(act_descr) <- gsub("fBodyGyro-", "FFT applied Body Gyroscopic Signals-", names(act_descr))
names(act_descr) <- gsub("fBodyAccMag-", "FFT applied Magnitude of Body Acceleration Signals-", names(act_descr))
names(act_descr) <- gsub("[()]", "", names(act_descr))
names(act_descr) <- 
##
## Now create a data frame which gives mean of all variables, by
## activity by subject
##
tidydata <- act_descr %>% group_by(SubjectID, Activity) %>% 
                            summarise_all(mean)
##
## Write a txt file of tidy data
##
write.table(tidydata, "tidydata.txt", row.names = FALSE)
##
## End of script
##
