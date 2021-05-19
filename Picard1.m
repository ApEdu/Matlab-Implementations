%%% Picards Iteration method for System of Equations

clear all;

%% Problem Initialization
n = input('Number of equations');
F = cell(1,n);
Y0 = zeros(1,n);
t0 = input('Enter t0 (initial value of independent variable):');
for i=1:n  
    % Enter variables as t,(x(1)),(x(2)),(x(3))...
    % Parenthesis are important for the program functioning
    % (x(i)) correspond to ith dependent variable
    % t corresponds to independent variable
    F{1,i} = input('Enter '+string(i)+' Function','s');
    Y0(i) = input('Enter Function '+string(i)+' initial value :');
end
iter = input('Number of iterations to be performed : '); 

disp('Functions :- ');
F
disp('Initial Values of the solution :-');
Y0

% Finding Integrand for first Iteration
F1 = string(F);
for i=1:n
    xstr = 'x('+string(i)+')';
    for j=1:n
        F1(j) = strrep(F1(j),xstr,string(Y0(i)));
    end
end



%% Performing Iterations
% solution string array
F2 = string(F);
for i=1:iter
    % loop for each iteration
    for j=1:n
        % loop for each solution
        syms f(t) t;
        f(t) = str2sym(F1(j));
        F2(j) =  string(Y0(j)+int(f(t),t,t0,t));
    end
    % loop for replacing integrand for next iteration
    F1 = string(F);
    for k=1:n
        xstr = 'x('+string(k)+')';
        for j=1:n
            F1(j) = strrep(F1(j),xstr,F2(k));
        end
    end
end
%% Displaying expressions for obtained picard solution
for i = 1:n
    fprintf('%d Solution obtained from Picard method: ',i);
    F2(i)
end

%% Using ODE Solver
Fexpr = "[";
for i = 1:n
    if i < n
        Fexpr = Fexpr + string(F(i)) + ";";
    else
        Fexpr = Fexpr + string(F(i));
    end
end
Fexpr = Fexpr + "]";
% This wont work if the input is not in the 
% defined format i.e. (x(1)),(x(2)),...
fn = str2func(['@(t,x) '+ string(Fexpr)]); 
[tnum,x] = ode45(fn,[t0 t0+1],Y0);

%% Plotting for comparision
for i=1:n
    figure(i);
    syms f(t) t;
    % Picard Solution
    f(t) = str2sym(F2(i));
    fplot(f,[t0 t0+1]);
    hold on;
    % ODE solution
    plot(tnum,x(:,i));
    xlabel('t');
    ylabel('function values');
    title('Solution '+string(i)+' Comparision');
    legend('Picard Solution '+string(i),'ODE45 Solution '+string(i));
    hold off;
end
