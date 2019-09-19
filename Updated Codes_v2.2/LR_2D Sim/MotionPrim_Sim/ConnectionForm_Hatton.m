%%% Connection Form based on Hatton's paper %%%

function [ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a1,a2)

 syms ux uy ut vx vy vt;

%Constant value declaration
L=0.08637;

k1=0.0001013/L;             
k2=0.005922/L;

om1= [k1*L*cos(a1) -k1*L*sin(a1) k1*L*L*sin(a1) 0 0;
      k2*L*sin(a1) k2*L*cos(a1) -k2*L*L*(cos(a1)+1) k2*L*L 0;
      0 0 k2*L*1 -k2*L*1 0];

om2= [k1*L*1 0 0 0 0;
      0 k2*L*1 0 0 0;
      0 0 k2*L^3*1/3 0 0];

om3= [k1*L*cos(a2) k1*L*sin(a2) k1*L*L*sin(a2) 0 0;
      -k2*L*sin(a2) k2*L*cos(a2) k2*L*L*(cos(a2)+1) 0 k2*L*L;
      0 0 k2*L*1 0 k2*L*1];

om4= [cos(a1) sin(a1) 0;
      -sin(a1) cos(a1) 0;
      L*sin(a1) -L*(1+cos(a1)) 1];
  
om5= [cos(a2) -sin(a2) 0;
      sin(a2) cos(a2) 0;
      L*sin(a2) L*(1+cos(a2)) 1];
  
Om1= om4*om1;
Om2= om2;
Om3= om5*om3;  

omega= Om1+Om2+Om3;

U= inv([omega(:,1) omega(:,2) omega(:,3)])*[omega(:,4) omega(:,5)];

ux=U(1,1);
uy=U(2,1);
ut=U(3,1);
vx=U(1,2);
vy=U(2,2);
vt=U(3,2);

end




    
    