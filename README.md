# GettingCleaningData

To create the final table as requested, the following steps were conducted:

1) read X_test from test data folder, in which it contains 2947 observations and 561 variables
2) assign these 561 variables with feature names
3) add subject and activity columns in front of the table to complete the test data table
4) follow the same steps to create training data table
5) row combine test and training data table to form the complete table
6) extract the columns with the name of mean() and std() 
7) calculate the mean based on both subject and activity
