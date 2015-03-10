# I'll be using dplyr to handle dataframes
library(dplyr)

# For codebook
require(knitr)
require(markdown)

# Set some vars
setwd("~/development/GettingAndCleaningData/")
data_path <- paste(getwd(), "/UCI\ HAR\ Dataset", sep="") 
test_path <- paste(data_path, "/test", sep="") 
train_path <- paste(data_path, "/train", sep="") 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Step 1. Merges the training and the test sets to create one data set.
# Download the data and unzip
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset_file <- "dataset.zip"
if (!file.exists(file.path(getwd(), dataset_file))) {
  download.file(url, dataset_file, method="curl")
}

unzip(file.path(dataset_file), list = FALSE, overwrite = TRUE,
      unzip = "internal",
      setTimes = FALSE)


# Slurp in all the data for test and training
data_Y_test <- read.table(file.path(test_path, "y_test.txt"), header = FALSE)
data_X_test <- read.table(file.path(test_path, "X_test.txt"), header = FALSE)
data_subject_test <- read.table(file.path(test_path, "subject_test.txt"), header = FALSE)

data_Y_train <- read.table(file.path(train_path, "y_train.txt" ), header = FALSE)
data_X_train <- read.table(file.path(train_path, "X_train.txt" ), header = FALSE)
data_subject_train <- read.table(file.path(train_path, "subject_train.txt" ), header = FALSE)

# I'm using dplyr rbind_list to put the dataset rows together
# dplyr's data frames are easier to deal with
# The features are from the X_test and X_train data
data_features <- rbind_list(data_X_test, data_X_train)

# The subject data are from the subject_test and subject_train data
data_subject <- rbind_list(data_subject_test, data_subject_train)

# The activity data are from the Y_test and Y_train data
data_activity <- rbind_list(data_Y_test, data_Y_train)

# Rename labels
# Easy ones first
data_subject <- rename(data_subject, subject=V1)
data_activity <- rename(data_activity, activity=V1)

# Rename the features
# Get the feature names
feature_names <- tbl_df(read.table(file.path(data_path, "features.txt"), head=FALSE))
# Using that df, rename the columns in data_features
names(data_features)<- feature_names$V2

# Finally, merge everything together
final_data <- bind_cols(data_subject, data_activity, data_features)


# Step 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Clean up the column names
valid_column_names <- make.names(names=names(final_data), unique=TRUE, allow_ = TRUE)
names(final_data) <- valid_column_names
# Get the subset, the escaped \\. is due to the make.names function stripping out the ()
extracted_data <- select(final_data, subject, activity, matches("mean\\.", ignore.case = FALSE), contains("std"))


# Step 3. Uses descriptive activity names to name the activities in the data set
# The activities in the dataset are referenced by a number
# There are six possible activities defined in the file
# Read the acivity labels file
activity_labels <- read.table(file.path(data_path, "activity_labels.txt"), header = FALSE)

# Convert into a factor and replace those ids in the dataset, use the second column from the file for the description
extracted_data$activity <- factor(extracted_data$activity, levels=activity_labels$V1, labels=activity_labels$V2)


# Step 4. Appropriately labels the data set with descriptive variable names. 
# I couldn't figure out how to do this in dplyr, so I went with a gsub solution
# The labels are a little cryptic, I'm going to clean them up a little
# 'std' = Standard.deviation
# 'mean' = Mean
# 't' = Time
# 'f' = FFT
# 'Acc' = Accelerometer
# 'Gyro' = Gyroscope
# 'Mag' = Magnitude
# 'BodyBody' = Body
# '...' = .  # Cleans up the stuff from make.names
# '..$' = .  # Cleans up the stuff I made

names(extracted_data) <- gsub("std", "Standard.deviation", names(extracted_data))
names(extracted_data) <- gsub("mean", "Mean", names(extracted_data))
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "FFT", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data) <- gsub("\\.\\.\\.", ".", names(extracted_data))
names(extracted_data) <- gsub("\\.\\.$", "", names(extracted_data))

# Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# I tried chaning here
tidy_data <- extracted_data %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# Save the tidy_data to a text file in the working directory
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

# Make codebook
knit("makeCodebook.Rmd", output = "codebook.md", encoding = "ISO8859-1", quiet = TRUE)