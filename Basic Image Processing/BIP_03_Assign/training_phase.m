function MODEL = training_phase(T_cell)
N= length(T_cell);
MODEL = zeros(N,9); %

for n= 1: N
    for k = 1:9
         A= conv2(T_cell{n},laws_kernel(k),'same');  % Convolution of the texture Image using different kernels
         height=size(T_cell{n},2); % height of texture Image
         width=size(T_cell{n},1);  % width of texture Image
         sum=0;
         for x=1:width
             for y=1:height
                 sum = sum + A(x,y)^2; % to calculate summation of A(x,y)^2

             end
         end
         MODEL(n,k)= (1/ (height * width)) * sum; % to place the kth element of vector describing the nth texture

    end    

end

end
