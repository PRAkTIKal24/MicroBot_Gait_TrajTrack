%%%Lie bracket Values%%%
function [C,mat1] = LieBracket_Pr(B)                         
                        
% B(1,1)=a1 value
% B(2,1)=a2 value
% B(3,1)=x value
% B(4,1)=y value
% B(5,1)=t value

syms ux uy ut vx vy vt a1 a2 x y t a1_dot a2_dot ;
 
% %Obtaining the Connection Form values as per Hatton's paper
[ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a1, a2);

g1=[ux;uy;ut];
g2=[vx;vy;vt];

AaA=[g1 g2];


G1=[1;0;g1];
G2=[0;1;g2];

g3=[a1 a2 x y t];

[lie1] = lie(G1,G2,g3);
[lie2] = lie(G1,lie1,g3);
[lie3] = lie(G2,lie1,g3);

mat = [G1 G2 lie1 lie2 lie3];

mat1 = double(subs(mat,[a1,a2],[B(1) B(2)])); 

C=double(mat1\B);

% a1=-2:0.1:2;
% a2=-2:0.1:2;
g1 = double(subs(g1,[a1 a2],[B(1) B(2)]));
g2 = double(subs(g2,[a1 a2],[B(1) B(2)]));

surf(curl(AaA))

end





