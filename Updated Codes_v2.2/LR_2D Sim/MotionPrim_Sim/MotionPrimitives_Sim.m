%%% Simulation of motion along the motion primitives


%Initialization of Displacements to Identity Matrix to be premultiplied with Matrix Exponential in further iterations
Displacements_Prev = eye(3);
Displacements_Current = eye(3);
Disp = eye(3);

%Initialization of link angles wrt center link
a11=0;
a21=0;

%Maximum simulation time (s)
tmax = 0;

%Input values
Desired_Disp(1,1)=a11;
Desired_Disp(2,1)=a21;
Desired_Disp(3,1)=input('Enter x value');
Desired_Disp(4,1)=input('Enter y value');
Desired_Disp(5,1)=input('Enter t value');

%Calculating Coeffiecients alpha,beta and gamma
 [C,mat1] = LieBracket_Pr(Desired_Disp);

alpha=C(3,1);
beta=C(4,1);
gamma=C(5,1);


if(Desired_Disp(3:5,1)==[1;0;0])
    
     [a1a,Displacements_Current] = Alpha(alpha,Disp);

elseif(Desired_Disp(3:5,1)==[0;1;0])
 
%      [a1c,a2c,a3c,Displacements_Current] = Gamma(gamma,Disp);
%      Disp=Displacements_Current;
%      
%      [a1b,a2b,a3b,Displacements_Current] = Beta(beta,Disp);

    
    [a1b,a2b,a3b,Displacements_Current] = BetaY(beta,Disp);
     Disp=Displacements_Current;
     
     [a1c,a2c,a3c,Displacements_Current] = MinusGamma(gamma,Disp);     
    
elseif(Desired_Disp(3:5,1)==[0;0;1])
    
%     beta=0.8871;
%     gamma=0.8871;
    
     [a1c,a2c,a3c,Displacements_Current] = Gamma(gamma,Disp);
     Disp=Displacements_Current;
     
     [a1b,a2b,a3b,Displacements_Current] = Beta(beta,Disp);

else
% % 
   q = Desired_Disp(5,1);
   
    for o=1:1:q 
    [a1c,a2c,a3c,Displacements_Current] = Gamma(gamma,Disp);
      Disp=Displacements_Current;
     
     [a1b,a2b,a3b,Displacements_Current] = Beta(beta,Disp);
     Disp=Displacements_Current;
%     
%      [a1a,Displacements_Current] = Alpha(alpha,Disp);
    end 
end












