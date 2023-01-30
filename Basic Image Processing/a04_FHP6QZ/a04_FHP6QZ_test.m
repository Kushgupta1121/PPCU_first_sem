%================================================================================================
% Test script loads the test data, the classifier model trained on Neural Network(action_classifier)
% on the training data. Upon running the test script, it extract the features from the given test data 
% set and a certain action is prediction by the trained classifier model.
%================================================================================================

% loading the test data
load test_data

% loading the trained model
load action_classifier

Img=5; %image from which the features are to be extracted, (value should be between 5 and 46)
if Img<5 || Img>46
    error('The selected frame should be between 5 and 46');
end

% For loop to iterate through all the test data images and extract features
% from them.
for i=1:5 
    test=test_data(:,:,:,i);
    
    sift_points=detectSIFTFeatures(test(:,:,Img));
    [~, idx] = sort(sift_points.Metric, 'descend');
    feature_points=sift_points(idx(1:5));
    % Extracting and storing the extracted features from the Test Images.
    [Features] = get_features(test, Img, feature_points);
    
    % Passing the features extracted from the test images to the Trained
    % model
    predicted_output = trainedModel.predictFcn(Features);
    
    % Displaying the predicted Output result.
    if predicted_output=="w" % If W then the person is Walking
        fprintf('Test Image %d: Walking! \n',i);
        for j=1:50
            imshow(test(:,:,j))
            title("Walking!")
        end
    elseif predicted_output=="C" % If C then the person is Clapping
        fprintf('Test Image %d: Clapping! \n',i);
        for j=1:50
            imshow(test(:,:,j))
            title("Clapping!")
        end

    elseif predicted_output=="B" % If B then the person is Boxing
        fprintf('Test Image %d: Boxing! \n',i);
        for j=1:50
            imshow(test(:,:,j))
            title("Boxing!")
        end
    
    
    end



end




