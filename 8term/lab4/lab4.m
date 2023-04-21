lab2_inputDataRob = dlmread('D:\UMRU\8term\lab2\Lr2_Voloshin_Utkin_out_2.txt');
lab3_inputDataRob= dlmread('D:\UMRU\8term\lab3\lab3_Utkin_Volosh_out.txt');
lab4_inputDataRob = dlmread('D:\UMRU\8term\lab4\Utkin_Volosh_4lab_out.txt');
ideal_inputDataRob = dlmread('D:\UMRU\8term\lab2\IdealData.txt');
lab2_outDataFromLab2 = dlmread('D:\UMRU\8term\lab2\dataFrom2To4.txt');

lab3_outDataRob = dlmread('D:\UMRU\8term\lab3\lab3_Utkin_Volosh_out.txt');
lab3_inputDateRob = dlmread('D:\UMRU\8term\lab3\Lab3UtkinVolosh.txt');
%enter the initial parameters taken from the robot 
%and make their transition to the angle ?

    % first paragraph
    % 
    %Statement of the problem as a given trajectory
    %
    %
    %
%

%open ideal data
fi2_Ideal = ideal_inputDataRob(:,1);
fi3_Ideal = ideal_inputDataRob(:,2);
fi4_Ideal = ideal_inputDataRob(:,3);
X_Ideal = ideal_inputDataRob(:,4);
Z_Ideal = ideal_inputDataRob(:,5);




%get delta data from laba 2
lab2_deltaX  = lab2_outDataFromLab2(:,1);
lab2_deltaZ = lab2_outDataFromLab2(:,2);
lab2_deltaf2 = lab2_outDataFromLab2(:,3);
lab2_deltaf3 = lab2_outDataFromLab2(:,4);
lab2_deltaf4 = lab2_outDataFromLab2(:,5);

%get original data from lab2(пока непонятно зачем)
lab2_f2= lab2_inputDataRob(:,2)-1.1345;
lab2_f3 = lab2_inputDataRob(:,3)+2.5654;
lab2_f4= lab2_inputDataRob(:,4)-1.8290;


%get data from lab 3

lab3_f2_real = lab3_outDataRob(:,2)-1.1345;
lab3_f3_real = lab3_outDataRob(:,3)+2.5654;
lab3_f4_real = lab3_outDataRob(:,4)-1.8290;

lab3_f2_model = lab3_inputDateRob(:,1);
lab3_f3_model = lab3_inputDateRob(:,2);
lab3_f4_model = lab3_inputDateRob(:,3);

%get data to lab4 


lab4_f2_real = lab4_inputDataRob(:,2)-1.1345;
lab4_f3_real = lab4_inputDataRob(:,4)+2.5654;
lab4_f4_real = lab4_inputDataRob(:,6)-1.8290;

lab4_f2_model = lab4_inputDataRob(:,1)-1.1345;
lab4_f3_model = lab4_inputDataRob(:,3)+2.5654;
lab4_f4_model = lab4_inputDataRob(:,5)-1.8290;

%set lenght + 1 element to lab4(because in lab 2 there is one more element)

lab4_f2_model(301) = lab4_f2_model(300);
lab4_f3_model(301) = lab4_f3_model(300);
lab4_f4_model(301) = lab4_f4_model(300);

lab4_f2_real(301) = lab4_f2_real(300);
lab4_f3_real(301) = lab4_f3_real(300);
lab4_f4_real(301) = lab4_f4_real(300);



%set default setting
l1 = 0.07;
l2 = 0.155; 
l3 =0.135; 
l45 = 0.2176; 
d1 = 0.033;
thetha = -1;
dT = 0.05;
%create Time arrow
T(1)  = 0;
for i = 2:1:(length(lab4_f2_model))
    T(i,1) = T(i-1,1) + dT; 
end 




%robot movement trajectories by lab4 

lab4_X_real = d1 + l2*sin(lab4_f2_real)+l3*sin(lab4_f2_real + lab4_f3_real) + l45*sin(lab4_f2_real+lab4_f3_real+lab4_f4_real);
lab4_Z_real = l1 + l2*cos(lab4_f2_real)+l3*cos(lab4_f2_real + lab4_f3_real) + l45*cos(lab4_f2_real+lab4_f3_real+lab4_f4_real);


lab4_X_model = d1 + l2*sin(lab4_f2_model)+l3*sin(lab4_f2_model + lab4_f3_model) + l45*sin(lab4_f2_model+lab4_f3_model+lab4_f4_model);
lab4_Z_model = l1 + l2*cos(lab4_f2_model)+l3*cos(lab4_f2_model + lab4_f3_model) + l45*cos(lab4_f2_model+lab4_f3_model+lab4_f4_model);


