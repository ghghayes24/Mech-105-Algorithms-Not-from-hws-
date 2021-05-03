A = [10, 2, -1; 
    -3, -6, 2;
    1, 1, 5];
function [L, U, P] = luFactor(A)
if nargin<1
    error('Need more input arg.s');
end
[m,n]=size(A);
if m~=n
    error('Needs to be a matrix where rows=collumns');
else
    for row=1:m
        for collumn=1:n
            if A(row,collumn)==0
                error('Matrix cannot have "0" terms')
            end
        end
    end
end
% luFactor(A)
L=zeros(m);
U=A;
P=eye(m);
posU=abs(U);
%	LU decomposition with pivoting
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%       P = the permutation matrix
for collumn=1:n
    for row=1:m
        loc=find(posU(:,collumn)==max(U(:,collumn)));
        if loc~=row
            pivot=U(loc,:);
            U(loc,:)=U(row,:);
            U(row,:)=pivot;
            pivot=posU(loc,:);
            posU(loc,:)=posU(row,:);
            posU(row,:)=pivot;
            pivot=P(loc,:);
            P(loc,:)=P(row,:);
            P(row,:)=pivot;
        end
        frac=U(row+1,collumn)/U(row,collumn);
        L(row+1,collumn)=frac;
        U(row+1,collumn)=U(row,collumn)*frac-U(row+1,collumn);
    end
end
if A*P==L*U
    disp(L);
    disp(U);
    disp(P);
else
    error('incorrect matrix input');
end
end