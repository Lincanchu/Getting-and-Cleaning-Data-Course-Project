							Code Book

The run_analysis.R script is used to download and clean the data and then to perform the 5 steps listed in the project requirements.

	1. Download the dataset
		* Dataset downloaded and extracted under the “UCI HAR Dataset” folder

	2. Assign variable names to indicate corresponding data
		* features <- features.txt : 561 rows, 2 columns
		The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals 				tAcc-XYZ and tGyro-XYZ.
		* activities <- activity_labels.txt : 6 rows, 2 columns
		These are the activities performed when the corresponding measurements were taken; their codes (labels) 			were also provided
		* subject_test <- test/subject_test.txt : 2947 rows, 1 column
		Containing test data of 9/30 volunteer test subjects being observed
		* x_test <- test/X_test.txt : 2947 rows, 561 columns
		Containing recorded test data for features
		* y_test <- test/y_test.txt : 2947 rows, 1 columns
		Containing test data of activities’ code labels
		* subject_train <- test/subject_train.txt : 7352 rows, 1 column
		Containing train data of 21/30 volunteer subjects being observed
		* x_train <- test/X_train.txt : 7352 rows, 561 columns
		Containing recorded train data for features
		* y_train <- test/y_train.txt : 7352 rows, 1 columns
		Containing train data of activities’ code labels

	3. Merge the training and test datasets to create one dataset
		* Merging x_train and x_test using the rbind() function to create X (10299 rows, 561 columns)
		* Merging y_train and y_test using the rbind() function to create Y (10299 rows, 1 column)
		* Merging subject_train and subject_test using the rbind() function to create Subject (10299 rows, 1 				column) 
		* Finally merging Subject, Y, and X using the cbind() function to create Merged_Data (10299 rows, 563 				column)
	
	4. Extract measurements on the mean and standard deviation for each measurement
		* Creating Clean_Data (10299 rows, 88 columns) by subsetting Merged_Data, selecting the following 				columns: subject, code, and the measurements on the mean and standard deviation (std) for each 					measurement
	
	5. Use descriptive activity names to name the activities in the dataset
		* Using activity names taken from second column of the activities variable to replace the codes 
		(numbers) in Clean_Data

	6. Label the dataset with descriptive variable names
		* Numbers in the code column in Clean_Data renamed as activities
		* All Acc in column’s name replaced by Accelerometer
		* All Gyro in column’s name replaced by Gyroscope
		* All BodyBody in column’s name replaced by Body
		* All Mag in column’s name replaced by Magnitude
		* All start with character f in column’s name replaced by Frequency
		* All start with character t in column’s name replaced by Time

	7. On the basis of Clean_Data (step 4), creating a second dataset with the average of each variable for each 			activity and each subject
		* Creating Second_Dataset (180 rows, 88 columns) by grouping Subject and Activity, and then summarizing 			the means of each variable for each activity and each subject
		* Exporting Second_Dataset into Second_Dataset.txt file
