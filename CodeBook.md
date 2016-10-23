## Introduccion
The script run_analysis.R performs the five requierements from the coursera project.

*Read all the files from the data set and create datatables. To merge the trainning and the test sets by row binding.

*To extract the measurements, read the "features.txt" and extracting the mean and standard deviation. Taking only measurements and add "subject" and "activity Num"

*Descriptive activities, enter name of activity into dataTable. Create dataTable with variable means sorted by subject and Activity.

*On the whole dataset, those columns with vague column names are corrected.

*Finally we create an independent tidy data set with the name "TidyData.txt".

##Variables

*dataSubjectTrain, dataSubjectTest, dataActivityTrain, dataActivityTest, dataTrain, DataTest contain all datas from UCI HAR Dataset.

*Merge the data train and data test to create one data, call them alldataSubject and alldataActivity.

*Combine de DATA training and test file into dataTable.

*Name variables according to feature. dataFeatures.

*Column names for activity labels, setnames.

*Merges columns into dataTable. allDataSubject and alldataActivity with dataTable.
