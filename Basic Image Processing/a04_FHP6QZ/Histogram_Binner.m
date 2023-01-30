% Function to calculate the orientation histogram for each region
function H = Histogram_Binner(theta, phi, mag)

h=zeros(3,3);
%Defining the Min/Max theta and Phi values for the orientation binning
mini_theta= -90;
maxi_theta= -30;
mini_phi= -90;
maxi_phi= -30;


% putting values in the h matirx
for i=1:3
    maxi_phi= -30;
    mini_phi= -90;
    for j=1:3
    Log_mask=  (phi >= mini_phi & phi < maxi_phi & theta >= mini_theta & theta < maxi_theta );
    h(i,j)=sum(mag(Log_mask),'omitnan');
    maxi_phi=maxi_phi+60;
    mini_phi=mini_phi+60;
    
    end
    maxi_theta=maxi_theta+60;
    mini_theta=mini_theta+60;
   
end
H=[];
    for i=1:3
        H=[H,h(i,:)];
    end
  H=H/sum(H);
end
