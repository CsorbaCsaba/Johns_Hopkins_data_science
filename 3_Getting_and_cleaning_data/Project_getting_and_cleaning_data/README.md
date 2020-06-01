# **Getting and cleaning data - project**  

---

### **The goal of the project**  

---

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to: 

1. prepare tidy data that can be used for later analysis 
2. submit a link to a Github repository with your script for performing the analysis 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
4. you should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.


---

### **About the data**

Link of the dataset: 
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset.

#### **Attribute Information:**  

For each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope
- A 561-feature vector with time and frequency domain variables
- Its activity label
- An identifier of the subject who carried out the experiment

---

### **About the code (run_analysis.R)**  

- I am using two additional package here: __reshape2__ and __data.table__. I chose __data.table__ because using this package would consume less memory then the others. Also it has nice features to read and write data
- set up the working directory. For this I used file.choose(). If you run the script make sure you choose the __Analysis.R__ file itself. This method save the path you gave to the variable __RFile__. Based on this path I saved the name of the parent directory into another variable, named __wd__.
- now I check if the __Data__ directory exists or not. If it doesn't exist, create it. Then check if the __UCI HAR Dataset__ directory exists. If not but the __data.zip__ does exist just unzip it. If neither the directory nor the file exists, then download the zip file and unzip it. After unzip, remove the .zip file
- load the data and add column names. For more info please check the code itself, I commented
- after load, merge them and creating factors from __subjects__ and __activitys__
- to make the dataset tidy I used the data.table melt() and dcast() because there is room for aggregation in this dataset
- write the result dataset out

















