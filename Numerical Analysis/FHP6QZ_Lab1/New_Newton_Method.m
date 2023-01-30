function [result, iteration_number]=New_Newton_Method(fun,fun_der,x0,percision)
result=x0;  % initialize the result
err=inf;   
iteration_number=0;
syms x;
fun_der2=diff(fun_der,x); % Second derivative of the function

%the Newton's method uses the slope of the function to  find the root. The graph of tanh(x) has zero
%slope, around the given interval. Hence the zero slope can't be evaluated
%in the given interval.
while err>percision
    prev_result=result;
    eq1=eval(subs(fun,result));
    eq2=eval(subs(fun_der,result));
    eq3=eval(subs(fun_der2,result));
    result=result - (eq1*eq2)/(eq2^2 -eq1*eq3);
    err=abs(result- prev_result);
    iteration_number=iteration_number+1;
    
end
end