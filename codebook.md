Codebook
========
Codebook was generated on 2015-03-10 14:43:19 during the same process that generated the dataset.

Dataset generation process
======

1. Merges the training and the test sets to create one data set.
   * Download the data and unzip
   * Slurp in all the data for test and training
   * For example:
       - data_Y_test <- read.table(file.path(test_path, "y_test.txt"), header = FALSE)
       - data_X_test <- read.table(file.path(test_path, "X_test.txt"), header = FALSE)
       - data_subject_test <- read.table(file.path(test_path, "subject_test.txt"), header = FALSE)

   * I used dplyr to bind data together
       - data_features <- rbind_list(data_X_test, data_X_train)

   * Rename labels
   * Finally, merge everything together
       - final_data <- bind_cols(data_subject, data_activity, data_features)

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   * I ran make.names on the dataset to ensure uniqueness
   * Then I extracted just the requested mean and standard deviation

3. Uses descriptive activity names to name the activities in the data set
   * Convert the activites file data into a factor and replace those ids in the dataset, use the second column from the file for the description

4. Appropriately labels the data set with descriptive variable names.
   * I did some renaming like these:
       - names(extracted_data) <- gsub("std", "Standard.deviation", names(extracted_data))
       - names(extracted_data) <- gsub("mean", "Mean", names(extracted_data))

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   * tidy_data <- extracted_data %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

   * Save the tidy_data to a text file in the working directory
   * write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

Feature Selection 
-----------------

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

As part of the process, the features are renamed.

Variable portion  | Renamed
------------------|------------
'std'             | Standard.deviation
'mean'            | Mean
't'               | Time
'f'               | FFT
'Acc'             | Accelerometer
'Gyro'            | Gyroscope
'Mag'             | Magnitude
'BodyBody'        | Body


Dataset structure
-----------------


```r
str(tidy_data)
```