%robot movement trajectories by lab3

lab3_X_real = d1 + l2*sin(lab3_f2_real)+l3*sin(lab3_f2_real + lab3_f3_real) + l45*sin(lab3_f2_real+lab3_f3_real+lab3_f4_real);
lab3_Z_real = l1 + l2*cos(lab3_f2_real)+l3*cos(lab3_f2_real + lab3_f3_real) + l45*cos(lab3_f2_real+lab3_f3_real+lab3_f4_real);


lab3_X_model = d1 + l2*sin(lab3_f2_model)+l3*sin(lab3_f2_model + lab3_f3_model) + l45*sin(lab3_f2_model+lab3_f3_model+lab3_f4_model);
lab3_Z_model = l1 + l2*cos(lab3_f2_model)+l3*cos(lab3_f2_model + lab3_f3_model) + l45*cos(lab3_f2_model+lab3_f3_model+lab3_f4_model);


%create plots of X lab 4

figure;
hold on;
grid on;
plot(T,lab4_X_real)
xlabel('time, sec');
ylabel('lab 4 X real,m');

figure;
hold on;
grid on;
plot(T,lab4_Z_real)
xlabel('time, sec');
ylabel('lab 4 Z real,m');


figure;
hold on;
grid on;
plot(T,lab4_X_model)
xlabel('time, sec');
ylabel('lab 4 X model,m');

figure;
hold on;
grid on;
plot(T,lab4_Z_model)
xlabel('time, sec');
ylabel('lab 4 Z model,m');


%create plots of X lab 3

figure;
hold on;
grid on;
plot(T,lab3_X_real)
xlabel('time, sec');
ylabel('lab 3 X real,m');

figure;
hold on;
grid on;
plot(T,lab3_Z_real)
xlabel('time, sec');
ylabel('lab 3 Z real,m');


figure;
hold on;
grid on;
plot(T,lab3_X_model)
xlabel('time, sec');
ylabel('lab 3 X model,m');

figure;
hold on;
grid on;
plot(T,lab3_Z_model)
xlabel('time, sec');
ylabel('lab 3 Z model,m');


%find the discrepancy between ideal and other for lab4 

lab4_delta_fi2_Model = fi2_Ideal - lab4_f2_model;
lab4_delta_fi3_Model = fi3_Ideal - lab4_f3_model;
lab4_delta_fi4_Model = fi4_Ideal - lab4_f4_model;

lab4_delta_fi2_Real = fi2_Ideal - lab4_f2_real;
lab4_delta_fi3_Real = fi3_Ideal - lab4_f3_real;
lab4_delta_fi4_Real = fi4_Ideal - lab4_f4_real;

lab4_delta_X_Model = X_Ideal - lab4_X_model;
lab4_delta_Z_Model = Z_Ideal - lab4_Z_model;

lab4_delta_X_Real = X_Ideal - lab4_X_real;
lab4_delta_Z_Real = Z_Ideal - lab4_Z_real;


%find the discrepancy between ideal and other for lab3 

lab3_delta_fi2_Model = fi2_Ideal - lab3_f2_model;
lab3_delta_fi3_Model = fi3_Ideal - lab3_f3_model;
lab3_delta_fi4_Model = fi4_Ideal - lab3_f4_model;

lab3_delta_fi2_Real = fi2_Ideal - lab3_f2_real;
lab3_delta_fi3_Real = fi3_Ideal - lab3_f3_real;
lab3_delta_fi4_Real = fi4_Ideal - lab3_f4_real;

lab3_delta_X_Model = X_Ideal - lab3_X_model;
lab3_delta_Z_Model = Z_Ideal - lab3_Z_model;

lab3_delta_X_Real = X_Ideal - lab3_X_real;
lab3_delta_Z_Real = Z_Ideal - lab3_Z_real;

%delta fi2
figure;
hold on;
grid on;
plot(T,lab4_delta_fi2_Model);
plot(T,lab4_delta_fi2_Real);
plot(T,lab3_delta_fi2_Model);
plot(T,lab3_delta_fi2_Real);
plot(T,lab2_deltaf2);

xlabel('time,sec');
ylabel('delta fi2,rad');
legend({'lab 4 model','lab 4 real','lab 3 model','lab 3 real','lab 2 real'},'Location','northwest')
hold off;

%delta fi3
figure;
hold on;
grid on;
plot(T,lab4_delta_fi3_Model);
plot(T,lab4_delta_fi3_Real);
plot(T,lab3_delta_fi3_Model);
plot(T,lab3_delta_fi3_Real);
plot(T,lab2_deltaf3);

