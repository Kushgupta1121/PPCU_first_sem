function [Segmentated_img]= segmentation(Img,num)
for i=1:size(Img,3) % iterating on RGB plane and storing it in the output
Img1=Img(:,:,i); % seperating the RGB values

I = Img1;
I = mat2gray((I));
%Defining the training Image set of Images for the segmentation part
if num == 1
T1 = I(540:590,140:190);
T2 = I(350:450,360:455);
T3 = I(300:400,20:120);

elseif num == 2
T1 = I(300:400,150:250); 
T2 = I(440:540,620:720); 
T3 = I(230:300,350:370); 

elseif num == 3
T1 = I(1:100,150:250); 
T2 = I(500:600,600:700); 
T3 = I(350:450,450:550); 

elseif num == 4
T1 = I(30:130,200:300); 
T2 = I(80:180,460:560); 
T3 = I(460:560,120:220); 

elseif num == 5
T1 = I(150:250,250:350);
T2 = I(300:400,600:700); 
T3 = I(300:400,600:700);
end

T_cell = {T1, T2, T3}; 
MODEL = training_phase(T_cell); % passing the training cells to the Model to convolve with Laws kernel

GUESS=zeros(size(Img1,1),size(Img1,2));
VOTED=zeros(size(Img1,1),size(Img1,2));

Gr = recognition_phase(I, MODEL); % Passing the Images and the Model to Recognition phase

%VOTED = majority_voting(GUESS, 5);
GUESS=Gr+GUESS;
V = majority_voting(GUESS, 6); % Getting Majority Voting on the segmented Image
VOTED=V+VOTED;
end
Segmentated_img=VOTED; % Final segmented Image.
end