```
## Classes 'grouped_df', 'tbl_df', 'tbl' and 'data.frame':	180 obs. of  68 variables:
##  $ subject                                              : int  1 1 1 1 1 1 2 2 2 2 ...
##  $ activity                                             : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
##  $ TimeBodyAccelerometer.Mean.X                         : num  0.277 0.255 0.289 0.261 0.279 ...
##  $ TimeBodyAccelerometer.Mean.Y                         : num  -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...
##  $ TimeBodyAccelerometer.Mean.Z                         : num  -0.1111 -0.0973 -0.1076 -0.1045 -0.1106 ...
##  $ TimeGravityAccelerometer.Mean.X                      : num  0.935 0.893 0.932 0.832 0.943 ...
##  $ TimeGravityAccelerometer.Mean.Y                      : num  -0.282 -0.362 -0.267 0.204 -0.273 ...
##  $ TimeGravityAccelerometer.Mean.Z                      : num  -0.0681 -0.0754 -0.0621 0.332 0.0135 ...
##  $ TimeBodyAccelerometerJerk.Mean.X                     : num  0.074 0.1014 0.0542 0.0775 0.0754 ...
##  $ TimeBodyAccelerometerJerk.Mean.Y                     : num  0.028272 0.019486 0.02965 -0.000619 0.007976 ...
##  $ TimeBodyAccelerometerJerk.Mean.Z                     : num  -0.00417 -0.04556 -0.01097 -0.00337 -0.00369 ...
##  $ TimeBodyGyroscope.Mean.X                             : num  -0.0418 0.0505 -0.0351 -0.0454 -0.024 ...
##  $ TimeBodyGyroscope.Mean.Y                             : num  -0.0695 -0.1662 -0.0909 -0.0919 -0.0594 ...
##  $ TimeBodyGyroscope.Mean.Z                             : num  0.0849 0.0584 0.0901 0.0629 0.0748 ...
##  $ TimeBodyGyroscopeJerk.Mean.X                         : num  -0.09 -0.1222 -0.074 -0.0937 -0.0996 ...
##  $ TimeBodyGyroscopeJerk.Mean.Y                         : num  -0.0398 -0.0421 -0.044 -0.0402 -0.0441 ...
##  $ TimeBodyGyroscopeJerk.Mean.Z                         : num  -0.0461 -0.0407 -0.027 -0.0467 -0.049 ...
##  $ TimeBodyAccelerometerMagnitude.Mean                  : num  -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...
##  $ TimeGravityAccelerometerMagnitude.Mean               : num  -0.137 -0.1299 0.0272 -0.9485 -0.9843 ...
##  $ TimeBodyAccelerometerJerkMagnitude.Mean              : num  -0.1414 -0.4665 -0.0894 -0.9874 -0.9924 ...
##  $ TimeBodyGyroscopeMagnitude.Mean                      : num  -0.161 -0.1267 -0.0757 -0.9309 -0.9765 ...
##  $ TimeBodyGyroscopeJerkMagnitude.Mean                  : num  -0.299 -0.595 -0.295 -0.992 -0.995 ...
##  $ FFTBodyAccelerometer.Mean.X                          : num  -0.2028 -0.4043 0.0382 -0.9796 -0.9952 ...
##  $ FFTBodyAccelerometer.Mean.Y                          : num  0.08971 -0.19098 0.00155 -0.94408 -0.97707 ...
##  $ FFTBodyAccelerometer.Mean.Z                          : num  -0.332 -0.433 -0.226 -0.959 -0.985 ...
##  $ FFTBodyAccelerometerJerk.Mean.X                      : num  -0.1705 -0.4799 -0.0277 -0.9866 -0.9946 ...
##  $ FFTBodyAccelerometerJerk.Mean.Y                      : num  -0.0352 -0.4134 -0.1287 -0.9816 -0.9854 ...
##  $ FFTBodyAccelerometerJerk.Mean.Z                      : num  -0.469 -0.685 -0.288 -0.986 -0.991 ...
##  $ FFTBodyGyroscope.Mean.X                              : num  -0.339 -0.493 -0.352 -0.976 -0.986 ...
##  $ FFTBodyGyroscope.Mean.Y                              : num  -0.1031 -0.3195 -0.0557 -0.9758 -0.989 ...
##  $ FFTBodyGyroscope.Mean.Z                              : num  -0.2559 -0.4536 -0.0319 -0.9513 -0.9808 ...
##  $ FFTBodyAccelerometerMagnitude.Mean                   : num  -0.1286 -0.3524 0.0966 -0.9478 -0.9854 ...
##  $ FFTBodyAccelerometerJerkMagnitude.Mean               : num  -0.0571 -0.4427 0.0262 -0.9853 -0.9925 ...
##  $ FFTBodyGyroscopeMagnitude.Mean                       : num  -0.199 -0.326 -0.186 -0.958 -0.985 ...
##  $ FFTBodyGyroscopeJerkMagnitude.Mean                   : num  -0.319 -0.635 -0.282 -0.99 -0.995 ...
##  $ TimeBodyAccelerometer.Standard.deviation.X           : num  -0.284 -0.355 0.03 -0.977 -0.996 ...
##  $ TimeBodyAccelerometer.Standard.deviation.Y           : num  0.11446 -0.00232 -0.03194 -0.92262 -0.97319 ...
##  $ TimeBodyAccelerometer.Standard.deviation.Z           : num  -0.26 -0.0195 -0.2304 -0.9396 -0.9798 ...
##  $ TimeGravityAccelerometer.Standard.deviation.X        : num  -0.977 -0.956 -0.951 -0.968 -0.994 ...
##  $ TimeGravityAccelerometer.Standard.deviation.Y        : num  -0.971 -0.953 -0.937 -0.936 -0.981 ...
##  $ TimeGravityAccelerometer.Standard.deviation.Z        : num  -0.948 -0.912 -0.896 -0.949 -0.976 ...
##  $ TimeBodyAccelerometerJerk.Standard.deviation.X       : num  -0.1136 -0.4468 -0.0123 -0.9864 -0.9946 ...
##  $ TimeBodyAccelerometerJerk.Standard.deviation.Y       : num  0.067 -0.378 -0.102 -0.981 -0.986 ...
##  $ TimeBodyAccelerometerJerk.Standard.deviation.Z       : num  -0.503 -0.707 -0.346 -0.988 -0.992 ...
##  $ TimeBodyGyroscope.Standard.deviation.X               : num  -0.474 -0.545 -0.458 -0.977 -0.987 ...
##  $ TimeBodyGyroscope.Standard.deviation.Y               : num  -0.05461 0.00411 -0.12635 -0.96647 -0.98773 ...
##  $ TimeBodyGyroscope.Standard.deviation.Z               : num  -0.344 -0.507 -0.125 -0.941 -0.981 ...
##  $ TimeBodyGyroscopeJerk.Standard.deviation.X           : num  -0.207 -0.615 -0.487 -0.992 -0.993 ...
##  $ TimeBodyGyroscopeJerk.Standard.deviation.Y           : num  -0.304 -0.602 -0.239 -0.99 -0.995 ...
##  $ TimeBodyGyroscopeJerk.Standard.deviation.Z           : num  -0.404 -0.606 -0.269 -0.988 -0.992 ...
##  $ TimeBodyAccelerometerMagnitude.Standard.deviation    : num  -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...
##  $ TimeGravityAccelerometerMagnitude.Standard.deviation : num  -0.2197 -0.325 0.0199 -0.9271 -0.9819 ...
##  $ TimeBodyAccelerometerJerkMagnitude.Standard.deviation: num  -0.0745 -0.479 -0.0258 -0.9841 -0.9931 ...
##  $ TimeBodyGyroscopeMagnitude.Standard.deviation        : num  -0.187 -0.149 -0.226 -0.935 -0.979 ...
##  $ TimeBodyGyroscopeJerkMagnitude.Standard.deviation    : num  -0.325 -0.649 -0.307 -0.988 -0.995 ...
##  $ FFTBodyAccelerometer.Standard.deviation.X            : num  -0.3191 -0.3374 0.0243 -0.9764 -0.996 ...
##  $ FFTBodyAccelerometer.Standard.deviation.Y            : num  0.056 0.0218 -0.113 -0.9173 -0.9723 ...
##  $ FFTBodyAccelerometer.Standard.deviation.Z            : num  -0.28 0.086 -0.298 -0.934 -0.978 ...
##  $ FFTBodyAccelerometerJerk.Standard.deviation.X        : num  -0.1336 -0.4619 -0.0863 -0.9875 -0.9951 ...
##  $ FFTBodyAccelerometerJerk.Standard.deviation.Y        : num  0.107 -0.382 -0.135 -0.983 -0.987 ...
##  $ FFTBodyAccelerometerJerk.Standard.deviation.Z        : num  -0.535 -0.726 -0.402 -0.988 -0.992 ...
##  $ FFTBodyGyroscope.Standard.deviation.X                : num  -0.517 -0.566 -0.495 -0.978 -0.987 ...
##  $ FFTBodyGyroscope.Standard.deviation.Y                : num  -0.0335 0.1515 -0.1814 -0.9623 -0.9871 ...
##  $ FFTBodyGyroscope.Standard.deviation.Z                : num  -0.437 -0.572 -0.238 -0.944 -0.982 ...
##  $ FFTBodyAccelerometerMagnitude.Standard.deviation     : num  -0.398 -0.416 -0.187 -0.928 -0.982 ...
##  $ FFTBodyAccelerometerJerkMagnitude.Standard.deviation : num  -0.103 -0.533 -0.104 -0.982 -0.993 ...
##  $ FFTBodyGyroscopeMagnitude.Standard.deviation         : num  -0.321 -0.183 -0.398 -0.932 -0.978 ...
##  $ FFTBodyGyroscopeJerkMagnitude.Standard.deviation     : num  -0.382 -0.694 -0.392 -0.987 -0.995 ...
##  - attr(*, "vars")=List of 1
##   ..$ : symbol subject
##  - attr(*, "drop")= logi TRUE
```

