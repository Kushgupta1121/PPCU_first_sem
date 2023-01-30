function ClassMap = recognition_phase(I, MODEL)

ClassMap = zeros(size(I)); % declaring ClassMap

%recognition
N= 1/(15*15) * ones(15);  % Smoothing matrix
h = size (I,2);   % declaring the height
w = size (I,1);   % declaring the weight
BB=zeros(w,h,9);

for k=1:9
    B = conv2(I,laws_kernel(k),'same'); % calculating the convolution with laws kernel
    B_star=conv2(B.^2,N,'same'); % smoothing the values
    BB(:,:,k) = B_star; 
end

for x = 1:w
    for y = 1:h
        sum_abs_diff = [];
        for n = 1:size(MODEL,1)
            a = BB(x,y,:);
            b = MODEL(n,:);
            sum_abs_diff(n) = sum(abs(a(:)-b(:)),'all');  % computing the absolute value
        end
         [i,j]= min(sum_abs_diff);
         ClassMap(x,y)= j; % picking the class where the difference is minmum between image texture and training texture
        
    end
end

end

