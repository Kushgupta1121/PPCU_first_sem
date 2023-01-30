% Function to calculate the Gradient on the Image
function [G_x, G_y] = gradient_calculation(Img)   
H_x= [-1 0 1];
H_y= transpose([-1 0 1]);
Img=double(Img);
G_x= imfilter(Img,H_x,'replicate','same'); % gradinent along X-axis
G_y= imfilter(Img,H_y,'replicate','same'); % gradinent along Y-axis

end
