library(dplyr)

# Load test data sets
x_test = read.table("test/X_test.txt")
y_test = read.table("test/y_test.txt")
subject_test = read.table("test/subject_test.txt")

# Load train data sets
x_train = read.table("train/X_train.txt")
y_train = read.table("train/y_train.txt")
subject_train = read.table("train/subject_train.txt")

# Merge test files
test = cbind(subject_test, y_test, x_test)

# Merge train files
train = cbind(subject_train, y_train, x_train)

# Merge both files
test_train = rbind(test, train)

# Load feature variables
features = read.table("features.txt")
names(features) = c("id", "variable")

# Mean variables
mean_var = grep("mean()", features$variable, value = TRUE, fixed = TRUE)

# Standard Deviation variables
std_var = grep("std()", features$variable, value = TRUE, fixed = TRUE)

# Combine variable vectors
mean_std_var = c(mean_var, std_var)

# Name the test, train and test_train dataframe columns, giving them
# a descriptive name.
names(test) = c("subject", "activity", features$variable)
names(train) = c("subject", "activity", features$variable)
names(test_train) = c("subject", "activity", features$variable)

# Select the columns with mean and std. I also added 
# the columns for the subject and the activity.
new_test = select(test, 1, 2, all_of(mean_std_var))
new_train = select(train, 1, 2, all_of(mean_std_var))
new_test_train = select(test_train, 1, 2, all_of(mean_std_var))

# Replace activity number with a descriptive name
# use a for loop here.
count = 0
for (val in new_test_train$activity) {
  if (val == 1) {
    count = count + 1
    new_test_train$activity[count] = "WALKING"
  } else if (val == 2) {
    count = count + 1
    new_test_train$activity[count] = "WALKING_UPSTAIRS"
  } else if (val == 3) {
    count = count + 1
    new_test_train$activity[count] = "WALKING_DOWNSTAIRS"
  } else if (val == 4) {
    count = count + 1
    new_test_train$activity[count] = "SITTING"
  } else if (val == 5) {
    count = count + 1
    new_test_train$activity[count] = "STANDING"
  } else if (val == 6) {
    count = count + 1
    new_test_train$activity[count] = "LAYING"
  }
}

# Averages 
data_groups = group_by(new_test_train, subject, activity)
tidy_test_train = summarise_at(data_groups, mean_std_var, mean)

# Text file
write.table(tidy_test_train, file = "tidy_test_train.txt", row.names =  FALSE)
