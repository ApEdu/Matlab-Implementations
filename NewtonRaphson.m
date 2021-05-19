%% Newton Raphson

clc
clear;
close all;

syms x
str = input('Give an equation in x: ','s');
f(x) = str2sym(str);
fprime(x) = diff(f);
m = input('multiplicity: ');
x0 = input('initial guess: ') ;
% absolute error convergence tolerance
TOL = input("type tolerance"); 
% maximum number of iterations to be performed
Nmax = 5000; 

flag=0;
for i = 1 : Nmax
    fold=vpa(subs(f,x,x0));
    fprimeold=vpa(subs(fprime,x,x0));
    dx = m*(fold / fprimeold);
    x0 = x0 - dx;
    fprintf ( '\t\t %3d \t %.10f \n', i, x0 );

    if ( abs(dx) < TOL ) 
       flag=1;
       break
    end
end

if flag == 0
    disp('Maximum number of iterations exceeded.')
end

fprintf('\n The approximate fixed point is %f', x0)