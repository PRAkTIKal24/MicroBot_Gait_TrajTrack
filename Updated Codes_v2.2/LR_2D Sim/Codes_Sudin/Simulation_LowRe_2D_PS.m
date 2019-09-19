%% Script: SimulationandLineIntegral_LowRe
% Purpose: 1. To simulate the 3 link Purcell Swimmer Mehcanism
%          2. To Plot variations of X, Y and Theta with respect to time calculated through exponential map.        
%%

Init_Graphics_Style

%Initial Declarations
L = 0.035;      %Length in m
n = 0.95;       %Dynamic Viscosity in PaS

% k = 2 * pi * n ./ log(s); %Value of the slender body constant k where s is the slender body ratio
k = 2 * pi * n ./ log(49); 

%Interval size
i = 0.1;

%Initial Link Angles
a10 = 0;
a20 = 0;

%Initial Base Link CG Co-ordiantes in Inertial Frame
x0 = 0; 
y0 = 0;
theta0 = 0;
t0 = theta0;

%Initialization of Displacements to Identity Matrix to be premultiplied with Matrix Exponential in further iterations
Displacements_Prev = eye(3);

%Maximum simulation time (s)
%Set 2*pi for a gait which is a closed loop in shape space
tmax = 30;

%Initialization of Line integral variables to zero
lib = zeros(3,1);

% To plot the initial configuration of the link
%plot_link(x0,y0,theta0,a10,a20,x0,y0,L,1)

for t = 0:i:tmax
    t
 
%To obtain the parametrization of a1, a2, a1_dot, a2_dot
if(1)
[a1,a2,a1_dot,a2_dot] = Parametrization(t);
else
[q,w,e,r] = Parametrization(tmax - t);     
a1 = -q;
a2 = -w;
a1_dot = -e;
a2_dot = -r;
% [a1,a2,a1_dot,a2_dot] = Parametrization(tmax - t);
end

% %Obtaining the Connection Form values
[ux, uy , ut, vx, vy, vt] = ConnectionForm_LowRE(a1, a2, L,k);

%Calculating body velocities
  xb_dot   =  ux * a1_dot + vx * a2_dot;
  yb_dot   =  uy * a1_dot + vy * a2_dot;
thetab_dot =  ut * a1_dot + vt * a2_dot;

Velocities_BodyFrame = [xb_dot;yb_dot;thetab_dot];

% Transformation to Inertial Frame
thetai = theta0;
Velocities_InertialFrame = [cos(thetai) -sin(thetai) 0;sin(thetai) cos(thetai) 0;0 0 1]*Velocities_BodyFrame;

Velocities_LieAlgebraForm = [0 -Velocities_InertialFrame(3,1) Velocities_InertialFrame(1,1);...
                             Velocities_InertialFrame(3,1) 0  Velocities_InertialFrame(2,1);...
                             0 0 0];

%Calculating Matrix Exponential and Current Displacements
Matrix_Exp = expm(i .* Velocities_LieAlgebraForm);

Displacements_Current = Matrix_Exp * Displacements_Prev;

%Finding X, Y and theta
theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
x = Displacements_Current(1,3);
y = Displacements_Current(2,3);

%Plotting of the graph of current position
x=x+x0;
y=y+y0;
theta=theta+t0;

% figure(1)
plot([x-L*cos(theta) x+L*cos(theta)], [y-L*sin(theta) y+L*sin(theta)],'gs-')
hold on
plot([x-L*cos(theta) x-L*cos(theta)-2*L*cos(theta-a1)], [y-L*sin(theta) y-L*sin(theta)-2*L*sin(theta-a1)],'ro-')
plot([x+L*cos(theta) x+L*cos(theta)+2*L*cos(theta+a2)], [y+L*sin(theta) y+L*sin(theta)+2*L*sin(theta+a2)],'ro-')
title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates')
xlabel('X in m')
ylabel('Y in m')
margin=0.24;
axis([x0-margin x0+margin y0-margin y0+margin])
pause(0.01)
grid on
hold off
% cla

%To plot Variation of X, Y and Theta in Inerial Frame with Time 
% plot_parameter(t,'Parametrization Time t in s',lib(1,1),'X in m',lib(2,1),'Y in m',lib(3,1),'\theta in rad','Center Link Displacement and Orientation Plots with Time (LRe)');

%Reassigning of present conditions as initial conditions for next
%iteration
theta0 = theta;
Displacements_Prev = Displacements_Current;
pause(0.001)
end
