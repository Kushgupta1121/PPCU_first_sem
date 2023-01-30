function [I] = processor(currentimage,verbose)  

%%processor function starts here
% Image Pre-processing steps
gray_image=rgb2gray(currentimage); % converting the image to gray_scale Image
new_gray_image=imadjust(gray_image); % This operation increases the contrast of the output image.
BW=imbinarize(new_gray_image,0.15);% converting gray scale image to binary
%BW=rescale(BW);
edge_img = edge(BW,'canny'); % edge detection using canny edge detector

F=fft2(edge_img); % DFT of the edge Image
Fsh=fftshift(F); % shift all the frequencies to center 
log_Fsh=log(1+abs(Fsh)); 
%figure(2);
%imshow(log_Fsh,[]); title('Log transfer of DFT'); % to plot log magntitude of the DFT

%% to find the angle of rotation.
mag=abs(Fsh); %magnitutde of the fourier
[~,c]=max(mag); % max value of abs value for the magnitutde of the center line in the FFT.

N=length(c);
x1= round(N/2)-15; %determinig the mid-point,x1
x2= round(N/2)+15; %determinig the mid-point,x2

y1= c(round(N/2)-15);  %determinig the mid-point coordinates of y1
y2= c(round(N/2)+15);   %determinig the mid-point coordinates of y1

if y2 > y1
    m= -abs(y1-y2)/(x2-x1);  % calculating slope of the line
    angle= -(90+atand(m));  % determining the angle
else 
    m= abs(y1-y2)/(x2-x1); % calculating slope of the line
    angle= 90-atand(m); % determining the angle

end
I=imrotate(new_gray_image,angle); % final rotated image, 
rot_edge_img=imrotate(edge_img,angle); % final rotated Edge Image


%% Hough Transform
[H] = my_hough(rot_edge_img); % passing the rotated edge image to Hough Transform 

[centre,radii,~]=imfindcircles(rot_edge_img,[20 238]); % using imfindcircles a hough transform function to detect the cricles, where the radii in range from 20,220

%If verbose = true then only the below figures will be shown;
if verbose == true
%%plotting the figure(1)
figure(1);
subplot(121)
imshow(currentimage);title('Original image'); % to plot original Image
subplot(122)
imshow(rot_edge_img);title('Straightend Edge image'); % to plot original Image

%%plotting the figure (2)
figure(2);
subplot(121); 
imshow(I);
viscircles(centre,radii,'Edgecolor', 'r'); title('Original image'); % drawing the red circles to highlight the detected circles. 
subplot(122);
h = imagesc(H);
set(h, 'XData', [1,180]);
title('Hough Space');
xlim([1,180]); xlabel('\theta');
ylabel('r');
colormap(gca,'parula'); colorbar;
axis ij;
else
end

%% X detection inside the circle

end

