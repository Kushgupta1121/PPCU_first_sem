function [xn, iteration_number]=Bisection_Method(fun,x0,x1,percision)
iteration_number=1; % initalize the iteration_number
err=inf; % initializng error to infinity
syms x;
% check given numbers for end points of the interval are roots
if fun(x1)==0
    xn=x1;
    return
elseif fun(x0)==0
    xn=x0;
    return
end
% check solution for the function in the given interval
s1=fun(x0);
s2=fun(x1);
if (s1*s2)>0
    xn=nan;
    fprintf('\n \n')
    disp('No root found or more than one root in the given interval')
    return
end

if fun(x0)*fun(x1)<0  
    xn=(x1+x0)/2;
    
    while err>percision
        err=xn;
        iteration_number=iteration_number+1;
        if fun(xn)==0
            return
        end
        if fun(x0)*fun(xn)<0
            x1=xn;
            xn=(x0+x1)/2;
        elseif fun(x1)*fun(xn)<0
            x0=xn;
            xn=(x1+x0)/2;
        end
        err=abs(err-xn);
    end
end
end
        
        
        
    