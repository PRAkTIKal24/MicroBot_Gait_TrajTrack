%%Implementation of closed loop control for the purcell's swimmer

Current_Disp=[0;0;0];
Deviated_Disp=[0;0;0];
Required_Disp=[0;0;0];

a11=0;
a21=0;


%----------------------------------------
Desired_Disp(1,1)=a11;
Desired_Disp(2,1)=a21;
Desired_Disp(3,1)=input('Enter x value');
Desired_Disp(4,1)=input('Enter y value');
Desired_Disp(5,1)=input('Enter t value');

Required_Disp = Desired_Disp(3:5,1);
=Required_Disp;

checkpoints = 10;
m=checkpoints;

for i=1:1:m
    Deviated_Disp=Required_Disp-Current_Disp;
    if(Deviated_Disp==0)
        [a1a,a1b,a2b,a3b,a1c,a2c,a3c,Current_Disp] = MotionPrimitives([0;0;Required_Disp]);
    end
    %----------------------------------------
    if(Deviated_Disp~=0)
        %The trajectory correction to the next check point is performed
        [a1a,a1b,a2b,a3b,a1c,a2c,a3c,Current_Disp] = MotionPrimitives([0;0;Deviated_Disp]);
    end
end
