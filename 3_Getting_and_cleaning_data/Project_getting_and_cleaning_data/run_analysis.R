
# Load packages
p <- c("data.table", "reshape2")
require(p)
lapply(p, require, character.only = TRUE)


# Set up the working directory
RFile <- file.choose() # select this .R file from the explorer
wd  <- dirname(RFile) # get the name of the directory
setwd(wd)
getwd()
dir()


# Get the data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(wd,"Data")

if (!dir.exists(f)) {dir.create(f)}
setwd(f)
if (!dir.exists("UCI HAR Dataset")) {
    if (file.exists("data.zip")) {
        unzip("data.zip")
    } else {
        download.file(fileURL, destfile = "data.zip")
        unzip("data.zip")
    }
}
if (file.exists("data.zip")) {file.remove("data.zip")}

for (j in list.files(f)) {
    print(paste("Directory: ", j))
    print(list.files(file.path(f,j)))
}

# Load ACTIVITY and FEATURES
# and add column names
activityLabel <- fread(file.path(f,"UCI HAR Dataset",
                                 "activity_labels.txt"),
                       col.names = c("activityID","activity"))
#head(activityLabel)

# I will use them as column names
features <- fread(file.path(f,"UCI HAR Dataset",
                            "features.txt"),
                  col.names = c("featureID","featureName"))
#head(features)

# we will only need the measurements on the mean and standard 
# deviation for each measurement. They seem like mean() and std() in 
# features.txt, so we need to get the indices of these columns
wantedFeatures <- grep("(mean|std)\\(\\)", features$featureName)
# now the wantedFeatures contains the the indices of the needed columns
# which we use to extract only those from features
measurements <- features[wantedFeatures, featureName]
# to make the data tidy, we delete the parenthesis
measurements <- gsub("[()]","", measurements)

# Load Train dataset
trainDF <- fread(file.path(f, 
                           "UCI HAR Dataset", 
                           "train", 
                           "X_train.txt"))

trainDF <- trainDF[,wantedFeatures, with = FALSE]

# add variables names
names(trainDF) <- measurements

trainAct <- fread(file.path(f,
                            "UCI HAR Dataset",
                            "train",
                            "Y_train.txt"),
                  col.names = c("Activity"))

trainSubjects <- fread(file.path(f,
                                 "UCI HAR Dataset",
                                 "train",
                                 "subject_train.txt"),
                       col.names = c("SubjectNum"))

train <- cbind(trainSubjects, trainAct, trainDF)
#str(train)



# Load test datasets
testDF <- fread(file.path(f,
                          "UCI HAR Dataset",
                          "test",
                          "X_test.txt"))
testDF <- testDF[,wantedFeatures,with = FALSE]

names(testDF) <- measurements

testAct <- fread(file.path(f,
                           "UCI HAR Dataset",
                           "test",
                           "Y_test.txt"),
                 col.names = c("Activity"))

testSubjects <- fread(file.path(f,
                                "UCI HAR Dataset",
                                "test",
                                "subject_test.txt"),
                      col.names = c("SubjectNum"))

test <- cbind(testSubjects, testAct, testDF)

# Merge train and test datasets
mergedDF <- rbind(train, test)

# creating factors using activity as labels
mergedDF[["Activity"]] <- factor(mergedDF[, Activity],
                                 levels = activityLabel[["activityID"]],
                                 labels = activityLabel[["activity"]])

mergedDF[["SubjectNum"]] <- as.factor(mergedDF[, SubjectNum])
#dim(mergedDF)
#head(mergedDF)

# since the SubjectNum and the Activity are multiplicated, we should use 
# melt and dcast to reshape the data and make it tidy
mergedDF <- reshape2::melt(data = mergedDF, 
                           id = c("SubjectNum", "Activity"))
#dim(mergedDF)

mergedDF <- reshape2::dcast(data = mergedDF, 
                            SubjectNum + Activity ~ variable, 
                            fun.aggregate = mean)
#dim(mergedDF)
#head(mergedDF)



# Write the result to a .txt file
f <- file.path(wd,"Output")

if (!dir.exists(f)) {dir.create(f)}
setwd(f)
data.table::fwrite(x = mergedDF, 
                   file = "tidyOutput.txt", 
                   quote = FALSE,
                   showProgress = TRUE,
                   append = FALSE)
