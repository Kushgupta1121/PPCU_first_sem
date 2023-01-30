function [H] = my_hough(input_img)
%% Hough Transform function 
dia=77; % manually calculating the diameter and radius of the circle
r=round(dia/2); % radius of the circle
H = zeros(size(input_img)); % defining hough space
for i1 = 1:size(input_img, 1)
    for i2 = 1:size(input_img, 2)
        if input_img(i1, i2) > 0
            for theta = 0:360
                a= round(i2- r*cosd(theta)); %polar coordinate for center,a
                b= round(i1- r*sind(theta)); %polar coordinate for center,b
                H(b,a) = H(b,a)+1; %voting 
            end
        end
    end
end

end