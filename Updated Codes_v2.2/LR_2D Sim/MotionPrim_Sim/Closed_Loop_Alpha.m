%Closed Loop-Straight Line

reqd_disp=[0;0;0];
deviated_disp=[0;0;0];
current_disp=[0;0;0];

alpha = 0.8999;
beta = 0.8871;
gamma = 0.8871;

a11=0;
a21=0;

m=5;

%----------------------------------------

Desired_Disp(1,1)=a11;
Desired_Disp(2,1)=a21;
Desired_Disp(3,1)=input('Enter x value');
Desired_Disp(4,1)=0;
Desired_Disp(5,1)=0;

Disp=eye(3);

for q=1:1:m
    
    [a1a,Displacements_Current] = Alpha(alpha,Disp);
    theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
    theta = radtodeg(theta);
    x = Displacements_Current(1,3);
    y = Displacements_Current(2,3);
    Disp = Displacements_Current;
    
    if(abs(5-abs(theta))<0.5)

        [a1c,a2c,a3c,Displacements_Current] = MinusGamma(gamma,Disp)
        Disp = Displacements_Current;
        
%         [a1a,Displacements_Current] = AlphaC(alpha,Disp);
%         Disp = Displacements_Current;
        
        [a1b,a2b,a3b,Displacements_Current] = Beta(beta,Disp);
        Disp = Displacements_Current;
        
        theta = atan2(Displacements_Current(2,1),Displacements_Current(1,1));
        theta = radtodeg(theta);
        x = Displacements_Current(1,3);
        y = Displacements_Current(2,3);
    end    
end        



