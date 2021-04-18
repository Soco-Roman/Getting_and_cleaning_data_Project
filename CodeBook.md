# Introducction
This repository contains a tidy dataset which is a dataset that had been merged, cleand and filtered according to certain contidions.
The run_analysis.R file describes the process to obtain this tidy dataset and all the calculations performed to get the desired information.

# Data
The data used contains the following information:
- X_train.txt: Training dataset
- Y_test.txt: Test dataset
- y_train: Training labels
- y_test: Test labels
- features: Names of variables
- activity_labels: Activity names
- subject_train: Subject who perform the activity
- subject_test: Subject who perform the activity

# Process
1. Merges the training and the test sets to create one data set.

Merge the training and test datasets into only one by the rbind() function. The y_train and y_test were merged as well to create a dataset with all the information about the activities.
In the same line, the subject_train and subject_test were merged to create a dataset with information about the subjects. 

2. Extracts only the measurements on the mean and standard deviation for each measurement.  

Columns with mean and standard deviation were selected taking the features dataset and reassingning this into the merged dataset.

3. Uses descriptive activity names to name the activities in the data set

Then, the activity names were replaced according to the correct and accurate names.

4. Appropriately labels the data set with descriptive variable names. 

With the gsub() function the patterns were replaced obtaing more understandable names

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final tidy dataset took the resulted datased in the previous step to calculated the mean for each variable according to subject and activity name. With the group_by() fuction, the data set was groupped according to subject and activity name. To calculate the mean in each variable we used the summarize_all() function. 

