# Assignment_Cleaning-Gettingdata
Week 4 Assignment: Tidy Data
This is the course project of the Coursera course: Getting and Cleaning Data.

## Files in this Repo
   1. README.md:  This markdown file
   2. CodeBook.md: A markdown file with descriptions of the data,                          variables and transformations.
   3. run_analysis.R: The script containing the code
   
   
## Description of the code

The script assumes that the samsung data, the folder "UCI HAR Dataset" with all its contents, is already present in the working directory before running the script. It can be downloaded from:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
Once downloaded and unzipped, the script is ready to use. Firstly the script loads the **dplyr** and **read.table** R packages. Then it uses the read.table() command to read data into corresponding variables, features, feature values from train and test folders, activity values from train and test folders, and the correspondint subject IDs. The columns are named and the data is merged in two steps. First, the test sets and train sets are collected using cbind(). Then the test and train sets are merged using rbind(). Using the select() function with matches() as an argument, a subset of those variables that are means and standard variables are returned. The data is then arranged by activity, and activity values are assigned its corresponding labels. The data is then grouped by subject ID, then by activity and summary of means is returned for the measurement variables. Then it writes a text file for the tidy data. The tidy data is of the wide format.


