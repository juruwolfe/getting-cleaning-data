# Class project: Getting and Cleaning Data
A repo for the final output the week 3 class project.
**Note:** This script will return an error message, but never fear! It works just fine. Step 13 under Run_analysis explains the cause for this error. 

Includes:
* An R script, titled "run_analysis.R" to write the tidy data set from the raw data
* The original UCI HAR Dataset, in a folder titled "data"
* The tidy data output, titled "wearable-tidy-data.txt" 

## The Script
The run analyis script takes the raw data, combines and cleans it, and then outputs a tidy data set with the averages for the all measurements on the mean and standard deviation, by subject and activity. 

### How it works:

#### Run_analyis()

1. Gets all of the data from the original set and sets each one as a variable. **Note:** the files from the original set must be in a folder called 'data' 
2. Using cbind (so combining side by side), combines the xTest and xTraining data. 
3. Sets the column names of this new data frame to the second column of the features file (which includes the names for all the different types of measurements)
4. Using rbind (combining one on top of the other), combines the subject test and train files. 
5. Sets the column name of this to "Subject"
6. Row bing the yTest and yTraining files
7. Sets the column name of this to "Activity"
8. Swaps out the numeric code for activity (i.e 1 = "Walking") for the descriptive name. For this, I used the activity label file as a guide
9. Using column bind, brings the frames from set 3, 5 and 8 together into one file
9. Gets the column names of the mean and standard deviation, using the **getColumnNames** function, described below.
10. Using the column names, get just the info for the mean and std
11. Column binds these into one file, along with the subject and activity names. 
12. Using the native aggreate function, get mean for each column, by subject and activity 
13. Remove the last two columns. Since the aggregate function includes subject and activity as the first two column, we no longer need them at the end (also, Activity is now all null, as teh aggreate function tried to run the mean function on the string, hence the error messages)
14. Write our tidy data to a txt file, setting the row.name argument to false. 

#### getColumnNames()

1. Start with an empty variable called stringColNames.
2. Create a vector, colnames, that hold all possible column names from the data 
3. Find the location of each column name that includes the string passed in the argument (either 'Mean' or 'Std').
4. Using a for loop, match the location of each column name with the actual name and (using the empty variable from before) create a vector with said names. 
5. Remove the empty value in the above data frame that came with the init of it.
6. Return the clean vector of the column names including the string passed. 
