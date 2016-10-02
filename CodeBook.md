# Getting and Cleaning Data - Week 4 - Codebook

## Data for the excercise  
Data available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      


## The run_analysis.R script performs the following steps to clean the data:   

### Reading and merging training and test data.
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "UCI HAR Dataset/data/train" folder and store them in *x_train*, *y_train* and *subject_train* variables.       
 2. Repeat the same process for the X_test.txt, y_test.txt and subject_test.txt files from the "UCI HAR Dataset/data/test" folder where the variables are *x_test*, *y_test* and *subject_test* variables respectively.  
 3. Merge *x_test* and *x_train* to *x_merged*; Merge *y_test* and *y_train* to *y_merged*; merge *subject_test* and *subject_train* to *subject_merged*.
 
### Mean and standard deviation extraction.
 4. Read features.txt file from the "UCI HAR Dataset/data" folder and store it in *features*.
 5. Storing mean and standard deviation in *measurement_mean_std*  

### Describe activities.
 6. Read the activity_labels.txt file from the "UCI HAR Dataset./data" folder and store the data in *activity*.  
 7. Clean the activity names in the second column of *activity*: All names to lower cases; removing underscores; capitalizing the letters next to underscore.  
 8. Transform the values of *y_merged* according to the *activity* data frame.

### Label activities
 9. Merge the *joinSubject*, *y_merged* and *x_merged* to get *cleanedData*. Name the first two columns, "subject" and "activity".

### Creating new dataset with the average of each variable  
 10. Generate a second independent tidy data set with the average of each measurement for each activity and each subject. 
 11. Write the *result* to "tidy_data_containing_means.txt".