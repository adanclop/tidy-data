# tidy-data
## Initial setup
For the Getting and Cleaning Data Course Project, I downloaded and extracted the file collected from the accelerometers from the Samsung Galaxy S smartphone from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In order to work in a way more comfortable and efficient with the data, I loaded the R packages tidyr and dplyr

## Working with the data
After reading and merging the files from the 2 grops of subjects (train and test), the more difficult step for me was the test and train sets, since each cell contained values from more than 500 measurements from the features. After doing that with the separate() function (and removing double spaces in between), I could select my variables of interest, which were the measurements of mean and standart deviation. I could easily label the activities variable with factor() to make them readable, same with the names of my final dataset. 

At the end, with the summarize() function I could find the means of the mean and std for each subject and activity.
