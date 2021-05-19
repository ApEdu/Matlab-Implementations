%% Bisection Method for finding zeros of a function

%% Function definition
f=@(x) 2*sin(x) - exp(x)/4 -1;
a=-5;  b=-3;

%% Stopping criterion
TOL = 10^(-6);
Nmax = floor ( log((b-a)/TOL) / log(2) ) + 1
pvalues=zeros(Nmax,1);

%% Main loop
for i = 1 : Nmax
    p = (a+b)/2;
	pvalues(i)=p;
    sfa = f(a);
    sfp = sign(f(p));
    fprintf( '\t\t %3d \t (%.6f,%.6f) \t %.10f \n', i, a, b, p)
	if ( (b-a)<2*TOL || sfp == 0 ) 
	   break
	elseif ( sfa * sfp < 0 )
	   b = p;
	else
	   a = p;
	   sfa = sfp;
    end
end

%% Absolute Error computation
plast =p;
errors=pvalues-plast*ones(Nmax,1);
fprintf('Approximate value |  Absolute Error\n\n')
fprintf(' %.10f     |  %.10f\n',[pvalues errors]');
