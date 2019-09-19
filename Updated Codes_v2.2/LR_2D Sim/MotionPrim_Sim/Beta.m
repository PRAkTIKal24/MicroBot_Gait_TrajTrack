% %Function to calculate and plot the swimmer parameters and simulate the 
% % motion acoording to the flow terms driven by beta    


function [a1b,a2b,a3b,Displacements_Current] = Beta(beta,Disp)

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

m=1;
t=0.1;
n = 1;
count=1;


for t2=1:i:m
        [a1b,a2b,a3b] = Flow2(t,n,beta); 
       
        for t1=1:1:5    
           
            if (t1<=2)   
                dt = sqrt(t)/n;
                a11= a1b(t1,1);
                a21= a1b(t1,2);
                thetai = theta0;                            
           
                [ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a11,a21);

                g1 = [ux ; uy; ut];
                g2=  [vx ; vy; vt];

                V_InertialFrame = a1b(t1,3)*g1 + a1b(t1,4)*g2;
               
%                 %Random Noise to simulate drift in the system
%                    noise = awgn(V_InertialFrame,20);
%                    V_InertialFrame = V_InertialFrame + noise;
           
%                 V_InertialFrame = [cos(thetai) -sin(thetai) 0;sin(thetai) cos(thetai) 0;0 0 1]*V;

                V_LieAlForm = [0 -V_InertialFrame(3)*dt V_InertialFrame(1)*dt ; V_InertialFrame(3)*dt 0 V_InertialFrame(2)*dt ; 0 0 0 ];
            %Calculating Matrix Exponential and Current Displacements

            Displacements_Current = expm(V_LieAlForm)*Displacements_Prev
            %Finding X, Y and theta
            theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
            x = Displacements_Current(1,3);
            y = Displacements_Current(2,3);
            
            %To plot the required parameters wrt the weight of the time step
            
            X(count)=x;
            Y(count)=y;
            T(count)=radtodeg(theta); 
            aa1(count)=radtodeg(a11);
            aa2(count)=radtodeg(a21);

            %Plotting of the graph of current position
            x=x+x0;
            y=y+y0;
            theta=theta+t0;
            
            subplot(2,2,1)
            plot([x-L/2*cos(theta) x+L/2*cos(theta)], [y-L/2*sin(theta) y+L/2*sin(theta)],'gs-')
            hold on
            plot([x-L/2*cos(theta) x-L/2*cos(theta)-2*L/2*cos(theta-a11)], [y-L/2*sin(theta) y-L/2*sin(theta)-2*L/2*sin(theta-a11)],'ro-')
            plot([x+L/2*cos(theta) x+L/2*cos(theta)+2*L/2*cos(theta+a21)], [y+L/2*sin(theta) y+L/2*sin(theta)+2*L/2*sin(theta+a21)],'ro-')
            title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates for Pure Y motion')
            xlabel('X in m')
            ylabel('Y in m')
            margin=0.25;
            axis([x0-margin x0+margin y0-margin y0+margin])
            pause(pp)
            hold off
            grid on
            
            %Parameter Plots
               subplot(2,2,2)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([0 10]);
               plot(82:82+(count-1),X,'r',82:82+(count-1),Y,'b');
               legend('X','Y')
               xlabel('Time Steps')
               ylabel('Translational parameters(cm)')

               subplot(2,2,3)
               grid on;
               hold on;
%                xlim([0 10*m]);
               plot(82:82+(count-1),aa1,'r',82:82+(count-1),aa2,'b');
               legend('alpha 1','alpha 2')
               xlabel('Time Steps')
               ylabel('alpha 1(deg),alpha 2(deg)')

               subplot(2,2,4)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([-10 10]);
               plot(82:82+(count-1),T,'g');
               xlabel('Time Steps')
               ylabel('Theta(deg)')

            %Reassigning of present conditions as initial conditions for next iteration           
            theta0 = theta;
            Displacements_Prev = Displacements_Current;

            pause(pp)
%_______________________________________________________________     
    elseif (t1==3)
     for t4=1:i:n

        dt = sqrt(sqrt(t))/n;

        for t3=1:1:4
              a11= a2b(t3+1,1);
              a21= a2b(t3+1,2);
              thetai = theta0;
              
              [ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a11,a21);

              g1 = [ux ; uy; ut];
              g2=  [vx ; vy; vt];

              V_InertialFrame = a2b(t1,3)*g1 + a2b(t1,4)*g2;
              
%               
%                  %Random Noise to simulate drift in the system
%                    noise = awgn(V_InertialFrame,20);
%                    V_InertialFrame = V_InertialFrame + noise;
                         
