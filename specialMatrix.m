function [A] = specialMatrix(n,m)
% This function should return a matrix A as described in the problem statement
% Inputs n is the number of rows, and m the number of columns
% It is recomended to first create the matrxix A of the correct size, filling it with zeros to start with is not a bad choice
A=zeros(n,m);
for i=1:n
    for j=1:m
       if i==1
           A(i,j)=j;
       elseif j==1
           A(i,j)=i;
       else
           A(i,j)=A(i-1,j)+A(i,j-1)
       end
    end
end

% Now the real challenge is to fill in the correct values of A


end
% Things beyond here are outside of your function
