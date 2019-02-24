# This codebook contains relevant information about the data and variables used/generated in run_analysis.R

After downloading and extracting data. Input data is loaded into following dataFrames

*featuresList*: list of all 561 features

*ActivityLabels*: labels and description of activities

*test_features_data*: test data for 561 features

*test_subject*: test data for subject id (a number between 1 and 30)

*test_activity_data*: test data for activity label (a number between 1 to 6)

*train_features_data: training data for 561 features

*train_subject*: training data for subject id (a number between 1 and 30)

*train_activity_data*: training data for activity label (a number between 1 to 6)

Step 1. Merge train and test data using rbind and put into 
*Combined_features,
Combined_subject,
Combined_activity*

Step 2. i. Change *Combine_activity* data from labels to descriptions. use mutate and then drop 

        ii. Create an array that contains all subject ids
        
Step 3. Extract columns from the *Combine_features* with mean and std. deviation data for all features. Use grep with "mean|std" 
and remember to exclude meanFreq as first grep will take meanFreq as well. Save the list of column names in *MeanStd_Features*. 
Subset "Combined_features" and create *MeanStd_Data* 

Step 4. Add columns for subject_id and Activity in *MeanStd_data* using cbind

Step 5. Group the *MeanStd_Data* by Activity and subjects using group_by and create *activity_group*. Finally use summarise_all with inputs 
as grouped data in *activity_group* and  function *mean* to calculate mean for each feature, subject and activity pair. The final tidy 
dataset is saved in *Tidy_data*. 
## Tidy_data contains 68 features 1. activity, 2. subject_id, 3:68. features for which mean and std was extracted. It contain 180 rows
of activity-subject pairs and mean calculated over features data.
