clc;
clear all;
filename=input('Enter The File name');
OData=xlsread(filename)';
figure
subplot(2,1,1)
autocorr(OData)
subplot(2,1,2)
parcorr(OData)

ttrain=input('Enter Train Pattern Percentage');
epoch=str2num(input('Maximum Number of Epochs for Back Propagation:'));


    len=size(OData,2);
    maxD=max(OData);
    minD=min(OData);
    ma=1;
    mi=0;
    for i=1:len
        Data(i)=(OData(i)-minD)/(maxD-minD);
    end

NOIN=input('Enter The Number of Inputs in Input Layer:');   
NOHN=12;   
NOON=1;
le=0.2;
NOP=length(Data)-NOIN;         
x(1:NOP,1:NOIN)=zeros(NOP,NOIN);
t(1:NOP)=zeros(1,NOP);
for i=1:NOP
   x(i,1:NOIN)=Data(i:i+NOIN-1);   
   t(i)=Data(i+NOIN); 
end

NOP1=floor(NOP*(str2double(ttrain)/100));

randomBinValueVisible=round(rand(1,NOIN))   
randomBinValueHidden=round(rand(1,NOHN))    
[ randomBinValueVisible1 randomBinValueHidden1   weight1] = preTrainRBM(NOIN,NOHN,x,NOP1,le,randomBinValueVisible,randomBinValueHidden)


for k=1:NOP1    
  for j=1:NOHN 
      xRBM2(k,j)=0;
    for i=1:NOIN
        xRBM2(k,j)=xRBM2(j) + x(k,i)*weight1(i,j)*randomBinValueVisible1(i);
    end
  end
end

xRBM2
rBinVis=round(rand(1,NOON));
[randomBinValueVisible2  randomBinValueHidden2  weight2] = preTrainRBM(NOHN,NOON,xRBM2 ,NOP1,le,randomBinValueHidden1,rBinVis)


size(x')
[v w epoch e]=BackPropAlgo(NOIN,NOHN,NOON,randomBinValueVisible1,randomBinValueVisible2,randomBinValueHidden2,weight1,weight2,x',t,NOP1,epoch);



rInput=randomBinValueHidden2
rHidden=randomBinValueVisible2
yyy=x;
clear x;
x=yyy';
    for I=1:NOP
        x(:,I)=x(:,I).*rInput;
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
    end
for i=1:length(y)
    res(i)=y(i)*(maxD-minD)+minD;
end
FinalRes(:,1)=OData;
k=1;
for i=1:size(OData,2)
    if(i<=NOIN)
        FinalRes(i,2)=OData(i);
    else
        FinalRes(i,2)=res(k);
        k=k+1;
    end
end
xlswrite('Result.xls',FinalRes);
Plotting(FinalRes',ttrain);
trainsmape=0;
e=0;
for I=1:floor(ttrain/100*size(FinalRes,1))
    e=e+1;
    trainsmape=trainsmape+(abs(FinalRes(I,1)-FinalRes(I,2))/((abs(FinalRes(I,1))+abs(FinalRes(I,2)))/2))*100;
end
Train_SMAPE=trainsmape/(e)


testsmape=0;
e=0;
for I=floor(ttrain/100*size(FinalRes,1))+1:size(FinalRes,1)
    e=e+1;
    testsmape=testsmape+(abs(FinalRes(I,1)-FinalRes(I,2))/((abs(FinalRes(I,1))+abs(FinalRes(I,2)))/2))*100;
end
Test_SMAPE=testsmape/(e)
