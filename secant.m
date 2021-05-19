%% SECANT METHOD

clear all;
close all; 

% Target expression with independent variable x
f = @(x) exp(x) - x^2 +3*x -2;

% x0,x1   initial approximation for the interval containing root
x0=0;
x1=1; 

%  Absolute error convergence tolerance
TOL=10^(-6);

%  Maximum number of iterations to be performed
Nmax=10;

flag=0;
older = x0;   old = x1;
folder = f(older);

for i = 2 : Nmax
    fold = f(old);
	dx = fold * ( old - older ) / ( fold - folder );
    new = old - dx;
	fprintf('\t\t %3d \t %.15f \n', i, new )
	
	if ( abs(dx) < TOL ) 
	   flag=1;
       break
	else
	   older = old;
	   old = new;
	   folder = fold;
	end
	
end

if flag == 0 
    disp('Maximum number of iterations exceeded') 
end