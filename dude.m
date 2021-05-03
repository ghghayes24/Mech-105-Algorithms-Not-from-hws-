clc
clear all
close all
xi=3.25;
x0=2.37;
x1=3.25;
x2=3.83;
y0=16.05181;
y1=6.59273;
y2=.30382;
format long 
y0*(((2*xi)-x1-x2)/((x0-x1)*(x0-x2)))+y1*(((2*xi)-x0-x2)/((x1-x0)*(x1-x2)))+y2*(((2*xi)-x0-x1)/((x2-x0)*(x2-x1)))