%               V_InertialFrame = [cos(thetai) -sin(thetai) 0;sin(thetai) cos(thetai) 0;0 0 1]*V;

              V_LieAlForm = [0 -V_InertialFrame(3)*dt V_InertialFrame(1)*dt ; V_InertialFrame(3)*dt 0 V_InertialFrame(2)*dt ; 0 0 0 ];

            %Calculating Matrix Exponential and Current Displacements
            Displacements_Current = expm(V_LieAlForm)*Displacements_Prev

            %Finding X, Y and theta
            theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
            x = Displacements_Current(1,3);
            y = Displacements_Current(2,3);
            
            X(count)=x;
            Y(count)=y;
            T(count)=radtodeg(theta);
            aa1(count)=radtodeg(a11);
            aa2(count)=radtodeg(a21);

            %Plotting of the graph of current position
            x=x+x0;
            y=y+y0;
            theta=theta+t0;

            subplot(2,2,1)
            plot([x-L/2*cos(theta) x+L/2*cos(theta)], [y-L/2*sin(theta) y+L/2*sin(theta)],'gs-')
            hold on
            plot([x-L/2*cos(theta) x-L/2*cos(theta)-2*L/2*cos(theta-a11)], [y-L/2*sin(theta) y-L/2*sin(theta)-2*L/2*sin(theta-a11)],'ro-')
            plot([x+L/2*cos(theta) x+L/2*cos(theta)+2*L/2*cos(theta+a21)], [y+L/2*sin(theta) y+L/2*sin(theta)+2*L/2*sin(theta+a21)],'ro-')
            title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates')
            xlabel('X in m')
            ylabel('Y in m')
            margin=0.25;
            axis([x0-margin x0+margin y0-margin y0+margin])
            pause(pp)
            hold off
            grid on
            
               subplot(2,2,2)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([0 10]);
               plot(82:82+(count-1),X,'r',82:82+(count-1),Y,'b');
               legend('X','Y')
               xlabel('Time Steps')
               ylabel('Translational parameters(cm)')

               subplot(2,2,3)
               grid on;
               hold on;
%                xlim([0 10*m]);
               plot(82:82+(count-1),aa1,'r',82:82+(count-1),aa2,'b');
               legend('alpha 1','alpha 2')
               xlabel('Time Steps')
               ylabel('alpha 1(deg),alpha 2(deg)')

               subplot(2,2,4)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([-10 10]);
               plot(82:82+(count-1),T,'g');
               xlabel('Time Steps')
               ylabel('Theta(deg)')

%Reassigning of present conditions as initial conditions for next iteration
            theta0 = theta;
            Displacements_Prev = Displacements_Current;

            pause(pp)
            count=count+1;
        end
        
    end
%____________________________________________________________
    elseif (t1==4)
                dt = sqrt(t)/n;
                a11= a1b(t1,1);
                a21= a1b(t1,2);
                thetai = theta0;                            
           
                [ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a11,a21);

                g1 = [ux ; uy; ut];
                g2=  [vx ; vy; vt];

                V_InertialFrame = a1b(t1,3)*g1 + a1b(t1,4)*g2;
           
                
%                  %Random Noise to simulate drift in the system
%                    noise = awgn(V_InertialFrame,20);
%                    V_InertialFrame = V_InertialFrame + noise;
                           
%                 V_InertialFrame = [cos(thetai) -sin(thetai) 0;sin(thetai) cos(thetai) 0;0 0 1]*V;

                V_LieAlForm = [0 -V_InertialFrame(3)*dt V_InertialFrame(1)*dt ; V_InertialFrame(3)*dt 0 V_InertialFrame(2)*dt ; 0 0 0 ];
            %Calculating Matrix Exponential and Current Displacements

            Displacements_Current = expm(V_LieAlForm)*Displacements_Prev
            %Finding X, Y and theta
            theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
            x = Displacements_Current(1,3);
            y = Displacements_Current(2,3);
            
            %To plot the required parameters wrt the weight of the time step            
            X(count)=x;
            Y(count)=y;
            T(count)=radtodeg(theta);
            aa1(count)=radtodeg(a11);
            aa2(count)=radtodeg(a21);

            %Plotting of the graph of current position
            x=x+x0;
            y=y+y0;
            theta=theta+t0;
            
            subplot(2,2,1)
            plot([x-L/2*cos(theta) x+L/2*cos(theta)], [y-L/2*sin(theta) y+L/2*sin(theta)],'gs-')
            hold on
            plot([x-L/2*cos(theta) x-L/2*cos(theta)-2*L/2*cos(theta-a11)], [y-L/2*sin(theta) y-L/2*sin(theta)-2*L/2*sin(theta-a11)],'ro-')
            plot([x+L/2*cos(theta) x+L/2*cos(theta)+2*L/2*cos(theta+a21)], [y+L/2*sin(theta) y+L/2*sin(theta)+2*L/2*sin(theta+a21)],'ro-')
            title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates for Pure Y motion')
            xlabel('X in m')
            ylabel('Y in m')
            margin=0.25;
            axis([x0-margin x0+margin y0-margin y0+margin])
            pause(pp)
            hold off
            grid on
            
               subplot(2,2,2)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([0 10]);
               plot(82:82+(count-1),X,'r',82:82+(count-1),Y,'b');
               legend('X','Y')
               xlabel('Time Steps')
               ylabel('Translational parameters(cm)')

               subplot(2,2,3)
               grid on;
               hold on;
