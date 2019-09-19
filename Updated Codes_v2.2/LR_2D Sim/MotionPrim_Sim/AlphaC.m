% %Function to calculate and plot the swimmer parameters and simulate the 
% % motion acoording to the flow terms driven by alpha     

function [a1a,Displacements_Current] = AlphaC(alpha,Disp)

%Scaling Parameters
L=0.08637;

%Pause
pp= 0.1;

%Interval size
i = 1;

%Initial Link Angles
a11=0;
a21=0;

%Initial Base Link CG Co-ordiantes in Inertial Frame
x0 = 0; 
y0 = 0;
theta0 = 0;
t0 = theta0;

%Initialization of Displacements to Identity Matrix to be premultiplied with Matrix Exponential in further iterations
Displacements_Prev = Disp;
Displacements_Current = eye(3);

%Maximum simulation time (s)
tmax = 0;

m=3;
t=0.1;
% n = 12;
n=10;
count=1;

%Call to Flow1 to get a1,a2,a1_dot,a2_dot values at each timestep 
[a1a] = Flow1(t,n,alpha);
 dt = sqrt(t)/n;


for t_Repeat=1:1:m
        
        for t1=1:1:9
            
            t1      
            a11= a1a(t1,1);
            a21= a1a(t1,2);
            thetai = theta0;
     
            [ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a11,a21);
      
            g1 = [ux ; uy; ut];
            g2=  [vx ; vy; vt];
            
            
      
            %Calculating Velocity matrices
            V = a1a(t1,3)*g1 + a1a(t1,4)*g2;

%             %Random Noise to simulate drift in the system
%             noise = awgn(V,20);
%             V = V + noise;
            
            V_LieAlForm = [0 -V(3)*dt V(1)*dt ; V(3)*dt 0 V(2)*dt ; 0 0 0 ];
            
            %Calculating Matrix Exponential and Current Displacements
            Displacements_Current = expm(V_LieAlForm)*Displacements_Prev
%             Displacements_Prev
            %Finding X, Y and theta
            theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
            x = Displacements_Current(1,3);
            y = Displacements_Current(2,3);

            %For plotting graphs of parameters wrt weight of the timestep
            X(count)=Displacements_Prev(1,3);
            Y(count)=Displacements_Prev(2,3);
            T(count)=radtodeg(atan2(Displacements_Prev(2,1),Displacements_Prev(1,1)));
            aa1(count)=radtodeg(a11);
            aa2(count)=radtodeg(a21);
            %Plotting of the graph of current position
            x=x+x0;
            y=y+y0;
            theta=theta+t0;

            subplot(2,2,1);
            plot([x-L/2*cos(theta) x+L/2*cos(theta)], [y-L/2*sin(theta) y+L/2*sin(theta)],'gs-')
            hold on
            plot([x-L/2*cos(theta) x-L/2*cos(theta)-2*L/2*cos(theta-a11)], [y-L/2*sin(theta) y-L/2*sin(theta)-2*L/2*sin(theta-a11)],'ro-')
            plot([x+L/2*cos(theta) x+L/2*cos(theta)+2*L/2*cos(theta+a21)], [y+L/2*sin(theta) y+L/2*sin(theta)+2*L/2*sin(theta+a21)],'ro-')
            title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates for Pure X motion')
            xlabel('X in m')
            ylabel('Y in m')
            margin=0.25;
            axis([x0-margin x0+margin y0-margin y0+margin])
            pause(pp)
            hold off
            grid on

            %Reassigning of present conditions as initial conditions for next iteration
            theta0 = theta;
            Displacements_Prev = Displacements_Current;
            
               subplot(2,2,2)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([0 10]);
               plot(164:164+(count-1),X,'r',164:164+(count-1),Y,'b');
               legend('X','Y')
               xlabel('Time Steps')
               ylabel('Translational parameters(cm)')

               subplot(2,2,3)
               grid on;
               hold on;
%                xlim([0 10*m]);
               plot(164:164+(count-1),aa1,'r',164:164+(count-1),aa2,'b');
               legend('alpha 1','alpha 2')
               xlabel('Time Steps')
               ylabel('alpha 1(deg),alpha 2(deg)')

               subplot(2,2,4)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([-5 5]);
               plot(164:164+(count-1),T,'g');
               xlabel('Time Steps')
               ylabel('Theta(deg)')

            
            pause(pp)
            count=count+1;
        end
       
    end
    

end   
