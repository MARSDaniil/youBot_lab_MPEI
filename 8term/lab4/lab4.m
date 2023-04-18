lab2_inputDataRob = dlmread('D:\UMRU\8term\lab2\Lr2_Voloshin_Utkin_out_2.txt');
lab3_inputDataRob= dlmread('D:\UMRU\8term\lab3\lab3_Utkin_Volosh_out.txt');
lab4_inputDataRob = dlmread('D:\UMRU\8term\lab4\Utkin_Volosh_4lab_out.txt');

%enter the initial parameters taken from the robot 
%and make their transition to the angle ?

    % first paragraph
    % 
    %Statement of the problem as a given trajectory
    %
    %
    %

lab2_f2= lab2_inputDataRob(:,2)-1.1345;
lab2_f3 = lab2_inputDataRob(:,3)+2.5654;
lab2_f4= lab2_inputDataRob(:,4)-1.8290;
    

lab4_f2= lab4_inputDataRob(:,2);
lab4_f3 = lab4_inputDataRob(:,4);
lab4_f4= lab4_inputDataRob(:,6);

%rotate arrows
lab2_f2 = lab2_f2';
lab2_f3 = lab2_f3';
lab2_f4 = lab2_f4';


lab4_f2 = lab4_f2';
lab4_f3 = lab4_f3';
lab4_f4 = lab4_f4';


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
for i = 2:1:length(f2_lab4)
    T(i) = T(i-1) + dT; 
end 