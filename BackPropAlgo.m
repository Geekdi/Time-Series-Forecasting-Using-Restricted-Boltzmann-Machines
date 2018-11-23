function [v w epoch e]=BackPropAlgo(NOIN,NOHN,NOON,rInput,rHidden,rOut,w11,w22,x,t,NOP,no_of_epoch)
v=w11;  
w=w22;  
w1=zeros(NOHN,NOON);
v1=zeros(NOIN,NOHN);
alpha=0.021;
mf=.1;
con=1;
epoch=0;
while con
    e=0;
    for I=1:NOP
    
        x(:,I)=x(:,I).*rInput';
        for j=1:NOHN
       
            zin(j)=0;
            for i=1:NOIN
                zin(j)=zin(j)+v(i,j)*x(i,I);
            end
            z(j)=binsig(zin(j)); 
        end
        z=z.*rHidden;
        yin=z*w;
        y(I)=binsig(yin);
        

        delk=(t(I)-y(I))*binsig1(yin);
        delw=alpha*delk*z'+mf*(w-w1);
      
        delinj=delk*w;
        for i=1:NOHN
            delj(j,1)=delinj(j,1)*binsig1((zin(j)));
        end
        for j=1:NOHN
            for i=1:NOIN
                delv(i,j)=alpha*delj(j,1)*x(i,I)+mf*(v(i,j)-v1(i,j));
            end
        end
  
        w1=w;
        e1=e+(t(I)-y(I))^2;
        v1=v;
   
        w=w+delw;
   
        v=v+delv;
      al=w-w1;
      
        e=e1+(t(I)-y(I))^2;
        all=e-e1;
      [d,q]=size(al);
      f=ones(d,q);
       g=size(f);
  
     f(1,1)=all;
        aal=dot(al,al)/dot(al,f);
    end
 
     if(epoch>no_of_epoch)
          con=0;
     else
         con=1;
     end  
    
    epoch=epoch+1;
    disp(e);
end
end