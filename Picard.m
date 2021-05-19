%% ODE MATLAB ASSIGNMENT
%
% *Name: Shubhankar Kate*
%
% *ID : 2018B4A70786G*
%
%% 
%Clears screen and any pre-existing variables in use
close all;
clear all;
clc;

%% _Taking input from user_

% str_f = input('Enter the function f(t,y) = ', 's');
% y0 = input('Enter y0 = ');
% t0 = input('Enter t0 = ');
% it = input('Enter number of iterations (Symbolic) = ');
% it1 = input('Enter number of iterations (Numeric) = ');
% accuracy = input('Enter number of digits of accuracy (Enter in the form 10^(-a)) = ');
% fn1 = str2func(['@(t,y) ',str_f]); % Numerical form of the function
% syms t y;
% fn(t,y) = str2sym(str_f); % Symbolic form of the function

%% _Assigning predetermined values (Comment this while running input )_
syms t y;
fn(t,y) = t + t*y;
fn1 = @(t,y) t + t*y;
y0 = 1;
t0 = 0;
it = 5;
it1 = 10;
accuracy = 10^(-6);

%% _Picard's method_
y1 = y0;
hold on;
for i = 0: it-1
    y2(t) = y0 + int( fn(t,y1) ,t0 ,t ); 
    fprintf('Itr no. : %d\n',i);
    fprintf('Fn(t) : ');
    y2(t)
    y1 = y2;

    %%ploting graph for each solution
    xrange = [t0-1 : 0.1 : t0+3];
    yrange = subs( y2 ,t ,xrange );
    plot( xrange ,yrange )
    title('Combined plot of plots at each iteration : ');
    xlabel('T');
    ylabel('Y');
end
hold off;

%% _Solution using ode45 solver_
[t,y] = ode45(fn1, [t0:t0+1], y0);
plot(t,y,'-*');
title('Solution obtained from ode45');
xlabel('T');
ylabel('Y');
snapnow

%% _Numerical method of comparison_

hold on
% Here we break interval of [0,1] into 20 equal parts using linspace.
% Then we plot all these values using Picard's iterations along with the 
% graph plotted in ode45.
l = linspace(0,1,10);

for i = 1:9
    y_p=y0;
    flag=0;
    f_p=0;
    
    %Loop to calculate all Picard iteration values for specific t
    syms t;
    for j = 0 : it1
        
        ynew = y0 + int( fn1(t,y_p) ,t ,t0 ,t );
        f_n = vpa( subs( ynew ,t ,l(i) ) );
        
        %Breaking criteria
        if( abs( f_n - f_p ) < accuracy)
            tp=1;
            break
        end
        y_p = ynew;
        f_p=f_n;
    end
    fprintf('\nValue obtained from Picard iteration at the point (t = %.6f) = %0.10f\n', l(i), vpa( subs( ynew ,t ,l(i) ) ));
    %Plotting the values
    plot( l(i) ,f_n ,'*');
    title('Plots of different points iteration')
    xlabel('T');
    ylabel('Y');
    fprintf('\n');
end
hold off