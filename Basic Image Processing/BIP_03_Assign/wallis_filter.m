function output = wallis_filter(I)
I=double(I); 
[n1,n2] = size(I); 
output=zeros(n1,n2); % Initializing output 
local_contrast=0; % Initalizing local contrast as 0
local_avg=0;  % Initalizing local average as 0
mod_n = abs(n1*n2); % calculating mod N
p=0.2; % Defining the P value
range=[min(I(:)) max(I(:))]; % calculating the Dyanmic range of the Image
mean_d= 0.5 * max(range) ; % calculating the Desired Mean 
sigma_d= 0.2 * max (range);  % calculating the Desired Sigma
A_max = 2; % defining A_max value

%-----calculating local average----------
for x=1:size(I,1)
    for y=1:size(I,2)
        local_avg=local_avg+I(x,y);
    end
end

local_avg = local_avg/mod_n;
%-----------------------------
%-----calculating local contrast----------
for i=1:size(I,1)
    for j=1:size(I,2)
        temp=(I(i,j)-local_avg).^2;
        local_contrast=local_contrast+temp;
    end
end

local_contrast= sqrt(local_contrast)/mod_n;
%-----------------------------
%---------Using the wallis filter formula to compute the final output
%Image------
for i= 1:size(I,1)
    for j=1:size(I,2)
    output(i,j)= ((I(i,j)-local_avg) * ((A_max*sigma_d)/(A_max*local_contrast+sigma_d)) + (p*mean_d+(1-p)*local_avg));
    end
end
end
