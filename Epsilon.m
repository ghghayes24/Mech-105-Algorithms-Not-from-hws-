clear all
close all
clc
data=[];
e=1;
while e>0
    laste=e
    e=e/2
    data=[data;[e]];
end
data(end-1)
disp(laste)