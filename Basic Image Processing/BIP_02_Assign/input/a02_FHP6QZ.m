% Get list of all jpg files in this directory
% DIR returns as a structure array. using name() and . to get
% the file names.
clc;
clear all;
close all;
image_files = dir('*.jpg');
nfiles = length(image_files); % Number of files found
count=0;  % initalize count = 0 to count the number of images in the folder.
for i=1:nfiles
current_filename = image_files(i).name; % get all the images one by one from the input folder
current_image = imread(current_filename); % reading all images one by one from the input folder
verbose = true ; % default value of verbose is false; set to true to see fig.
I=processor(current_image,verbose); %calling the processor function, and passing all the images one by one to the function.
count=count+1; % gives the value of total images processed.
end
X = ['Processed total ',num2str(count),' Images'];
disp(X);