clc
clear all
close all
format long

xi=4.43;
ea=100;
iter=0;
while ea>.00001
    iter=iter+1
    xi=xi
    fx=(.5*xi^3)-(4*xi^2)+(6*xi)-2;
    fp=(1.5*xi^2)-(8*xi)+6;
    xn=xi-(fx/fp);
    ea=abs((100*(abs(xn-xi)/xn)));
    if ea<=.00001
        disp(xn)
        disp(ea)
        disp(iter)
        break
    end
    xi=xn
end