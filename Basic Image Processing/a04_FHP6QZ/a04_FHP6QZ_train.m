%================================================================================================
%FHP6QZ-Assignment_04:-This is the Main script,running this will load the training data(set of Images),
%calls the function gradient_calculation which will calculate the 3D GLOH from the training data,
%extract and accumulate the output features(store them in a accumulator) for the called function
%(get_features.m), prepare labels for the train dataset and train classifier model using the 
% labelled dataset.
%================================================================================================

% loading the training data
load training_data

Img=5; %image from which the features are to be extracted, (value should be between 5 and 46)

if Img<5 || Img>46
    error('The Image frame must be choosen between 5 & 46');
end

% % walking feature extraction
EXTRACTED_WALKING_FEATURES=[];
for i=1:10
    Walking=train_walking(:,:,:,i);
    sift_Points=detectSIFTFeatures(Walking(:,:,Img));
    [~, idx] = sort(sift_Points.Metric, 'descend');
    Feature_points=sift_Points(idx(1:5));

    [Features] = get_features(Walking, Img, Feature_points);
    EXTRACTED_WALKING_FEATURES=[EXTRACTED_WALKING_FEATURES;Features];
end

% clapping feature extraction
EXTRACTED_CLAPPING_FEATURES=[];
for i=1:10
    Clapping=train_clapping(:,:,:,i);
    sift_Points=detectSIFTFeatures(Clapping(:,:,Img));
    [~, idx] = sort(sift_Points.Metric, 'descend');
    Feature_points=sift_Points(idx(1:5));

    [Features] = get_features(Clapping, Img, Feature_points);
    EXTRACTED_CLAPPING_FEATURES=[EXTRACTED_CLAPPING_FEATURES;Features];
end

% boxing feature extraction
EXTRACTED_BOXING_FEATURES=[];
for i=1:10
    Boxing=train_boxing(:,:,:,i);
    sift_Points=detectSIFTFeatures(Boxing(:,:,Img));
    [~, idx] = sort(sift_Points.Metric, 'descend');
    Feature_points=sift_Points(idx(1:5));

    [Features] = get_features(Boxing, Img, Feature_points);
    EXTRACTED_BOXING_FEATURES=[EXTRACTED_BOXING_FEATURES;Features];
end

%================================================================================================================================
% Since we have collected all the features from the training dataset. Now we have to prepare labels (Class) for the corresponding 
% training dataset. We can create class labels by putting the labels in a variable called "Class" that we will provide labels to the 
% classified model. Along with labels we'll provide the features extracted from the training dataset for training the classifier.
%================================================================================================================================


Class=["w";"w";"w";"w";"w";"w";"w";"w";"w";"w";"C";"C";"C";"C";"C";"C";"C";"C";"C";"C";"B";"B";"B";"B";"B";"B";"B";"B";"B";"B"];
%================================================================================================================================
%class labels :{"W":"WALKING","C":"CLAPPING","B":"BOXING"}
%================================================================================================================================

% combining all the extracted features.
Training_Data=[EXTRACTED_WALKING_FEATURES;EXTRACTED_CLAPPING_FEATURES;EXTRACTED_BOXING_FEATURES]; 

%Passing the training data set and class labels to train the classifier model.
%The classifier model [Classification Neural Network] (which had the highest accuracy amongst others) had already been trained and stored in the folder named
% action_classifier.mat
