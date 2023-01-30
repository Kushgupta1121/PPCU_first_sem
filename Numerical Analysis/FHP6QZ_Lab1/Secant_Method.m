function [xn, iteration_number]=Secant_Method(fun,x0,x1,percision) % Passing the values to the function
err=1;
iteration_number=0;   % initialize the iteration number
while err>percision
    xn=x1- eval(subs(fun,x1))*(x1-x0)/(eval(subs(fun,x1))-eval(subs(fun,x0))); % evaluate the function 
    iteration_number=iteration_number+1;   
    err=abs(xn- x1);  
    x0=x1; 
    x1=xn; 
end
end