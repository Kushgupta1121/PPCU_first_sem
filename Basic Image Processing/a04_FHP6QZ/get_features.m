%================================================================================================
% The image sequence (50 frames), the selected image from which the SIFT features were extracted 
% and the sift points(location of the selected sift points) are given as
% the input argument to the function.
%================================================================================================

function [descriptor_feature_vector] = get_features(action, selected_img, sift_points)

% Initialzing the Descriptor feature vector to store all the extracted
% features in the image sequence.
descriptor_feature_vector=[]; 

% For loop to iterate through all the 5 strongest SIFT points
for n=1:5 
    x=floor(sift_points.Location(n,1));
    y=floor(sift_points.Location(n,2));
    r=15;
% Initialzing space_time_cylinder to store the 3D consecutive disks around the detected SFIT Point
    space_time_cylinder=[];

    for i= selected_img-4: 1 : selected_img+4
        selected_image=action(:,:,i);

        % Defining Meshgrid of the size of the selected_image
        [xgrid, ygrid] = meshgrid(1:size(selected_image,2), 1:size(selected_image,1));
       
        %Defining Mask to select Circular region of 31 pixels diameter around the selected SIFT point
        mask = ((xgrid-x).^2 + (ygrid-y).^2) <= r.^2; 
        selected_region = selected_image.*mask;
        
        % Removing the unselected parts
        selected_region=crop_img(selected_region,x,y,r); 
        space_time_cylinder=cat(3,space_time_cylinder,selected_region);
    end
%================================================================================================    
    % The cylinder around one of the selected sift features has been
    % created.
    % Dividing the circles in the cylinder into 17 parts with the specified
    % criterion.
    %  0< r ≤ 6 and 6 < r ≤ 11 and 11 < r and angle is 45 degrees for each region except region 1 
    % which is a complete circle
%================================================================================================
    region1=[];
    [xgrid, ygrid] = meshgrid(1:size(space_time_cylinder(:,:,5),2), 1:size(space_time_cylinder(:,:,5),1));
    mask = ((xgrid-16).^2 + (ygrid-16).^2) <= 6.^2;

    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,16,16,6);
        region1=cat(3,region1,regions);
    end

    region2=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))>=-45& atand((ygrid-16)./(xgrid-16))<0 & xgrid>15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,24,12,4);
        region2=cat(3,region2,regions);
    end


    region3=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))>=-90& atand((ygrid-16)./(xgrid-16))<-45 & xgrid>15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,20,8,4);
        region3=cat(3,region3,regions);
    end

    region4=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))>=45 & ygrid<15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,12,8,4);
        region4=cat(3,region4,regions);
    end


    region5=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))>=0& atand((ygrid-16)./(xgrid-16))<45 & ygrid<15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,9,12,3);
        region5=cat(3,region5,regions);
    end

    region6=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))>=-45 & ygrid>15 & xgrid<15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,8,20,4);
        region6=cat(3,region6,regions);
    end


    region7=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))<-45 & ygrid>15);
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,13,23,4);
        region7=cat(3,region7,regions);
    end



    region8=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))<=90 & atand((ygrid-16)./(xgrid-16))>45 & ygrid>15);
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,20,24,4);
        region8=cat(3,region8,regions);
    end

    region9=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) <= 11.^2 & ((xgrid-16).^2 + (ygrid-16).^2) > 6.^2 & atand((ygrid-16)./(xgrid-16))<=45 & atand((ygrid-16)./(xgrid-16))>0 & ygrid>15);
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,24,20,4);
        region9=cat(3,region9,regions);
    end



    region10=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2  & atand((ygrid-16)./(xgrid-16))>=-45& atand((ygrid-16)./(xgrid-16))<0 & xgrid>15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,29,11,5);
        region10=cat(3,region10,regions);
    end


    region11=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2 & atand((ygrid-16)./(xgrid-16))>=-90& atand((ygrid-16)./(xgrid-16))<-45 & xgrid>15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,21,4,6);
        region11=cat(3,region11,regions);
    end


    region12=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2  & atand((ygrid-16)./(xgrid-16))>=45 & ygrid<15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,11,5,5);
        region12=cat(3,region12,regions);
    end

    region13=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2  & atand((ygrid-16)./(xgrid-16))>=0& atand((ygrid-16)./(xgrid-16))<45 & ygrid<15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,5,11,5);
        region13=cat(3,region13,regions);
    end

    region14=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2 & atand((ygrid-16)./(xgrid-16))>=-45 & ygrid>15 & xgrid<15 );
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,5,21,6);
        region14=cat(3,region14,regions);
    end

    region15=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2 & atand((ygrid-16)./(xgrid-16))<-45 & ygrid>15);
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,11,30,5);
        region15=cat(3,region15,regions);
    end

    region16=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2 & atand((ygrid-16)./(xgrid-16))<=90 & atand((ygrid-16)./(xgrid-16))>45 & ygrid>15);
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,21,28,6);
        region16=cat(3,region16,regions);
    end


    region17=[];
    mask = (((xgrid-16).^2 + (ygrid-16).^2) > 11.^2 & atand((ygrid-16)./(xgrid-16))<=45 & atand((ygrid-16)./(xgrid-16))>0 & ygrid>15);
    for m=1:9
        regions = space_time_cylinder(:,:,m).*mask;
        regions=crop_img(regions,30,22,6);
        region17=cat(3,region17,regions);
    end
%================================================================================================
% The 17 regions were identified. 
%================================================================================================
    
    %Calculating L_x,L_y and L_t for each region.

    structure={region1,region2,region3,region4,region5,region6,region7,region8,region9,region10,region11,region12,region13,region14,region15,region16,region17};
    % Defining an Accumulator to store the 153=17*9 descriptor features
    Accumulator=[]; 
    for s=1:17
        S=structure{s};
        L_x=zeros(size(S(:,:,1))); 
        L_y=L_x;
        L_t=L_x;


        for i=1:9
            % Calculating gradient for each region of the consecutive disk
            [G_x, G_y] = gradient_calculation(S(:,:,i)); 
            % For each region of the consecutive disks, calculating the 3D gradients
            G_t= gradient_calculation_3D(S(:,:,i),i,S);  
            L_x=L_x+G_x;
            L_y=L_y+G_y;
            L_t=L_t+G_t;
        end
        Mag_3D=sqrt(L_x.^2 + L_y.^2+ L_t.^2); % calculating the Magnitutde 
        theta= rad2deg(atan(L_y./L_x)); % calculating the Theta 
        phi= rad2deg(atan(L_t./sqrt(L_x.^2 + L_y.^2))); % calculating the value of phase phi

        H = Histogram_Binner(theta, phi, Mag_3D); % passing all the magnitutde,thetha,phi values to histogram binner function 
        Accumulator=[Accumulator,H]; % storing the values in the accumulator.



    end


    descriptor_feature_vector=[descriptor_feature_vector,Accumulator];

end
end






