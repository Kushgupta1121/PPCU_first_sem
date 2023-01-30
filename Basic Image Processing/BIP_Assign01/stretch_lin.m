function output_img = stretch_lin(input_img)
input_img=double(input_img);
Max_Intensity_Value= max(input_img,[],'all');
Min_Intensity_Value= min(input_img,[],'all');
output_img=input_img;
dim=size(input_img);
for i=1:dim(1)
    for j=1:dim(2)
        output_img(i,j)=(255*(input_img(i,j)- Min_Intensity_Value))/(Max_Intensity_Value - Min_Intensity_Value);
    end
end
output_img=uint8(output_img);

end
