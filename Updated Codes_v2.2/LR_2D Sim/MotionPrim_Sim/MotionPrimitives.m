%%% Simulation of motion along the motion primitives

% function [a1a,a1b,a2b,a3b,a1c,a2c,a3c,Current_Disp] = MotionPrimitives(Disp_given,Desired_Disp)
%Initialization of Displacements to Identity Matrix to be premultiplied with Matrix Exponential in further iterations
Displacements_Prev = eye(3);
Displacements_Current = eye(3);
Disp = eye(3);

%Maximum simulation time (s)
tmax = 0;

%Input values
Desired_Disp=Disp_correction;

% %Calculating Coeffiecients alpha,beta and gamma
%  [C,mat1] = LieBracket_Pr(Desired_Disp);
% 
% alpha=C(3,1);
% beta=C(4,1);
% gamma=C(5,1);
alpha = 0.8999;
beta = 0.8871;
gamma = 0.8871;

% if()
    
     [a1a,Displacements_Current] = Alpha(alpha,Disp);

% else()     
%      
%      beta=0.8871;
%      gamma=0.8871;
%      
%      [a1c,a2c,a3c,Displacements_Current] = Gamma(gamma);
%      Disp=Displacements_Current;
%      
%      [a1b,a2b,a3b,Displacements_Current] = MinusBeta(beta,Disp);
%      Disp=Displacements_Current;
%      
% end
% end











