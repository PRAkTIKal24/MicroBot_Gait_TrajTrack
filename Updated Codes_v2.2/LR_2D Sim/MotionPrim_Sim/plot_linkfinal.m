% Function Name : plot_linkfinal
% 
% Pupropse: To plot the three link purcell swimmer at the end of simualtion.
% 
% Input Arguments: x = Present X co-ordinate of the Base Link CG in Inertial Frame (m)
%                  y = Present Y co-ordinate of the Base Link CG in Inertial Frame (m)
%                  theta = Angle of orientation of base link w.r.t inertal X axis measured CCW (rad)
%                  a1 = Angle between the 1st Link and Base Link measured CCW(rad)
%                  a2 = Angle between the 3rd Link and Base Link measured CCW(rad)
%                  L = Link Length (m)
%                  colour = Colour Code to specify the plot colour 
%                            1 : Red
%                            2 : Green
%                            
% Output Arguments : None


function  plot_linkfinal(x,y,theta,a1,a2,x0,y0,L,colour)

if(colour==1)
figure(1)
hold on
plot([x-L*cos(theta) x+L*cos(theta)], [y-L*sin(theta) y+L*sin(theta)],'bs-')
plot([x-L*cos(theta) x-L*cos(theta)-2*L*cos(theta-a1)], [y-L*sin(theta) y-L*sin(theta)-2*L*sin(theta-a1)],'bo-')
plot([x+L*cos(theta) x+L*cos(theta)+2*L*cos(theta+a2)], [y+L*sin(theta) y+L*sin(theta)+2*L*sin(theta+a2)],'bo-')
title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates')
xlabel('X in m')
ylabel('Y in m')
h = legend('Final Position');
%axis([-.1 0.3 -0.1 0.4])
pause(0.1)


else
figure(1)
hold on
plot([x-L*cos(theta) x+L*cos(theta)], [y-L*sin(theta) y+L*sin(theta)],'gs-')
plot([x-L*cos(theta) x-L*cos(theta)-2*L*cos(theta-a1)], [y-L*sin(theta) y-L*sin(theta)-2*L*sin(theta-a1)],'ro-')
plot([x+L*cos(theta) x+L*cos(theta)+2*L*cos(theta+a2)], [y+L*sin(theta) y+L*sin(theta)+2*L*sin(theta+a2)],'ro-')
title('Simulation of 3 Link Purcell Swimmer in Global Co-ordinates')
xlabel('X in m')
ylabel('Y in m')
axis([x0-.2 x0+0.2 y0-0.2 y0+0.2])
pause(0.1)
end

end