List the variable names in the data table
----------------------------------------


```r
names(tidy_data)
```

```
##  [1] "subject"                                              
##  [2] "activity"                                             
##  [3] "TimeBodyAccelerometer.Mean.X"                         
##  [4] "TimeBodyAccelerometer.Mean.Y"                         
##  [5] "TimeBodyAccelerometer.Mean.Z"                         
##  [6] "TimeGravityAccelerometer.Mean.X"                      
##  [7] "TimeGravityAccelerometer.Mean.Y"                      
##  [8] "TimeGravityAccelerometer.Mean.Z"                      
##  [9] "TimeBodyAccelerometerJerk.Mean.X"                     
## [10] "TimeBodyAccelerometerJerk.Mean.Y"                     
## [11] "TimeBodyAccelerometerJerk.Mean.Z"                     
## [12] "TimeBodyGyroscope.Mean.X"                             
## [13] "TimeBodyGyroscope.Mean.Y"                             
## [14] "TimeBodyGyroscope.Mean.Z"                             
## [15] "TimeBodyGyroscopeJerk.Mean.X"                         
## [16] "TimeBodyGyroscopeJerk.Mean.Y"                         
## [17] "TimeBodyGyroscopeJerk.Mean.Z"                         
## [18] "TimeBodyAccelerometerMagnitude.Mean"                  
## [19] "TimeGravityAccelerometerMagnitude.Mean"               
## [20] "TimeBodyAccelerometerJerkMagnitude.Mean"              
## [21] "TimeBodyGyroscopeMagnitude.Mean"                      
## [22] "TimeBodyGyroscopeJerkMagnitude.Mean"                  
## [23] "FFTBodyAccelerometer.Mean.X"                          
## [24] "FFTBodyAccelerometer.Mean.Y"                          
## [25] "FFTBodyAccelerometer.Mean.Z"                          
## [26] "FFTBodyAccelerometerJerk.Mean.X"                      
## [27] "FFTBodyAccelerometerJerk.Mean.Y"                      
## [28] "FFTBodyAccelerometerJerk.Mean.Z"                      
## [29] "FFTBodyGyroscope.Mean.X"                              
## [30] "FFTBodyGyroscope.Mean.Y"                              
## [31] "FFTBodyGyroscope.Mean.Z"                              
## [32] "FFTBodyAccelerometerMagnitude.Mean"                   
## [33] "FFTBodyAccelerometerJerkMagnitude.Mean"               
## [34] "FFTBodyGyroscopeMagnitude.Mean"                       
## [35] "FFTBodyGyroscopeJerkMagnitude.Mean"                   
## [36] "TimeBodyAccelerometer.Standard.deviation.X"           
## [37] "TimeBodyAccelerometer.Standard.deviation.Y"           
## [38] "TimeBodyAccelerometer.Standard.deviation.Z"           
## [39] "TimeGravityAccelerometer.Standard.deviation.X"        
## [40] "TimeGravityAccelerometer.Standard.deviation.Y"        
## [41] "TimeGravityAccelerometer.Standard.deviation.Z"        
## [42] "TimeBodyAccelerometerJerk.Standard.deviation.X"       
## [43] "TimeBodyAccelerometerJerk.Standard.deviation.Y"       
## [44] "TimeBodyAccelerometerJerk.Standard.deviation.Z"       
## [45] "TimeBodyGyroscope.Standard.deviation.X"               
## [46] "TimeBodyGyroscope.Standard.deviation.Y"               
## [47] "TimeBodyGyroscope.Standard.deviation.Z"               
## [48] "TimeBodyGyroscopeJerk.Standard.deviation.X"           
## [49] "TimeBodyGyroscopeJerk.Standard.deviation.Y"           
## [50] "TimeBodyGyroscopeJerk.Standard.deviation.Z"           
## [51] "TimeBodyAccelerometerMagnitude.Standard.deviation"    
## [52] "TimeGravityAccelerometerMagnitude.Standard.deviation" 
## [53] "TimeBodyAccelerometerJerkMagnitude.Standard.deviation"
## [54] "TimeBodyGyroscopeMagnitude.Standard.deviation"        
## [55] "TimeBodyGyroscopeJerkMagnitude.Standard.deviation"    
## [56] "FFTBodyAccelerometer.Standard.deviation.X"            
## [57] "FFTBodyAccelerometer.Standard.deviation.Y"            
## [58] "FFTBodyAccelerometer.Standard.deviation.Z"            
## [59] "FFTBodyAccelerometerJerk.Standard.deviation.X"        
## [60] "FFTBodyAccelerometerJerk.Standard.deviation.Y"        
## [61] "FFTBodyAccelerometerJerk.Standard.deviation.Z"        
## [62] "FFTBodyGyroscope.Standard.deviation.X"                
## [63] "FFTBodyGyroscope.Standard.deviation.Y"                
## [64] "FFTBodyGyroscope.Standard.deviation.Z"                
## [65] "FFTBodyAccelerometerMagnitude.Standard.deviation"     
## [66] "FFTBodyAccelerometerJerkMagnitude.Standard.deviation" 
## [67] "FFTBodyGyroscopeMagnitude.Standard.deviation"         
## [68] "FFTBodyGyroscopeJerkMagnitude.Standard.deviation"
```

