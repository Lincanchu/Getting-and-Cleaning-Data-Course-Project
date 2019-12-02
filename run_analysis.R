##Course Project

##load the dplyr package
library(dplyr)

##create directory and then download the dataset 
if(!file.exists("Project_Dataset.zip")) {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "Project_Dataset.zip")
}

##check if folder exists already
if(!file.exists("UCI HAR Dataset")) {
	unzip("Project_Dataset.zip")}

##Create all data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("Number","Functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$Functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$Functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Code")

##Step 1: Merge training and test datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

##Step 2: Extract measurements on mean and standard deviation
Clean_Data <- Merged_Data %>% select(Subject, Code, contains("mean"), contains("std"))

##Step 3: Use descriptive activity names to name activities
Clean_Data$Code <- activities[Clean_Data$Code, 2]

##Step 4: Label dataset with descriptive variable names
names(Clean_Data)[2] = "Activity"
names(Clean_Data)<-gsub("Acc", "Accelerometer", names(Clean_Data))
names(Clean_Data)<-gsub("Gyro", "Gyroscope", names(Clean_Data))
names(Clean_Data)<-gsub("BodyBody", "Body", names(Clean_Data))
names(Clean_Data)<-gsub("Mag", "Magnitude", names(Clean_Data))
names(Clean_Data)<-gsub("^t", "Time", names(Clean_Data))
names(Clean_Data)<-gsub("^f", "Frequency", names(Clean_Data))
names(Clean_Data)<-gsub("tBody", "TimeBody", names(Clean_Data))
names(Clean_Data)<-gsub("-mean()", "Mean", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-std()", "STD", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("-freq()", "Frequency", names(Clean_Data), ignore.case = TRUE)
names(Clean_Data)<-gsub("angle", "Angle", names(Clean_Data))
names(Clean_Data)<-gsub("gravity", "Gravity", names(Clean_Data))

##Step 5: On the basis of Clean_Data, create a second dataset with the average of each variable for each activity and each subject
Second_Dataset <- Clean_Data %>%
    group_by(Subject, Activity) %>%
    summarize_all(funs(mean))
write.table(Second_Dataset, "Second_Dataset.txt", row.name=FALSE)