xlabel('time,sec');
ylabel('delta fi3,rad');
legend({'lab 4 model','lab 4 real','lab 3 model','lab 3 real','lab 2 real'},'Location','southwest')
hold off;

%delta fi4
figure;
hold on;
grid on;
plot(T,lab4_delta_fi4_Model);
plot(T,lab4_delta_fi4_Real);
plot(T,lab3_delta_fi4_Model);
plot(T,lab3_delta_fi4_Real);
plot(T,lab2_deltaf4);

xlabel('time,sec');
ylabel('delta fi4,rad');
legend({'lab 4 model','lab 4 real','lab 3 model','lab 3 real','lab 2 real'},'Location','southwest')
hold off;

%delta X

figure;
hold on;
grid on;
plot(T,lab4_delta_X_Model);
plot(T,lab4_delta_X_Real);
plot(T,lab3_delta_X_Model);
plot(T,lab3_delta_X_Real);
plot(T,lab2_deltaX);

xlabel('time,sec');
ylabel('delta X');
legend({'lab 4 model','lab 4 real','lab 3 model','lab 3 real','lab 2 real'},'Location','southwest')
hold off;

%delta Z

figure;
hold on;
grid on;
plot(T,lab4_delta_Z_Model);
plot(T,lab4_delta_Z_Real);
plot(T,lab3_delta_Z_Model);
plot(T,lab3_delta_Z_Real);
plot(T,lab2_deltaZ);

xlabel('time,sec');
ylabel('delta Z');
legend({'lab 4 model','lab 4 real','lab 3 model','lab 3 real','lab 2 real'},'Location','southwest')
hold off;


% for lab2 find Standard deviation(SKO) and Expected value(X/Z_sr) 

%find the average value
lab2_dXsr = 0; lab2_dZsr = 0;
for i = 1:1:length(lab3_delta_X_Model)
    lab2_dXsr = lab2_dXsr + lab2_deltaX(i);
    lab2_dZsr = lab2_dZsr + lab2_deltaZ(i);

end
%dXsr dYsr delPsisr are also expected value
lab2_dXsr = lab2_dXsr/length(lab3_delta_X_Model);
lab2_dZsr = lab2_dZsr/length(lab3_delta_X_Model);

%found standard deviation(SKO)
lab2_dXsrSumm = 0; lab2_dZsrSumm = 0;
for i = 1:1:length(lab3_delta_X_Model)
    lab2_dXsrSumm = lab2_dXsrSumm + (lab2_deltaX(i)-lab2_dXsr)^2;
    lab2_dZsrSumm = lab2_dZsrSumm + (lab2_deltaZ(i)-lab2_dZsr)^2;
end

lab2_SKOdX = sqrt(lab2_dXsrSumm/(length(lab3_delta_X_Model)-1));
lab2_SKOdZ = sqrt(lab2_dZsrSumm/(length(lab3_delta_X_Model)-1));


% for lab3 find Standard deviation(SKO) and Expected value(X/Z_sr) 

%find the average value
lab3_dXsr_real = 0; lab3_dZsr_real = 0; lab3_dXsr_model = 0; lab3_dZsr_model = 0;
for i = 1:1:length(lab3_delta_X_Model)
    lab3_dXsr_real = lab3_dXsr_real + lab3_delta_X_Real(i);
    lab3_dZsr_real = lab3_dZsr_real + lab3_delta_Z_Real(i);
    
    lab3_dXsr_model = lab3_dXsr_model + lab3_delta_X_Model(i);
    lab3_dZsr_model = lab3_dZsr_model + lab3_delta_Z_Model(i);

end
%dXsr dYsr delPsisr are also expected value
lab3_dXsr_real = lab3_dXsr_real/length(lab3_delta_X_Model);
lab3_dZsr_real = lab3_dZsr_real/length(lab3_delta_X_Model);

lab3_dXsr_model = lab3_dXsr_model/length(lab3_delta_X_Model);
lab3_dZsr_model = lab3_dZsr_model/length(lab3_delta_X_Model);

%found standard deviation(SKO)
lab3_dXsrSumm_real = 0; lab3_dZsrSumm_real = 0; lab3_dXsrSumm_model = 0; lab3_dZsrSumm_model = 0;
for i = 1:1:length(lab3_delta_X_Model)
    lab3_dXsrSumm_real = lab3_dXsrSumm_real + (lab3_delta_X_Real(i)-lab3_dXsr_real)^2;
    lab3_dZsrSumm_real = lab3_dZsrSumm_real + (lab3_delta_Z_Real(i)-lab3_dZsr_real)^2;
    
    lab3_dXsrSumm_model = lab3_dXsrSumm_model + (lab3_delta_X_Model(i)-lab3_dXsr_model)^2;
    lab3_dZsrSumm_model = lab3_dZsrSumm_model + (lab3_delta_Z_Model(i)-lab3_dZsr_model)^2;
