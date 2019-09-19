% Script: AreaIntegralLowRe_Code
% Purpose: To find the holonomy of purcell swimmer through the area integral 
%          of corresponding Constraint Curvature Functions (CCFs)
%          Observe the form of integral as:
%
%               I = ??CCF d(a1) d(a2)
% 
% Note: Please go through Comments in the code for further detailed information.
%%

L = 0.035;     %Length in m
n = 0.95;     %Dynamic Viscosity in PaS

% k = 2 * pi * n ./ log(s); %Value of the slender body constant k where s is the slender body ratio
k = 2 * pi * n ./ log(49); 

%Initialization of Area Integral Values to zero
AI = zeros(3,1);

%Interval size
i = 0.1;
thetai = 0;

%Gait parameters in shape space for ellipse/circle
a = 2;  %Semimajor axis length
b = 2;  %Semiminor axis length
p = 0;  %X co-ordinate of Centre
q = 0;  %Y co-ordinate of Centre

%Lower limits of integral w.r.t a2
a2ll = q - b;
a2ul = q + b;

for a2 = a2ll:i:a2ul
    for a1 =  p - a*sqrt(b^2 - (a2 - q)^2)/b:i: p + a*sqrt(b^2 - (a2 - q)^2)/b
        
        %Obtaining CCFs
        [Zx, Zy, Zt] = ConstraintCurvatureFunction_LowRe(a1,a2,L,k);
        
        %Calculating Corresponding Line Integrals
        AI(1,1) = AI(1,1) + Zx*i*i;
        AI(2,1) = AI(2,1) + Zy*i*i;
        AI(3,1) = AI(3,1) + Zt*i*i;

    end
end


%Printing Final Area Integral Values
fprintf('Value of X calculated through line integral, Ix = %f\n\n',AI(1,1))
fprintf('Value of Y calculated through line integral, Iy = %f\n\n',AI(2,1))
fprintf('Value of theta calculated through line integral, It = %f\n\n',AI(3,1))


