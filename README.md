project_getting-and-cleaning-data
=================================

This is the repository for project_getting-and-cleaning-data

How does my codes work
------------------------

###1. Merges the training and the test sets to create one data set

 1. I use the **read.table** function to read in the features.txt file, and there are a total of 561 variables,  
    I also notice that *there are some duplicated variable names in the 561 variables*;
 2. I use the **read.table** function to read in the test & train data set;
 3. I get the testData set by using **cbind** function to combine the information provided by files: x_test.txt, y_test.txt,       subject_test.txt;
 4. Like step 2, I get the trainData set;
 5. I merge the testData and trainData by **rbind** function; 
 
###2. Extracts only the measurements on the mean and standard deviation for each measurement
  As we can see in the file: feature_info.txt, both the mean() & meanFreq() variables stands for the mean measurements,      and std() stands for the standard deviation measurements, thus:
 1. I use **grep** function to get those variable names from all the column names;
 2. I use the **subset** function to get the subset data;

###3. Uses descriptive activity names to name the activities in the data set
 1. I use **read.table** function to get the activityIds and anctivity names,   
    then I store the information in a hash table(requires to install **hash** package first);
 2. I write a function **funIdtoName** to return the activity name when provided an activityId;
 3. I use the **saplly** function to replace the activityId column with activity name in the data set;
 
###4. Appropriately labels the data set with descriptive variable names.
 Since the variable names have been add for the testData &   trainData, thus after merging the two data sets, 
 I also add the descriptive variable names to the allData;  
 As the variable names provieded in the file: features.txt is quite self-explanatory and acceptable for me, I didn't bother to edit them;
 
###5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
 1. I use the **aggregate** function to create an initial data set: newTidyData, then I remove the 2 unintended "passby" columns(Group.1 & Group.2);
 2. As mentioned above, there are some duplicated variable names in the 561 variables list;  
   It's against the principle of clean tidy set to keep them all; Since there is no detailed information on these variables, I simply remove all of them from the final data set; A better approach may be to keep them all by adding suffix to those duplicated variable, for example: fBodyAcc-bandsEnergy()-1,8.1, fBodyAcc-bandsEnergy()-1,8.2, etc.
 3. I use the **write.table** function to obtain the final newTidyData set;
