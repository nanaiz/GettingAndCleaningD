# Step1. Reading and merging training and test data.

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt") 
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)


# Step2. Mean and standard deviation extraction.

features <- read.table("UCI HAR Dataset/features.txt")

measurement_mean_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])

x_merged <- x_merged[, measurement_mean_std]


# Step3. Describe activities

activity <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activity_description <- activity[y_merged[, 1], 2]

y_merged[, 1] <- activity_description
names(y_merged) <- "activity"


# Step4. Label activities

names(subject_merged) <- "subject"

cleanedData <- cbind(subject_merged, y_merged, x_merged)


# Step5. Creating new dataset with the average of each variable
subject_lenght <- length(table(subject_merged))
activity_lenght <- dim(activity)[1]
column_lenght <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subject_lenght*activity_lenght, ncol=column_lenght) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subject_lenght) {
        for(j in 1:activity_lenght) {
                result[row, 1] <- sort(unique(subject_merged)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                result[row, 3:column_lenght] <- colMeans(cleanedData[bool1&bool2, 3:column_lenght])
                row <- row + 1
        }
}

write.table(result, "tidy_data_containing_means.txt")