This readme file describes the code used in the run_analysis.R file.

The 3 files in the test folder were merged using the column bind funtion cbind() and saved as test.

The 3 files in the train folder were merged using the column bind funtion cbind() and saved as train.

test and train files were then merged using the row bind function rbind() and saved as test_train

To replace the column names with descriptive names I loaded the features file that contains the variable names and used the names function. I then used regular expression to extract the variables that correspond with the mean and the standard deviation from the features dataset. This was achieved by using the grep function.

Using the select function from the dplyr package I was able to extract the columns from the test_train dataset that match the previously extracted variable names.

A for loop was used to iterate through the activities column, replacing the integers with descriptive names.

To calculate the averages by subject and activity I first used the group_by function from the dplyr package. Then I used the summarise function from the same package to find the average based on the grouping in the new dataset from the group_by function.

