%%Function to calculate first batch of the flow terms%%

function [a1c,a2c,a3c] = Flow3(t,n,gamma)

a1_dot=0;
a2_dot=0;
i=sqrt(t)/n;
j=sqrt(sqrt(t))/n;
a1c= zeros(5,4);
a2c= zeros(5,4);
a3c= zeros(5,4);


 for t1=0:i:4*sqrt(t)/n
     
      if(t1<=i)
          a1_dot=0;
          a2_dot=gamma; 
                    
          a1c(round(t1/i+1),1)= 0;
          a1c(round(t1/i+1),2)= 0;
          a1c(round(t1/i+1),3)= a1_dot;
          a1c(round(t1/i+1),4)= a2_dot;
           if(t1~=0) 
              a1c(round(t1/i+1),1)= a1c(round(t1/i),1) + a1_dot*i;
              a1c(round(t1/i+1),2)= a1c(round(t1/i),2) + a2_dot*i;
              a1c(round(t1/i+1),3)= a1_dot;
              a1c(round(t1/i+1),4)= a2_dot;
           end 
      
      elseif(t1<=2*i && t1>i)
          
            for t3=0:j:4*sqrt(sqrt(t))/n
   
              if(t3<=j)
                 a1_dot=1;
                 a2_dot=0;
   
              elseif(t3<=2*j && t3>j)
                 a1_dot=0;
                 a2_dot=1;
       
              elseif(t3<=3*j && t3>2*j)
                 a1_dot=-1;
                 a2_dot=0;    

              elseif(t3<=4*j && t3>3*j)
                 a1_dot=0;
                 a2_dot=-1;  
              end
            a2c(round(t3/j+1),1)= a1c(round(t1/i),1);
            a2c(round(t3/j+1),2)= a1c(round(t1/i),2);
            a2c(round(t3/j+1),3)= a1_dot;
            a2c(round(t3/j+1),4)= a2_dot;
            if(t3==j)   
                a2c(round(t3/j+1),1)= a1c(round(t1/i),1) + a1_dot*j;
                a2c(round(t3/j+1),2)= a1c(round(t1/i),2) + a2_dot*j;
                a2c(round(t3/j+1),3)= a1_dot;
                a2c(round(t3/j+1),4)= a2_dot;
            elseif(t3>j && t3<=4*j)
                a2c(round(t3/j+1),1)= a2c(round(t3/j),1) + a1_dot*j;
                a2c(round(t3/j+1),2)= a2c(round(t3/j),2) + a2_dot*j;
                a2c(round(t3/j+1),3)= a1_dot;
                a2c(round(t3/j+1),4)= a2_dot;
            end
           end
      elseif(t1<=3*i && t1>2*i)
          a1_dot=0;
          a2_dot=-gamma;
            
              a1c(4,1)= a2c(5,1) + a1_dot*i;
              a1c(4,2)= a2c(5,2) + a2_dot*i;
              a1c(4,3)= a1_dot;
              a1c(4,4)= a2_dot;
          
      elseif(t1<=4*i && t1>3*i)
           
            for t2=0:j:4*sqrt(sqrt(t))/n
   
              if(t2<=j)
                 a1_dot=-1;
                 a2_dot=0;
   
              elseif(t2<=2*j && t2>j)
                 a1_dot=0;
                 a2_dot=-1;
       
              elseif(t2<=3*j && t2>2*j)
                 a1_dot=1;
                 a2_dot=0;    

              elseif(t2<=4*j && t2>3*j)
                 a1_dot=0;
                 a2_dot=1;  
              end
            a3c(round(t2/j+1),1)= a1c(round(t1/i),1);
            a3c(round(t2/j+1),2)= a1c(round(t1/i),2);
            a3c(round(t2/j+1),3)= a1_dot;
            a3c(round(t2/j+1),4)= a2_dot;
            if(t2==j)   
                a3c(round(t2/j+1),1)= a1c(round(t1/i),1) + a1_dot*j;
                a3c(round(t2/j+1),2)= a1c(round(t1/i),2) + a2_dot*j;
                a3c(round(t2/j+1),3)= a1_dot;
                a3c(round(t2/j+1),4)= a2_dot;
            elseif(t2>j && t2<=4*j)
                a3c(round(t2/j+1),1)= a3c(round(t2/j),1) + a1_dot*j;
                a3c(round(t2/j+1),2)= a3c(round(t2/j),2) + a2_dot*j;
                a3c(round(t2/j+1),3)= a1_dot;
                a3c(round(t2/j+1),4)= a2_dot;
            end
          end            
      end
 end

end
      
   

      