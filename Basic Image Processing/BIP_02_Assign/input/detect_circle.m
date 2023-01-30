clc;
clear all;
close all;
 currentimage= imread('/Users/kushgupta/Documents/MATLAB/BIP_02_Assign/input/8.jpg');
gray_image=rgb2gray(currentimage); % converting the image to gray_scale Image
new_gray_image=imadjust(gray_image); % This operation increases the contrast of the output image.
BW=imbinarize(new_gray_image,0.3);% converting gray scale image to binary
%BW=rescale(BW);
edge_img = edge(BW,'canny'); % edge detection using canny edge detector

%imshow(BW);
stat= regionprops(BW,'basic');
%disp(stat);

bb2=[0.80 0.80];
disp(bb2);

object2=imcrop(BW,bb2);
imshow(object2);