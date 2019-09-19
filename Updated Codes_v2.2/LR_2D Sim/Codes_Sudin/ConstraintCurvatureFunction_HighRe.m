%% Function Name : ConstraintCurvatureFunction_HighRe
% 
% Pupropse: To evaluate the Constraint Curvature Function (CCF/HeightFunction) for High Reynold's Number Flow 
% 
% Input Arguments: a1 = Angle between the 1st Link and Base Link measured CCW(rad)
%                  a2 = Angle between the 3rd Link and Base Link measured CCW(rad)
%                  L = Link Length (m)
%                  k = The slender body constant
%                            
% Output Arguments : Zx = Constraint Curvature Function Value for X
%                    Zy = Constraint Curvature Function Value for Y
%                    Zt = Constraint Curvature Function Value for Theta
%%

function [Zx, Zy, Zt] = ConstraintCurvatureFunction_HighRe(a1,a2,L,J,m)

J = 1;
m = 1;

[ux, uy , ut, vx, vy, vt] = ConnectionForm_HighRE(a1, a2, L, J,m);

cx = -(L*cos(a2)*(m*L^2 + J))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2)) + (L*cos(a1)*(m*(cos(a2) + 1)*L^2 + J))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2)) + (L*(sin(a1) + sin(a2))*(m*L^2 + J)*(6*L^2*m*sin(a2) + 2*L^2*m*cos(a2)*sin(a1) + 2*L^2*m*cos(a2)*sin(a2)))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2))^2 + (L*(sin(a1) + sin(a2))*(m*(cos(a2) + 1)*L^2 + J)*(6*L^2*m*sin(a1) + 2*L^2*m*cos(a1)*sin(a1) + 2*L^2*m*cos(a1)*sin(a2)))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2))^2 + (4*L^3*m^2*sin(a1)*sin(a2))/(9*J*m + 12*L^2*m^2 - L^2*m^2*sin(a1)^2 - L^2*m^2*sin(a2)^2 + 6*L^2*m^2*cos(a1) + 6*L^2*m^2*cos(a2) - 2*L^2*m^2*sin(a1)*sin(a2)) - (L*m*sin(a2)*(6*L^2*m^2*sin(a1) + 2*L^2*m^2*cos(a1)*sin(a1) + 2*L^2*m^2*cos(a1)*sin(a2))*(3*J + 4*L^2*m + 2*L^2*m*cos(a1) + 2*L^2*m*cos(a2)))/(9*J*m + 12*L^2*m^2 - L^2*m^2*sin(a1)^2 - L^2*m^2*sin(a2)^2 + 6*L^2*m^2*cos(a1) + 6*L^2*m^2*cos(a2) - 2*L^2*m^2*sin(a1)*sin(a2))^2 - (L*m*sin(a1)*(6*L^2*m^2*sin(a2) + 2*L^2*m^2*cos(a2)*sin(a1) + 2*L^2*m^2*cos(a2)*sin(a2))*(3*J + 4*L^2*m + 2*L^2*m*cos(a1) + 2*L^2*m*cos(a2)))/(9*J*m + 12*L^2*m^2 - L^2*m^2*sin(a1)^2 - L^2*m^2*sin(a2)^2 + 6*L^2*m^2*cos(a1) + 6*L^2*m^2*cos(a2) - 2*L^2*m^2*sin(a1)*sin(a2))^2;
Zx = -cx + uy * vt - ut * vy;  
 
cy = 0;
Zy = -cy + ut * vx - vt * ux; 
 
ct = -(3*(m*L^2 + J)*(6*L^2*m*sin(a2) + 2*L^2*m*cos(a2)*sin(a1) + 2*L^2*m*cos(a2)*sin(a2)))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2))^2 + (3*(m*(cos(a2) + 1)*L^2 + J)*(6*L^2*m*sin(a1) + 2*L^2*m*cos(a1)*sin(a1) + 2*L^2*m*cos(a1)*sin(a2)))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2))^2 - (L^2*m*cos(a1)*sin(a2))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2)) - (L^2*m*cos(a2)*sin(a1))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2)) - (L^2*m*sin(a2)*(sin(a1) + sin(a2))*(6*L^2*m*sin(a1) + 2*L^2*m*cos(a1)*sin(a1) + 2*L^2*m*cos(a1)*sin(a2)))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2))^2 - (L^2*m*sin(a1)*(sin(a1) + sin(a2))*(6*L^2*m*sin(a2) + 2*L^2*m*cos(a2)*sin(a1) + 2*L^2*m*cos(a2)*sin(a2)))/(9*J + 12*L^2*m + 6*L^2*m*cos(a1) + 6*L^2*m*cos(a2) - L^2*m*sin(a1)^2 - L^2*m*sin(a2)^2 - 2*L^2*m*sin(a1)*sin(a2))^2;
Zt = -ct;

 end