end

lab3_SKOdX_real = sqrt(lab3_dXsrSumm_real/(length(lab3_delta_X_Model)-1));
lab3_SKOdZ_real = sqrt(lab3_dZsrSumm_real/(length(lab3_delta_X_Model)-1));


lab3_SKOdX_model = sqrt(lab3_dXsrSumm_model/(length(lab3_delta_X_Model)-1));
lab3_SKOdZ_model = sqrt(lab3_dZsrSumm_model/(length(lab3_delta_X_Model)-1));



% for lab4 find Standard deviation(SKO) and Expected value(X/Z_sr) 

%find the average value
lab4_dXsr_real = 0; lab4_dZsr_real = 0; lab4_dXsr_model = 0; lab4_dZsr_model = 0;
for i = 1:1:length(lab3_delta_X_Model)
    lab4_dXsr_real = lab4_dXsr_real + lab4_delta_X_Real(i);
    lab4_dZsr_real = lab4_dZsr_real + lab4_delta_Z_Real(i);
    
    lab4_dXsr_model = lab4_dXsr_model + lab4_delta_X_Model(i);
    lab4_dZsr_model = lab4_dZsr_model + lab4_delta_Z_Model(i);

end
%dXsr dYsr delPsisr are also expected value
lab4_dXsr_real = lab4_dXsr_real/length(lab3_delta_X_Model);
lab4_dZsr_real = lab4_dZsr_real/length(lab3_delta_X_Model);

lab4_dXsr_model = lab4_dXsr_model/length(lab3_delta_X_Model);
lab4_dZsr_model = lab4_dZsr_model/length(lab3_delta_X_Model);

%found standard deviation(SKO)
lab4_dXsrSumm_real = 0; lab4_dZsrSumm_real = 0; lab4_dXsrSumm_model = 0; lab4_dZsrSumm_model = 0;
for i = 1:1:length(lab4_delta_X_Model)
    lab4_dXsrSumm_real = lab4_dXsrSumm_real + (lab4_delta_X_Real(i)-lab4_dXsr_real)^2;
    lab4_dZsrSumm_real = lab4_dZsrSumm_real + (lab4_delta_Z_Real(i)-lab4_dZsr_real)^2;
    
    lab4_dXsrSumm_model = lab4_dXsrSumm_model + (lab4_delta_X_Model(i)-lab4_dXsr_model)^2;
    lab4_dZsrSumm_model = lab4_dZsrSumm_model + (lab4_delta_Z_Model(i)-lab4_dZsr_model)^2;
end

lab4_SKOdX_real = sqrt(lab4_dXsrSumm_real/(length(lab4_delta_X_Model)-1));
lab4_SKOdZ_real = sqrt(lab4_dZsrSumm_real/(length(lab4_delta_X_Model)-1));


lab4_SKOdX_model = sqrt(lab4_dXsrSumm_model/(length(lab4_delta_X_Model)-1));
lab4_SKOdZ_model = sqrt(lab4_dZsrSumm_model/(length(lab4_delta_X_Model)-1));

%found delta SKO and expected value

%lab 3 

%expected value

lab3_deltaExpVal_X = lab3_dXsr_real - lab3_dXsr_model;
lab3_deltaExpVal_Z = lab3_dZsr_real - lab3_dZsr_model;

%sko

lab3_deltaSKO_X = lab3_SKOdX_real - lab3_SKOdX_model;
lab3_deltaSKO_Z = lab3_SKOdZ_real - lab3_SKOdZ_model;


%lab 4 

%expected value

lab4_deltaExpVal_X = lab4_dXsr_real - lab4_dXsr_model;
lab4_deltaExpVal_Z = lab4_dZsr_real - lab4_dZsr_model;

%sko

lab4_deltaSKO_X = lab4_SKOdX_real - lab4_SKOdX_model;
lab4_deltaSKO_Z = lab4_SKOdZ_real - lab4_SKOdZ_model;


%The total error of the method through the expected value

%lab 3 

lab3_SigmSumm_X = sqrt(lab3_dXsr_real^2+lab3_dXsr_model^2);
lab3_SigmSumm_Z = sqrt(lab3_dZsr_real^2+lab3_dZsr_model^2);


%lab4 

lab4_SigmSumm_X = sqrt(lab4_dXsr_real^2+lab4_dXsr_model^2);
lab4_SigmSumm_Z = sqrt(lab4_dZsr_real^2+lab4_dZsr_model^2);