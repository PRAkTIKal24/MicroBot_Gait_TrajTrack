%% Function Name : Parametrization
% 
% Pupropse: To specify the parametrized variation of the link angles a1 and a2
%           
% Input Arguments: The parametrized time variable t (s)
%                            
% Output Arguments: The parametrized values of link angles a1 and a2 measured CCW (rad)
%                   The parametrized values of link angles a1_dot and a2_dot measured CCW (rad/s)
%%

function [a1,a2,a1_dot,a2_dot] = Parametrization(t)

%For a circular/elliptical gait in shape space
a = 0.6;  %Semimajor axis length
b = 1;  %Semiminor axis length
p = 0;  %X co-ordinate of Centre
q = 0;  %Y co-ordinate of Centre

a1 = p + a*cos(t);
a2 = q + b*sin(t);
a1_dot = -a*sin(t);
a2_dot = b*cos(t);

% a1 = p + a*cos(t+45*pi/180);
% a2 = q + b*sin(t);
% a1_dot = -a*sin(a*cos(t+45*pi/180));
% a2_dot = b*cos(t);

% a1 = t;
% a2 = t;
% a1_dot = 1;
% a2_dot = 1;

end