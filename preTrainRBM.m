function [ randomBinValueVisible randomBinValueHidden  weight] = preTrainRBM(NOIN,NOHN,x,NOP,le,randomBinValueVisible,randomBinValueHidden)



weight=rand(NOIN,NOHN);  
biasVis=rand(1,NOIN); 
biasHid=rand(1,NOHN);


maxEpoch=100;
epoch=1;
alpha=0.5;
while epoch < maxEpoch 
    res1=biasVis*randomBinValueVisible';
    res2=biasHid*randomBinValueHidden';  
    SUMM=zeros(NOIN,NOHN);
    for i=1:NOIN        
        for j=1:NOHN
           SUMM(i,j)=SUMM(i,j)+ randomBinValueVisible(i)*randomBinValueHidden(j)*weight(i,j);          
        end         
    end
    E=(res1+res2+SUMM)*-1;
    
    A(epoch)=sum(sum(E))/(size(E,1)*size(E,2));
    
  
    for j=1:NOHN
        delE=0;
        for i=1:NOIN
            delE=delE + weight(i,j)*randomBinValueVisible(i)+biasHid(j);
        end
        p=1/(1+exp(-delE));
        
        if(rand()<=p)
            randomBinValueHidden(j)=1;
            h(j)=1;
        else
            h(j)=0;
        end
    end
   
    for i=1:NOIN
        delE=0;
        for j=1:NOHN
            delE=delE + weight(i,j)*randomBinValueHidden(j)+biasVis(i);
        end
        p=1/(1+exp(-delE));
        
        if(rand()<=p)
            randomBinValueVisible(i)=1;
            v(i)=1;
        else
            v(i)=0;
        end
    end
    

    
    size(x)
    p1=zeros(NOIN,NOHN);
     for k=1:NOP
      for i=1:NOIN
        for j=1:NOHN                        
                p1(i,j)= p1(i,j) + x(k,i)*h(j);            
        end
      end
     end
    
      for i=1:NOIN
        for j=1:NOHN                        
                p1(i,j)= p1(i,j)/NOP;            
        end
      end
    
    for i=1:NOIN
        for j=1:NOHN
            p2(i,j)=v(i)*h(j);
        end
    end
    

    delW=le*(p1-p2);
    weight=weight+delW;    
    epoch=epoch+1      
end

end

