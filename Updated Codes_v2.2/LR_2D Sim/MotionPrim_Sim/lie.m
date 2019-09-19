%Lie bracket calculation

function [Lie] = lie(a,b,c)
syms a1 a2 x y t;

J_g1 = jacobian(a,c);
J_g2 = jacobian(b,c);

Lie= J_g2*a - J_g1*b;

end

