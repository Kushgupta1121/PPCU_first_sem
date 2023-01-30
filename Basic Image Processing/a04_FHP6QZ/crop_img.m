% Function for crop part of the image
function Img_cropped = crop_img(image, x_center, y_center,radius)

%Defining the size of the rectangel used for cropping
rect=[x_center-radius-1,y_center-radius-1,radius*2+1,radius*2+1]; 

%cropping the image using the rectangel
Img_cropped = imcrop(image,rect);
%imshow(Img_cropped)
end