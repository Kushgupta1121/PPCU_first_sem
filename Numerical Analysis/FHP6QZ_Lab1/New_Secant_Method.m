function [xn, iteration_num]=New_Secant_Method(fun,x1,percision)
err=1;
dx=0.1; 
iteration_num=0;
n=0;
xmax=50; xmin=-50;  

while err>percision
    n=n+1;
    if abs(eval(subs(fun,x1))*(dx*x1)/(eval(subs(fun,x1+dx*x1))- eval(subs(fun,x1))))<0.01
        xn=x1 - eval(subs(fun,x1))*(dx*x1)/(eval(subs(fun,x1+dx*x1))- eval(subs(fun,x1))); 
    else
    %if the graph is flat near the given point, look for part of the graph where there is significant slope
    xn=inf;
    if (eval(subs(fun,x1+dx*x1))- eval(subs(fun,x1)))>0.1 || (eval(subs(fun,x1+dx*x1))- eval(subs(fun,x1)))<0.1
        if xmax==xn
            xmin=x1-(50/n);
        end
        if xmin==xn
            xmax=x1-(50/n);
        end
            
         
        if abs(eval(subs(fun,xmin))-eval(subs(fun,xmax)))>0.1
            xn=(xmin+xmax)/2;
            if (eval(subs(fun,xmin)))*(eval(subs(fun,xn)))<0
                xmax=xn;
                xn=(xmin+xmax)/2;
                
            else
                xmin=xn;
                xn=(xmin+xmax)/2;
            end
        end
           
        
    end
    end
    
    iteration_num=iteration_num+1;
    err=abs(xn- x1);
    x1=xn; 
end
end