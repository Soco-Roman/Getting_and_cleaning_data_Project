# Libraries
library(tidyverse)
# Download the zip dataset
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
if(!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, "./Project/getdata_projectfiles_UCI HAR Dataset.zip")
}
if(!file.exists("UCI HAR Dataset")){ 
  unzip(filename) 
}

###---- Load the complete data----

# read feature files
X_training <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

# read activity files
Y_training <- read.table("./UCI HAR Dataset/train/y_train.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# read subject files
s.training <- read.table("./UCI HAR Dataset/train/subject_train.txt")
s.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read activity labels
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# read features
features <- read.table("./UCI HAR Dataset/features.txt")

###---- Merge datasets ----
# Merge training and test dataset
merge.traing.test <- rbind(X_training, X_test)

# Merge activity datasets
merge.activity.data <- rbind(Y_training, Y_test)

# Merge subject data
merge.subject.data <- rbind(s.training, s.test)

# Set names to variables
names(merge.traing.test) <- features$V2
names(merge.activity.data) <- "activity"
names(merge.subject.data) <- "subject"

# Merge all data in one dataset

complete.Data <- cbind(merge.traing.test, merge.activity.data, merge.subject.data)

###---- Extracts only the measurements on the mean and standard deviation for each measurement ----

# Obtain only columns where the name is mean or std
mean_std_features <- features$V2[grep("mean\\(\\) |std\\(\\)", features$V2)]

# Subset the desired columns

subsetColums <- c(as.character(mean_std_features), "subject", "activity")
complete.Data <- subset(complete.Data, select =subsetColums)

###---- Uses descriptive activity names to name the activities in the data set ----

# rename values with the correct activity names
complete.Data$activity <- activity.labels[complete.Data$activity, 2]

###---- Appropriately labels the data set with descriptive variable names ----

# Adjust names
names(complete.Data) <- gsub("^t", "time", names(complete.Data))
names(complete.Data) <- gsub("^f", "frequency", names(complete.Data))
names(complete.Data) <- gsub("Acc", "Accelerometer", names(complete.Data))
names(complete.Data) <- gsub("Gyro", "Gyroscope", names(complete.Data))
names(complete.Data) <- gsub("Mag", "Magnitude", names(complete.Data))
names(complete.Data) <- gsub("BodyBody", "Body", names(complete.Data))

###---- From the data set in step 4, creates a second, independent tidy 
### data set with the average of each variable for each activity and each subject ----

# Obtain the mean for each variable, activity and subject

tidy.Data <- complete.Data %>% 
  group_by(activity, subject) %>% ## group by activity and subject
  summarise_all(funs(mean)) ## calculate mean for each column

write.table(tidy.Data, "tidy.Dataset.txt", row.names = FALSE)
