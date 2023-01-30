clc;
clear;

current_directory=cd; % saving the current working directory location
image_dir=(fullfile(cd,'input')); % Creating image path, Folder where all the images are stored
cd(image_dir); % changing current working directory to image folder

Image_name='img5.png'; % PLEASE ENTER THE IMAGE NAME HERE ex.(img1.png,img2.png), you would like to process 

I = imread(Image_name); % reading the entered image 

% Using If loop to select the corresponding Loc.txt file for the ENTERED
% Image.
if (Image_name == 'img1.png')
file= 'loc1.txt'; num=1;
elseif (Image_name == 'img2.png')
file= 'loc2.txt'; num=2;
elseif (Image_name == 'img3.png')
file= 'loc3.txt'; num=3;
elseif (Image_name == 'img4.png')
file= 'loc4.txt'; num=4;
elseif (Image_name == 'img5.png')
file= 'loc5.txt'; num=5;
end
formatSpec = '%f'; % specifiying format spec
f = fopen(file,'r'); % opeing the file txt file in read mode
A = fscanf(f,formatSpec); % Scanning the file
F=[transpose(A(1:20,1)); transpose(A(21:40,1))]; %storing the corresponding X,Y co-ordinates at different timestamps.

fclose('all'); % closing all the opened files
cd(current_directory); % moving back to the main working directory
%------PSF----------
X=F(1,:); % Selecting all the X co-ordinates
Y=F(2,:); % Selecting all the Y co-ordinates

k = fspecial('gaussian',9,1); % creating gaussian kernel.

X_max=max(X); % storing max value of X
Y_max=max(Y); % storing max value of Y

PSF=zeros(Y_max+1,X_max+1); % defining Point spread fucntion

[k_x_lim,k_y_lim]=size(k); 

PSF=padarray(PSF,[floor(k_y_lim/2),floor(k_x_lim/2)],0,'both'); %padding PSF matrix with 0 by K_x_lims and K_y_lims.

[h_x_lim,h_y_lim]=size(PSF);

for i=1:size(F,2)
row1 = X(i)+floor(k_x_lim/2)+1; 
column1 = Y(i)+floor(k_y_lim/2)+1; 
row2 = row1+floor(k_x_lim/2);
column2 = column1+floor(k_y_lim/2);
temp(column1-floor(k_y_lim/2):column2,row1-floor(k_x_lim/2):row2)=PSF(column1-floor(k_y_lim/2):column2,row1-floor(k_x_lim/2):row2); % storing the initial value of the PSF into a temporary matrix
PSF(column1-floor(k_y_lim/2):column2,row1-floor(k_x_lim/2):row2)= k+temp(column1-floor(k_y_lim/2):column2,row1-floor(k_x_lim/2):row2);
end

%-------------normalization of PSF matrix-------------------------
matsum=sum(PSF,"all"); % taking summ of all elements of PSF Matrix.

for i=1:size(PSF,1)
    for j=1:size(PSF,2)
        PSF(i,j)= PSF(i,j)/matsum; % normalizing the PSF matrix.
    end
end
%--------------------output 1-----------------------------------------
figure(1)
subplot(121)
plot(X,Y,'-s');
title('GPS/IMU Data');
subplot(122)
imagesc(PSF);
colormap(gray); colorbar;
set(gca,'YDir','normal');
title('Assumed PSF');

%--------------------------------------------------------------------------
%Deconv using RL ----output 2
[restored_img,P] = deconvblind(I,PSF);  % calling RL deconv function and passing original Image and the PSF
%restored_img=Richardson_Lucy_reconstruction(I,PSF);
alpha=1;
%if alpha==1
%    restored_img = I;
%    alpha=alpha+1;
%end
%count=1;
%while count <= 40
%[restored_img]=Richardson_Lucy_reconstruction(I,restored_img,PSF);
% count=count+1;
%end
figure(2)
subplot(121)
imshow(I) % Original Image
title('Original (Degraded) Image');
subplot(122)
imshow(restored_img); % Restored Image
title('Restored (R-L deconv. Image)');

%--------------------------------------------------------------------------
% Wallis filter----output 3-----------------------------------------------
for i=1:size(restored_img,3) % iterating on Wallis filter on RGB plane and storing it in the output
    I=restored_img(:,:,i);
Output(:,:,i)=wallis_filter(I);
end
Output_wallis=uint8(Output); % output of the wallis filter
figure(3)
subplot(121)
imshow(restored_img); % Restored RL Deconv Image
title('Restored (R-L deconv. Image)');
subplot(122)
imshow(Output_wallis); % Wallis filtered Image
title('Wallis Filtered deconv. Image)');
%-------------------------------------------------------------------------
%-------------------------Output 4----------------------------------------
[Segmentated_img]= segmentation(Output,num); % calling the segmentation function
figure(4);
imagesc(Segmentated_img); axis equal off; title('Segmented Terrain Image');
%subplot(122); imagesc(VOTED); axis equal off; %title({'Output + majority voting',[num2str(CORRECT2), '% accurate']});

