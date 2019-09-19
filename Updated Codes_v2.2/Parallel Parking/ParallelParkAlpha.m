% Parallel Parking
% OBJECTIVE : 1) To simulate a single axle 'car'.

%input arguments 1) the forward velocty u1
%                2) rotational speed u2

% notations used-
% x1= absolute x-coordinate of the centre of the axle
% x2= absolute y-coordinate of the centre of the axle
% x3= angular orientation of body link w.r.t to horizontal

%initial conditions
x1=0;
x2=0;
x3=pi/2;

i=0.1;
tmax=10;
figure;
prev_disp=eye(3);

for p=0:1:5 %Increasing the number of iterations makes translation along Y during steering more visible.

    for t=0.3:i:tmax %Time step increased to correct the residual angle 

%t
%%[u1,u2]=gait(t);

%----------------------------------------------------------------------
tc=ceil(t);

     if(tc<=1)
        u1=10; 
        u2=0;
     elseif(tc==2)
        u1=0; 
        u2=pi/9;
     elseif(tc==3)
        u1=-10;
        u2=0;
     elseif(tc==4)
        u1=0;
        u2=-pi/9;
end

%tc

%----------------------------------------------------------------------------
fx1= [sin(x3);cos(x3);0];
fx2= [0;0;1];
%u1
%u2
x1_dot= fx1(1,1)*u1 + fx2(1,1)*u2;
x2_dot= fx1(2,1)*u1 + fx2(2,1)*u2;
x3_dot= fx1(3,1)*u1 + fx2(3,1)*u2;

velocities= [x1_dot;x2_dot;x3_dot];
%velocities
velocities_lieAlgebraForm=[0 velocities(3,1) velocities(1,1); -velocities(3,1) 0 velocities(2,1); 0 0 0];
%velocities_lieAlgebraForm
matrix_exp=expm(i.*velocities_lieAlgebraForm);

if(tc<=1||tc==3)
    current_disp=matrix_exp*prev_disp;
elseif(tc==2||tc==4)
    trans_disp=prev_disp-[0,0,prev_disp(1,3);0,0,prev_disp(2,3);0,0,0];
    rot_disp=matrix_exp*trans_disp;
    current_disp=rot_disp+[0,0,prev_disp(1,3);0,0,prev_disp(2,3);0,0,0];
end 

%matrix_exp
x=current_disp(1,3);
y=current_disp(2,3);
theta=atan2(current_disp(2,1),current_disp(1,1));
current_disp
x1=x;
x2=y;
x3=theta;
%=======================================================================

cla;
%xlim([-500 500]);
%ylim([-5 5])
axis([-100 100 -100 100])
theta1=pi-theta;
plot([x1,x1+25*cos(theta1)],[x2, x2+25*sin(theta1)]);
hold on;
plot([x1,x1-25*cos(theta1)],[x2, x2-25*sin(theta1)]);
hold on;
plot([x1+25*cos(theta1)+12.2*cos(pi/2+theta1),x1+25*cos(theta1)-12.2*cos(pi/2+theta1)],[x2+25*sin(theta1)+12.5*sin(pi/2+theta1), x2+25*sin(theta1)-12.5*sin(pi/2+theta1)]);
hold on;
plot([x1-25*cos(theta1)+12.2*cos(pi/2+theta1),x1-25*cos(theta1)-12.2*cos(pi/2+theta1)],[x2-25*sin(theta1)+12.5*sin(pi/2+theta1), x2-25*sin(theta1)-12.5*sin(pi/2+theta1)]);

grid on;
hold on;
pause(0.1);

prev_disp=current_disp;

end
x3=0;
end




x1
x2
x3
%plot([0,x1],[0,x2]);
