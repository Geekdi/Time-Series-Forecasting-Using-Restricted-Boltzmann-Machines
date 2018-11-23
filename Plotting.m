function len=Plotting(Data,train)
   
    %len_test=length(Data(1,:))-train;
    len=length(Data(1,:));
    len_train=floor(train*len/100);
    clf
    % Actual Data
    plot(1:len_train,Data(1,1:len_train),'g','LineWidth',2.0) % drawing
    title('Comparision of Forecasted Value and Actual Value')
    hold on;
    plot(len_train:len,Data(1,len_train:len),'c','LineWidth',2.0) % drawing
    hold on;

    %Forecasted Data
    plot(1:len_train,Data(2,1:len_train),'LineWidth',2.0) % drawing
    title('Comparision of Forecasted Value and Actual Value')
    hold on;
    plot(len_train:len,Data(2,len_train:len),'r','LineWidth',2.0) % drawing
    hold on;
    % plot(train:len,Data(2,train:len),'c') 
    legend('Actual Train Data','Actual Test Data','Forecasted Train Data','Forecasted Test Data');
    xlabel('Time Instance') % x-axis label
    ylabel('Time Series Value') % y-axis label   
end