Show a few rows of the dataset
------------------------------


```r
head(tidy_data, 2)
```

```
## Source: local data frame [2 x 68]
## Groups: subject
## 
##   subject         activity TimeBodyAccelerometer.Mean.X
## 1       1          WALKING                    0.2773308
## 2       1 WALKING_UPSTAIRS                    0.2554617
## Variables not shown: TimeBodyAccelerometer.Mean.Y (dbl),
##   TimeBodyAccelerometer.Mean.Z (dbl), TimeGravityAccelerometer.Mean.X
##   (dbl), TimeGravityAccelerometer.Mean.Y (dbl),
##   TimeGravityAccelerometer.Mean.Z (dbl), TimeBodyAccelerometerJerk.Mean.X
##   (dbl), TimeBodyAccelerometerJerk.Mean.Y (dbl),
##   TimeBodyAccelerometerJerk.Mean.Z (dbl), TimeBodyGyroscope.Mean.X (dbl),
##   TimeBodyGyroscope.Mean.Y (dbl), TimeBodyGyroscope.Mean.Z (dbl),
##   TimeBodyGyroscopeJerk.Mean.X (dbl), TimeBodyGyroscopeJerk.Mean.Y (dbl),
##   TimeBodyGyroscopeJerk.Mean.Z (dbl), TimeBodyAccelerometerMagnitude.Mean
##   (dbl), TimeGravityAccelerometerMagnitude.Mean (dbl),
##   TimeBodyAccelerometerJerkMagnitude.Mean (dbl),
##   TimeBodyGyroscopeMagnitude.Mean (dbl),
##   TimeBodyGyroscopeJerkMagnitude.Mean (dbl), FFTBodyAccelerometer.Mean.X
##   (dbl), FFTBodyAccelerometer.Mean.Y (dbl), FFTBodyAccelerometer.Mean.Z
##   (dbl), FFTBodyAccelerometerJerk.Mean.X (dbl),
##   FFTBodyAccelerometerJerk.Mean.Y (dbl), FFTBodyAccelerometerJerk.Mean.Z
##   (dbl), FFTBodyGyroscope.Mean.X (dbl), FFTBodyGyroscope.Mean.Y (dbl),
##   FFTBodyGyroscope.Mean.Z (dbl), FFTBodyAccelerometerMagnitude.Mean (dbl),
##   FFTBodyAccelerometerJerkMagnitude.Mean (dbl),
##   FFTBodyGyroscopeMagnitude.Mean (dbl), FFTBodyGyroscopeJerkMagnitude.Mean
##   (dbl), TimeBodyAccelerometer.Standard.deviation.X (dbl),
##   TimeBodyAccelerometer.Standard.deviation.Y (dbl),
##   TimeBodyAccelerometer.Standard.deviation.Z (dbl),
##   TimeGravityAccelerometer.Standard.deviation.X (dbl),
##   TimeGravityAccelerometer.Standard.deviation.Y (dbl),
##   TimeGravityAccelerometer.Standard.deviation.Z (dbl),
##   TimeBodyAccelerometerJerk.Standard.deviation.X (dbl),
##   TimeBodyAccelerometerJerk.Standard.deviation.Y (dbl),
##   TimeBodyAccelerometerJerk.Standard.deviation.Z (dbl),
##   TimeBodyGyroscope.Standard.deviation.X (dbl),
##   TimeBodyGyroscope.Standard.deviation.Y (dbl),
##   TimeBodyGyroscope.Standard.deviation.Z (dbl),
##   TimeBodyGyroscopeJerk.Standard.deviation.X (dbl),
##   TimeBodyGyroscopeJerk.Standard.deviation.Y (dbl),
##   TimeBodyGyroscopeJerk.Standard.deviation.Z (dbl),
##   TimeBodyAccelerometerMagnitude.Standard.deviation (dbl),
##   TimeGravityAccelerometerMagnitude.Standard.deviation (dbl),
##   TimeBodyAccelerometerJerkMagnitude.Standard.deviation (dbl),
##   TimeBodyGyroscopeMagnitude.Standard.deviation (dbl),
##   TimeBodyGyroscopeJerkMagnitude.Standard.deviation (dbl),
##   FFTBodyAccelerometer.Standard.deviation.X (dbl),
##   FFTBodyAccelerometer.Standard.deviation.Y (dbl),
##   FFTBodyAccelerometer.Standard.deviation.Z (dbl),
##   FFTBodyAccelerometerJerk.Standard.deviation.X (dbl),
##   FFTBodyAccelerometerJerk.Standard.deviation.Y (dbl),
##   FFTBodyAccelerometerJerk.Standard.deviation.Z (dbl),
##   FFTBodyGyroscope.Standard.deviation.X (dbl),
##   FFTBodyGyroscope.Standard.deviation.Y (dbl),
##   FFTBodyGyroscope.Standard.deviation.Z (dbl),
##   FFTBodyAccelerometerMagnitude.Standard.deviation (dbl),
##   FFTBodyAccelerometerJerkMagnitude.Standard.deviation (dbl),
##   FFTBodyGyroscopeMagnitude.Standard.deviation (dbl),
##   FFTBodyGyroscopeJerkMagnitude.Standard.deviation (dbl)
```

