project_getting-and-cleaning-data
=================================

This is the repository for project_getting-and-cleaning-data

How does my codes work
------------------------

###1. Merges the training and the test sets to create one data set

 1. I use the read.table function to read in the features.txt file, and there are a total of 561 variables,
    I also notice that there are some duplicated variable names in the 561 variables;
 2. I use the read.table function to read in the test & train data set;
 3. I get the testData set by using cbind function to combine the information provided by files: x_test.txt, y_test.txt,       subject_test.txt;
 4. Like step 2, I get the trainData set;
 5. I merge the testData and trainData by rbind function; since the variable names have been add for the testData &   trainData, so by merging the two data sets, I add the descriptive variable names to the allData at the same time;
    As the variable names provieded in the file: features.txt is quite self-explanatory and acceptable, I didn't bother to edit them;
 6. 
