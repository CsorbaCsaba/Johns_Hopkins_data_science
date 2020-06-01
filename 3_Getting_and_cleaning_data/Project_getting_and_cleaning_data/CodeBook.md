# **Getting and cleaning data - project**  

---

The CodeBook should provide some additional information about the variables, data and transformations used in the project.


### **The source of the Data**  

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

---

### **Data Set Information**  


Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

#### The dataset includes the following files:  

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

#### Notes:  

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

---

### **Using the data**  

You should create one R script called __run_analysis.R__ that does the following.

- Merges the training and the test sets to create one data set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

### **About the code (run_analysis.R)**  

- I am using two additional package here: __reshape2__ and __data.table__. I chose __data.table__ because using this package would consume less memory then the others. Also it has nice features to read and write data
- set up the working directory. For this I used file.choose(). If you run the script make sure you choose the __Analysis.R__ file itself. This method save the path you gave to the variable __RFile__. Based on this path I saved the name of the parent directory into another variable, named __wd__.
- now I check if the __Data__ directory exists or not. If it doesn't exist, create it. Then check if the __UCI HAR Dataset__ directory exists. If not but the __data.zip__ does exist just unzip it. If neither the directory nor the file exists, then download the zip file and unzip it. After unzip, remove the .zip file
- load the data and add column names. For more info please check the code itself, I commented
- after load, merge them and creating factors from __subjects__ and __activitys__
- to make the dataset tidy I used the data.table melt() and dcast() because there is room for aggregation in this dataset
- write the result dataset out







