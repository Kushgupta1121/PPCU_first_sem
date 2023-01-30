function [xn, iteration_number]=Fixed_Point_Method(fun,x0,percision)
syms x;
err=inf;
iteration_number=0;

while err>percision
    xn=eval(subs(fun,x0));
    err=abs(xn - x0);
    iteration_number=iteration_number+1;
    x0=xn;
    
end
end