Summary of variables
--------------------


```r
summary(tidy_data)
```

```
##     subject                   activity  TimeBodyAccelerometer.Mean.X
##  Min.   : 1.0   WALKING           :30   Min.   :0.2216              
##  1st Qu.: 8.0   WALKING_UPSTAIRS  :30   1st Qu.:0.2712              
##  Median :15.5   WALKING_DOWNSTAIRS:30   Median :0.2770              
##  Mean   :15.5   SITTING           :30   Mean   :0.2743              
##  3rd Qu.:23.0   STANDING          :30   3rd Qu.:0.2800              
##  Max.   :30.0   LAYING            :30   Max.   :0.3015              
##  TimeBodyAccelerometer.Mean.Y TimeBodyAccelerometer.Mean.Z
##  Min.   :-0.040514            Min.   :-0.15251            
##  1st Qu.:-0.020022            1st Qu.:-0.11207            
##  Median :-0.017262            Median :-0.10819            
##  Mean   :-0.017876            Mean   :-0.10916            
##  3rd Qu.:-0.014936            3rd Qu.:-0.10443            
##  Max.   :-0.001308            Max.   :-0.07538            
##  TimeGravityAccelerometer.Mean.X TimeGravityAccelerometer.Mean.Y
##  Min.   :-0.6800                 Min.   :-0.47989               
##  1st Qu.: 0.8376                 1st Qu.:-0.23319               
##  Median : 0.9208                 Median :-0.12782               
##  Mean   : 0.6975                 Mean   :-0.01621               
##  3rd Qu.: 0.9425                 3rd Qu.: 0.08773               
##  Max.   : 0.9745                 Max.   : 0.95659               
##  TimeGravityAccelerometer.Mean.Z TimeBodyAccelerometerJerk.Mean.X
##  Min.   :-0.49509                Min.   :0.04269                 
##  1st Qu.:-0.11726                1st Qu.:0.07396                 
##  Median : 0.02384                Median :0.07640                 
##  Mean   : 0.07413                Mean   :0.07947                 
##  3rd Qu.: 0.14946                3rd Qu.:0.08330                 
##  Max.   : 0.95787                Max.   :0.13019                 
##  TimeBodyAccelerometerJerk.Mean.Y TimeBodyAccelerometerJerk.Mean.Z
##  Min.   :-0.0386872               Min.   :-0.067458               
##  1st Qu.: 0.0004664               1st Qu.:-0.010601               
##  Median : 0.0094698               Median :-0.003861               
##  Mean   : 0.0075652               Mean   :-0.004953               
##  3rd Qu.: 0.0134008               3rd Qu.: 0.001958               
##  Max.   : 0.0568186               Max.   : 0.038053               
##  TimeBodyGyroscope.Mean.X TimeBodyGyroscope.Mean.Y
##  Min.   :-0.20578         Min.   :-0.20421        
##  1st Qu.:-0.04712         1st Qu.:-0.08955        
##  Median :-0.02871         Median :-0.07318        
##  Mean   :-0.03244         Mean   :-0.07426        
##  3rd Qu.:-0.01676         3rd Qu.:-0.06113        
##  Max.   : 0.19270         Max.   : 0.02747        
##  TimeBodyGyroscope.Mean.Z TimeBodyGyroscopeJerk.Mean.X
##  Min.   :-0.07245         Min.   :-0.15721            
##  1st Qu.: 0.07475         1st Qu.:-0.10322            
##  Median : 0.08512         Median :-0.09868            
##  Mean   : 0.08744         Mean   :-0.09606            
##  3rd Qu.: 0.10177         3rd Qu.:-0.09110            
##  Max.   : 0.17910         Max.   :-0.02209            
##  TimeBodyGyroscopeJerk.Mean.Y TimeBodyGyroscopeJerk.Mean.Z
##  Min.   :-0.07681             Min.   :-0.092500           
##  1st Qu.:-0.04552             1st Qu.:-0.061725           
##  Median :-0.04112             Median :-0.053430           
##  Mean   :-0.04269             Mean   :-0.054802           
##  3rd Qu.:-0.03842             3rd Qu.:-0.048985           
##  Max.   :-0.01320             Max.   :-0.006941           
##  TimeBodyAccelerometerMagnitude.Mean
##  Min.   :-0.9865                    
##  1st Qu.:-0.9573                    
##  Median :-0.4829                    
##  Mean   :-0.4973                    
##  3rd Qu.:-0.0919                    
##  Max.   : 0.6446                    
##  TimeGravityAccelerometerMagnitude.Mean
##  Min.   :-0.9865                       
##  1st Qu.:-0.9573                       
##  Median :-0.4829                       
##  Mean   :-0.4973                       
##  3rd Qu.:-0.0919                       
##  Max.   : 0.6446                       
##  TimeBodyAccelerometerJerkMagnitude.Mean TimeBodyGyroscopeMagnitude.Mean
##  Min.   :-0.9928                         Min.   :-0.9807                
##  1st Qu.:-0.9807                         1st Qu.:-0.9461                
##  Median :-0.8168                         Median :-0.6551                
##  Mean   :-0.6079                         Mean   :-0.5652                
##  3rd Qu.:-0.2456                         3rd Qu.:-0.2159                
##  Max.   : 0.4345                         Max.   : 0.4180                
##  TimeBodyGyroscopeJerkMagnitude.Mean FFTBodyAccelerometer.Mean.X
##  Min.   :-0.99732                    Min.   :-0.9952            
##  1st Qu.:-0.98515                    1st Qu.:-0.9787            
##  Median :-0.86479                    Median :-0.7691            
##  Mean   :-0.73637                    Mean   :-0.5758            
##  3rd Qu.:-0.51186                    3rd Qu.:-0.2174            
##  Max.   : 0.08758                    Max.   : 0.5370            
##  FFTBodyAccelerometer.Mean.Y FFTBodyAccelerometer.Mean.Z
##  Min.   :-0.98903            Min.   :-0.9895            
##  1st Qu.:-0.95361            1st Qu.:-0.9619            
##  Median :-0.59498            Median :-0.7236            
##  Mean   :-0.48873            Mean   :-0.6297            
##  3rd Qu.:-0.06341            3rd Qu.:-0.3183            
##  Max.   : 0.52419            Max.   : 0.2807            
##  FFTBodyAccelerometerJerk.Mean.X FFTBodyAccelerometerJerk.Mean.Y
##  Min.   :-0.9946                 Min.   :-0.9894                
##  1st Qu.:-0.9828                 1st Qu.:-0.9725                
##  Median :-0.8126                 Median :-0.7817                
##  Mean   :-0.6139                 Mean   :-0.5882                
##  3rd Qu.:-0.2820                 3rd Qu.:-0.1963                
##  Max.   : 0.4743                 Max.   : 0.2767                
##  FFTBodyAccelerometerJerk.Mean.Z FFTBodyGyroscope.Mean.X
##  Min.   :-0.9920                 Min.   :-0.9931        
##  1st Qu.:-0.9796                 1st Qu.:-0.9697        
##  Median :-0.8707                 Median :-0.7300        
##  Mean   :-0.7144                 Mean   :-0.6367        
##  3rd Qu.:-0.4697                 3rd Qu.:-0.3387        
##  Max.   : 0.1578                 Max.   : 0.4750        
##  FFTBodyGyroscope.Mean.Y FFTBodyGyroscope.Mean.Z
##  Min.   :-0.9940         Min.   :-0.9860        
##  1st Qu.:-0.9700         1st Qu.:-0.9624        
##  Median :-0.8141         Median :-0.7909        
##  Mean   :-0.6767         Mean   :-0.6044        
##  3rd Qu.:-0.4458         3rd Qu.:-0.2635        
##  Max.   : 0.3288         Max.   : 0.4924        
##  FFTBodyAccelerometerMagnitude.Mean FFTBodyAccelerometerJerkMagnitude.Mean
##  Min.   :-0.9868                    Min.   :-0.9940                       
##  1st Qu.:-0.9560                    1st Qu.:-0.9770                       
##  Median :-0.6703                    Median :-0.7940                       
##  Mean   :-0.5365                    Mean   :-0.5756                       
##  3rd Qu.:-0.1622                    3rd Qu.:-0.1872                       
##  Max.   : 0.5866                    Max.   : 0.5384                       
##  FFTBodyGyroscopeMagnitude.Mean FFTBodyGyroscopeJerkMagnitude.Mean
##  Min.   :-0.9865                Min.   :-0.9976                   
##  1st Qu.:-0.9616                1st Qu.:-0.9813                   
##  Median :-0.7657                Median :-0.8779                   
##  Mean   :-0.6671                Mean   :-0.7564                   
##  3rd Qu.:-0.4087                3rd Qu.:-0.5831                   
##  Max.   : 0.2040                Max.   : 0.1466                   
##  TimeBodyAccelerometer.Standard.deviation.X
##  Min.   :-0.9961                           
##  1st Qu.:-0.9799                           
##  Median :-0.7526                           
##  Mean   :-0.5577                           
##  3rd Qu.:-0.1984                           
##  Max.   : 0.6269                           
##  TimeBodyAccelerometer.Standard.deviation.Y
##  Min.   :-0.99024                          
##  1st Qu.:-0.94205                          
##  Median :-0.50897                          
##  Mean   :-0.46046                          
##  3rd Qu.:-0.03077                          
##  Max.   : 0.61694                          
##  TimeBodyAccelerometer.Standard.deviation.Z
##  Min.   :-0.9877                           
##  1st Qu.:-0.9498                           
##  Median :-0.6518                           
##  Mean   :-0.5756                           
##  3rd Qu.:-0.2306                           
##  Max.   : 0.6090                           
##  TimeGravityAccelerometer.Standard.deviation.X
##  Min.   :-0.9968                              
##  1st Qu.:-0.9825                              
##  Median :-0.9695                              
##  Mean   :-0.9638                              
##  3rd Qu.:-0.9509                              
##  Max.   :-0.8296                              
##  TimeGravityAccelerometer.Standard.deviation.Y
##  Min.   :-0.9942                              
##  1st Qu.:-0.9711                              
##  Median :-0.9590                              
##  Mean   :-0.9524                              
##  3rd Qu.:-0.9370                              
##  Max.   :-0.6436                              
##  TimeGravityAccelerometer.Standard.deviation.Z
##  Min.   :-0.9910                              
##  1st Qu.:-0.9605                              
##  Median :-0.9450                              
##  Mean   :-0.9364                              
##  3rd Qu.:-0.9180                              
##  Max.   :-0.6102                              
##  TimeBodyAccelerometerJerk.Standard.deviation.X
##  Min.   :-0.9946                               
##  1st Qu.:-0.9832                               
##  Median :-0.8104                               
##  Mean   :-0.5949                               
##  3rd Qu.:-0.2233                               
##  Max.   : 0.5443                               
##  TimeBodyAccelerometerJerk.Standard.deviation.Y
##  Min.   :-0.9895                               
##  1st Qu.:-0.9724                               
##  Median :-0.7756                               
##  Mean   :-0.5654                               
##  3rd Qu.:-0.1483                               
##  Max.   : 0.3553                               
##  TimeBodyAccelerometerJerk.Standard.deviation.Z
##  Min.   :-0.99329                              
##  1st Qu.:-0.98266                              
##  Median :-0.88366                              
##  Mean   :-0.73596                              
##  3rd Qu.:-0.51212                              
##  Max.   : 0.03102                              
##  TimeBodyGyroscope.Standard.deviation.X
##  Min.   :-0.9943                       
##  1st Qu.:-0.9735                       
##  Median :-0.7890                       
##  Mean   :-0.6916                       
##  3rd Qu.:-0.4414                       
##  Max.   : 0.2677                       
##  TimeBodyGyroscope.Standard.deviation.Y
##  Min.   :-0.9942                       
##  1st Qu.:-0.9629                       
##  Median :-0.8017                       
##  Mean   :-0.6533                       
##  3rd Qu.:-0.4196                       
##  Max.   : 0.4765                       
##  TimeBodyGyroscope.Standard.deviation.Z
##  Min.   :-0.9855                       
##  1st Qu.:-0.9609                       
##  Median :-0.8010                       
##  Mean   :-0.6164                       
##  3rd Qu.:-0.3106                       
##  Max.   : 0.5649                       
##  TimeBodyGyroscopeJerk.Standard.deviation.X
##  Min.   :-0.9965                           
##  1st Qu.:-0.9800                           
##  Median :-0.8396                           
##  Mean   :-0.7036                           
##  3rd Qu.:-0.4629                           
##  Max.   : 0.1791                           
##  TimeBodyGyroscopeJerk.Standard.deviation.Y
##  Min.   :-0.9971                           
##  1st Qu.:-0.9832                           
##  Median :-0.8942                           
##  Mean   :-0.7636                           
##  3rd Qu.:-0.5861                           
##  Max.   : 0.2959                           
##  TimeBodyGyroscopeJerk.Standard.deviation.Z
##  Min.   :-0.9954                           
##  1st Qu.:-0.9848                           
##  Median :-0.8610                           
##  Mean   :-0.7096                           
##  3rd Qu.:-0.4741                           
##  Max.   : 0.1932                           
##  TimeBodyAccelerometerMagnitude.Standard.deviation
##  Min.   :-0.9865                                  
##  1st Qu.:-0.9430                                  
##  Median :-0.6074                                  
##  Mean   :-0.5439                                  
##  3rd Qu.:-0.2090                                  
##  Max.   : 0.4284                                  
##  TimeGravityAccelerometerMagnitude.Standard.deviation
##  Min.   :-0.9865                                     
##  1st Qu.:-0.9430                                     
##  Median :-0.6074                                     
##  Mean   :-0.5439                                     
##  3rd Qu.:-0.2090                                     
##  Max.   : 0.4284                                     
##  TimeBodyAccelerometerJerkMagnitude.Standard.deviation
##  Min.   :-0.9946                                      
##  1st Qu.:-0.9765                                      
##  Median :-0.8014                                      
##  Mean   :-0.5842                                      
##  3rd Qu.:-0.2173                                      
##  Max.   : 0.4506                                      
##  TimeBodyGyroscopeMagnitude.Standard.deviation
##  Min.   :-0.9814                              
##  1st Qu.:-0.9476                              
##  Median :-0.7420                              
##  Mean   :-0.6304                              
##  3rd Qu.:-0.3602                              
##  Max.   : 0.3000                              
##  TimeBodyGyroscopeJerkMagnitude.Standard.deviation
##  Min.   :-0.9977                                  
##  1st Qu.:-0.9805                                  
##  Median :-0.8809                                  
##  Mean   :-0.7550                                  
##  3rd Qu.:-0.5767                                  
##  Max.   : 0.2502                                  
##  FFTBodyAccelerometer.Standard.deviation.X
##  Min.   :-0.9966                          
##  1st Qu.:-0.9820                          
##  Median :-0.7470                          
##  Mean   :-0.5522                          
##  3rd Qu.:-0.1966                          
##  Max.   : 0.6585                          
##  FFTBodyAccelerometer.Standard.deviation.Y
##  Min.   :-0.99068                         
##  1st Qu.:-0.94042                         
##  Median :-0.51338                         
##  Mean   :-0.48148                         
##  3rd Qu.:-0.07913                         
##  Max.   : 0.56019                         
##  FFTBodyAccelerometer.Standard.deviation.Z
##  Min.   :-0.9872                          
##  1st Qu.:-0.9459                          
##  Median :-0.6441                          
##  Mean   :-0.5824                          
##  3rd Qu.:-0.2655                          
##  Max.   : 0.6871                          
##  FFTBodyAccelerometerJerk.Standard.deviation.X
##  Min.   :-0.9951                              
##  1st Qu.:-0.9847                              
##  Median :-0.8254                              
##  Mean   :-0.6121                              
##  3rd Qu.:-0.2475                              
##  Max.   : 0.4768                              
##  FFTBodyAccelerometerJerk.Standard.deviation.Y
##  Min.   :-0.9905                              
##  1st Qu.:-0.9737                              
##  Median :-0.7852                              
##  Mean   :-0.5707                              
##  3rd Qu.:-0.1685                              
##  Max.   : 0.3498                              
##  FFTBodyAccelerometerJerk.Standard.deviation.Z
##  Min.   :-0.993108                            
##  1st Qu.:-0.983747                            
##  Median :-0.895121                            
##  Mean   :-0.756489                            
##  3rd Qu.:-0.543787                            
##  Max.   :-0.006236                            
##  FFTBodyGyroscope.Standard.deviation.X
##  Min.   :-0.9947                      
##  1st Qu.:-0.9750                      
##  Median :-0.8086                      
##  Mean   :-0.7110                      
##  3rd Qu.:-0.4813                      
##  Max.   : 0.1966                      
##  FFTBodyGyroscope.Standard.deviation.Y
##  Min.   :-0.9944                      
##  1st Qu.:-0.9602                      
##  Median :-0.7964                      
##  Mean   :-0.6454                      
##  3rd Qu.:-0.4154                      
##  Max.   : 0.6462                      
##  FFTBodyGyroscope.Standard.deviation.Z
##  Min.   :-0.9867                      
##  1st Qu.:-0.9643                      
##  Median :-0.8224                      
##  Mean   :-0.6577                      
##  3rd Qu.:-0.3916                      
##  Max.   : 0.5225                      
##  FFTBodyAccelerometerMagnitude.Standard.deviation
##  Min.   :-0.9876                                 
##  1st Qu.:-0.9452                                 
##  Median :-0.6513                                 
##  Mean   :-0.6210                                 
##  3rd Qu.:-0.3654                                 
##  Max.   : 0.1787                                 
##  FFTBodyAccelerometerJerkMagnitude.Standard.deviation
##  Min.   :-0.9944                                     
##  1st Qu.:-0.9752                                     
##  Median :-0.8126                                     
##  Mean   :-0.5992                                     
##  3rd Qu.:-0.2668                                     
##  Max.   : 0.3163                                     
##  FFTBodyGyroscopeMagnitude.Standard.deviation
##  Min.   :-0.9815                             
##  1st Qu.:-0.9488                             
##  Median :-0.7727                             
##  Mean   :-0.6723                             
##  3rd Qu.:-0.4277                             
##  Max.   : 0.2367                             
##  FFTBodyGyroscopeJerkMagnitude.Standard.deviation
##  Min.   :-0.9976                                 
##  1st Qu.:-0.9802                                 
##  Median :-0.8941                                 
##  Mean   :-0.7715                                 
##  3rd Qu.:-0.6081                                 
##  Max.   : 0.2878
```
