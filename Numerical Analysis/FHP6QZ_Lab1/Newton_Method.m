function [result, iteration_number]=Newton_Method(fun,fun_der,x0,percision)
result=x0; % storing initial results
err=inf;  % initializng error to infinity
syms x;
result=x0;
iteration_number=0;

while err>percision   
    previous_result=result;
    eq1=eval(subs(fun,result));   % evaluate the function 
    eq2=eval(subs(fun_der,result)); % evaluate the function derivation 
    result=result - (eq1)/(eq2);    
    err=abs(result- previous_result);
    iteration_number=iteration_number+1;
end
end
