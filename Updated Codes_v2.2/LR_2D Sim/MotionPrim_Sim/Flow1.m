%%Function to calculate first batch of the flow terms%%

function [a1a] = Flow1(t,n,alpha)

a1_dot=0;
a2_dot=0;
i=0.5*sqrt(t/n);
a1a= zeros(9,4);

 for t1=0:i:4*sqrt(t/n)

     if(t1<=sqrt(t/n))
       a1_dot=alpha*1;
       a2_dot=0;
   
     elseif(t1<=2*sqrt(t/n) && t1>sqrt(t/n))
       a1_dot=0;
       a2_dot=1;
       
     elseif(t1<=3*sqrt(t/n) && t1>2*sqrt(t/n))
       a1_dot=-alpha*1;
       a2_dot=0;    

     elseif(t1<=4*sqrt(t/n) && t1>3*sqrt(t/n))
       a1_dot=0;
       a2_dot=-1;  
     end

a1a(round(t1/i+1),1)= 0;
a1a(round(t1/i+1),2)= 0;
a1a(round(t1/i+1),3)= a1_dot;
a1a(round(t1/i+1),4)= a2_dot;
  if (t1~=0)
   a1a(round(t1/i+1),1)= a1a(round(t1/i),1) + a1_dot*0.5*sqrt(t/n);
   a1a(round(t1/i+1),2)= a1a(round(t1/i),2) + a2_dot*0.5*sqrt(t/n);
   a1a(round(t1/i+1),3)= a1_dot;
   a1a(round(t1/i+1),4)= a2_dot;
  end

 end

end