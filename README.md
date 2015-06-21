# Class project: Getting and Cleaning Data
A repo for the final output the week 3 class project. Includes:
* An R script, titled "run_analysis.R" to write the tidy data set from the raw data
* The original UCI HAR Dataset, in a folder titled "data"
* The tidy data output, titled "wearable-tidy-data.txt" 

## The Script
The run analyis script takes the raw data, combines and cleans it, and then outputs a tidy data set with the averages for the all measurements on the mean and standard deviation, by subject and activity. 

### How it works:
1. Gets all of the data from the original set. _Note:_ the files from the original set must be in a folder called 'data' 
2. 