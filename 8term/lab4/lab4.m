lab2_inputDataRob = dlmread('D:\UMRU\8term\lab2\Lr2_Voloshin_Utkin_out_2.txt');
lab3_inputDataRob= dlmread('D:\UMRU\8term\lab3\lab3_Utkin_Volosh_out.txt');
lab4_inputDataRob = dlmread('D:\UMRU\8term\lab4\Utkin_Volosh_4lab_out.txt');
ideal_inputDataRob = dlmread('D:\UMRU\8term\lab2\IdealData.txt');
lab2_outDataFromLab2 = dlmread('D:\UMRU\8term\lab2\dataFrom2To4.txt');
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

%get original data from lab2(���� ��������� �����)
lab2_f2= lab2_inputDataRob(:,2)-1.1345;
lab2_f3 = lab2_inputDataRob(:,3)+2.5654;
lab2_f4= lab2_inputDataRob(:,4)-1.8290;

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

%create plots of X lab

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

%delta fi2
figure;
hold on;
grid on;
plot(T,lab4_delta_fi2_Model);
plot(T,lab4_delta_fi2_Real);
plot(T,lab2_deltaf2);

xlabel('time,sec');
ylabel('delta fi2,rad');
legend({'lab 4 model','lab 4 real','lab 2 real'},'Location','southwest')
hold off;

%delta fi3
figure;
hold on;
grid on;
plot(T,lab4_delta_fi3_Model);
plot(T,lab4_delta_fi3_Real);
plot(T,lab2_deltaf3);

xlabel('time,sec');
ylabel('delta fi3,rad');
legend({'lab 4 model','lab 4 real','lab 2 real'},'Location','southwest')
hold off;

%delta fi4
figure;
hold on;
grid on;
plot(T,lab4_delta_fi4_Model);
plot(T,lab4_delta_fi4_Real);
plot(T,lab2_deltaf4);

xlabel('time,sec');
ylabel('delta fi4,rad');
legend({'lab 4 model','lab 4 real','lab 2 real'},'Location','southwest')
hold off;

%delta X

figure;
hold on;
grid on;
plot(T,lab4_delta_X_Model);
plot(T,lab4_delta_X_Real);
plot(T,lab2_deltaX);

xlabel('time,sec');
ylabel('delta X');
legend({'lab 4 model','lab 4 real','lab 2 real'},'Location','southwest')
hold off;

%delta Z

figure;
hold on;
grid on;
plot(T,lab4_delta_Z_Model);
plot(T,lab4_delta_Z_Real);
plot(T,lab2_deltaZ);

xlabel('time,sec');
ylabel('delta Z');
legend({'lab 4 model','lab 4 real','lab 2 real'},'Location','southwest')
hold off;