%                xlim([0 10*m]);
               plot(82:82+(count-1),aa1,'r',82:82+(count-1),aa2,'b');
               legend('alpha 1','alpha 2')
               xlabel('Time Steps')
               ylabel('alpha 1(deg),alpha 2(deg)')

               subplot(2,2,4)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([-10 10]);
               plot(82:82+(count-1),T,'g');
               xlabel('Time Steps')
               ylabel('Theta(deg)')

            %Reassigning of present conditions as initial conditions for next iteration           
            theta0 = theta;
            Displacements_Prev = Displacements_Current;

            pause(pp)
            
    elseif(t1==5)
        for t4=1:i:n

        dt = sqrt(sqrt(t))/n;

        for t3=1:1:4
              a11= a3b(t3+1,1);
              a21= a3b(t3+1,2);
              thetai = theta0;
              
              [ux, uy, ut, vx, vy, vt] = ConnectionForm_Hatton(a11,a21);

              g1 = [ux ; uy; ut];
              g2=  [vx ; vy; vt];

              V_InertialFrame = a3b(t1,3)*g1 + a3b(t1,4)*g2;

%               
%                  %Random Noise to simulate drift in the system
%                    noise = awgn(V_InertialFrame,20);
%                    V_InertialFrame = V_InertialFrame + noise;
                         
%               V_InertialFrame = [cos(thetai) -sin(thetai) 0;sin(thetai) cos(thetai) 0;0 0 1]*V;

              V_LieAlForm = [0 -V_InertialFrame(3)*dt V_InertialFrame(1)*dt ; V_InertialFrame(3)*dt 0 V_InertialFrame(2)*dt ; 0 0 0 ];
              
            %Calculating Matrix Exponential and Current Displacements
            Displacements_Current = expm(V_LieAlForm)*Displacements_Prev

            %Finding X, Y and theta
            theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
            x = Displacements_Current(1,3);
            y = Displacements_Current(2,3);
            
            X(count)=x;
            Y(count)=y;
            T(count)=radtodeg(theta);
            aa1(count)=radtodeg(a11);
            aa2(count)=radtodeg(a21);

            
            %Plotting of the graph of current position
            x=x+x0;
            y=y+y0;
            theta=theta+t0;

            subplot(2,2,1)
            plot([x-L/2*cos(theta) x+L/2*cos(theta)], [y-L/2*sin(theta) y+L/2*sin(theta)],'gs-')
            hold on
            plot([x-L/2*cos(theta) x-L/2*cos(theta)-2*L/2*cos(theta-a11)], [y-L/2*sin(theta) y-L/2*sin(theta)-2*L/2*sin(theta-a11)],'ro-')
            plot([x+L/2*cos(theta) x+L/2*cos(theta)+2*L/2*cos(theta+a21)], [y+L/2*sin(theta) y+L/2*sin(theta)+2*L/2*sin(theta+a21)],'ro-')
            title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates')
            xlabel('X in m')
            ylabel('Y in m')
            margin=0.25;
            axis([x0-margin x0+margin y0-margin y0+margin])
            pause(pp)
            hold off
            grid on
            
               subplot(2,2,2)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([0 10]);
               plot(82:82+(count-1),X,'r',82:82+(count-1),Y,'b');
               legend('X','Y')
               xlabel('Time Steps')
               ylabel('Translational parameters(cm)')

               subplot(2,2,3)
               grid on;
               hold on;
%                xlim([0 10*m]);
               plot(82:82+(count-1),aa1,'r',82:82+(count-1),aa2,'b');
               legend('alpha 1','alpha 2')
               xlabel('Time Steps')
               ylabel('alpha 1(deg),alpha 2(deg)')

               subplot(2,2,4)
               grid on;
               hold on;
%                xlim([0 10*m]);
%                ylim([-10 10]);
               plot(82:82+(count-1),T,'g');
               xlabel('Time Steps')
               ylabel('Theta(deg)')

%Reassigning of present conditions as initial conditions for next iteration
            theta0 = theta;
            Displacements_Prev = Displacements_Current;
            

            pause(pp)
            count=count+1;
        end        
      end
        
        
        
            end 

               if(t1<=2||t1==4)
               count=count+1;
               end
        end
end



end