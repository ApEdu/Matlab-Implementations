clc ;
clear all;
format rat;
syms x;
syms y;
syms z;
% Taking input
A = input("Coefficient Matrix for System of Equations : ");
b = input("Vector Matrix : ");

[nRows, nColumns]=size(A);

% Display recieved system of Equations
vec=[x;y;z];
disp("System of Equations : ");
for i=1:nRows
    matrisys(i,1)=A(i,:)*vec;
end
for i=1:nRows
   matrisys(i,2)=b(i); 
end
disp(matrisys);

% Display Croult Factorization Obtained
[L,U] = croultFactorization(A);
disp("Matriz L: ");
disp(L);
disp("Matriz U: ");
disp(U);


n=length(b);
d=det(L);
vectorY=zeros(n,1);
for i=1:n
    Lb=[L(:,1:i-1),b,L(:,i+1:n)];
    vectorY(i)=det(Lb)/d;
end

disp("Vector Y: ");
disp(vectorY);
n=length(vectorY);
d=det(U);
vectorX=zeros(n,1);
for i=1:n
    Ux=[U(:,1:i-1),vectorY,U(:,i+1:n)];
    vectorX(i)=det(Ux)/d;
end

disp("Solution:")

fprintf("X=%s\n",strtrim(rats(vectorX(1))));
fprintf("Y=%s\n",strtrim(rats(vectorX(2))));
fprintf("Z=%s\n",strtrim(rats(vectorX(3))));