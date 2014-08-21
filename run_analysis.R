setwd("I:/coursera/Data Science/3.Getting and Cleaning Data/project/UCI HAR Dataset")

#read in features, take them as colnames; notice name collisions
feature <- read.table("./features.txt")
dim(feature)
length(unique(feature$V2))
dup <- duplicated(feature$V2)
dupVars <- feature$V2[which(dup)]


#read in test data and check
testNum <- read.table("./test/X_test.txt")
dim(testNum)
head(testNum)

#read in test set ActivityIds
testActivityIds <- read.table("./test/y_test.txt")
dim(testActivityIds)
head(testActivityIds)

# read in the test subject
testSubs <- read.table("./test/subject_test.txt")
dim(testSubs)

#combine test data
testData <- cbind(testSubs$V1, testActivityIds$V1, testNum)
colnames(testData) <- c("subjectId", "activityId", as.character(feature$V2))
dim(testData)
head(testData)


#read in train data and check
trainNum <- read.table("./train/X_train.txt")
dim(trainNum)
head(trainNum)

#read in train ActivityIds
trainActivityIds <- read.table("./train/y_train.txt")
dim(trainActivityIds)
head(trainActivityIds)

#read in the train subject
trainSubs <- read.table("./train/subject_train.txt")
dim(trainSubs)

#combine train data
trainData <- cbind(trainSubs$V1, trainActivityIds$V1, trainNum)
colnames(trainData) <- c("subjectId", "activityId", as.character(feature$V2))
dim(trainData)
head(trainData)

#1. merge test & train data
#4. by merging test & train data with variable names, 
#   we also label the allData set with descriptive names
allData <- rbind(testData, trainData)
dim(allData)

#5. tidy data set by aggregate function and delete unwanted columns
newTidyData <- aggregate(allData, by=list(allData$subjectId, allData$activityId), FUN=mean, na.rm=TRUE)
newTidyData$Group.1 <- NULL
newTidyData$Group.2 <- NULL
dim(newTidyData)

#Notice that there are duplicated variable names in the dataset,
#it's against the principle of clean tidy set to keep them all;
#Here, since there is no detailed information on these variables,
#I simply delete them all; A better method may be to keep them all 
# by adding suffix to those duplicated variable, for example: fBodyAcc-bandsEnergy()-1,8.1, fBodyAcc-bandsEnergy()-1,8.2...
fn <- newTidyData[,!(names(newTidyData) %in% as.character(dupVars))]
dim(fn)
head(fn, n=1)
write.table(fn, file="newTidyData.txt", row.names=FALSE)


#get the columns with "-mean" and "-std" in column names
meanAndStdCols <- grep("-mean|-std", colnames(allData))

#2. subset all the mean and std columns
meanAndStd <- subset(allData, select = meanAndStdCols)
dim(meanAndStd)
head(meanAndStd, n = 1)


#install & load hash package
if(!require("hash")==TRUE)
{
  install.packages("hash")
}
library(hash)
#read in activities, store the inforation as a hash
activities <- read.table("activity_labels.txt")
activities
#http://cran.r-project.org/web/packages/hash/hash.pdf
id_name <- hash(keys=activities$V1, values=activities$V2)
id_name

#function: return the activityId's correponding name by hash
funIdtoName <- function(i){
tempVar=as.character(i);
return(as.character(id_name[[tempVar]]))
}


#3. transform activityId into descriptive name
allData$activityId <- sapply(allData$activityId, funIdtoName)
head(allData, n = 1)

