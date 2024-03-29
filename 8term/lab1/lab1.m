inputDataRob = dlmread('D:\UMRU\8term\lab1\UtkinVoloshanin_lr1.txt');
%������ ��������� ���������, ������ � ������ 
%� ��������� �� � ���� f
A1 = inputDataRob(:,1);
A2 = inputDataRob(:,2);
A3 = inputDataRob(:,3);
A4 = inputDataRob(:,4);
A5 = inputDataRob(:,5);
f1 = -A1+2.9496;
f2 = A2 - 1.1345;
f3 = A3+2.5654;
f4 = A4 -1.8290;
f5 = -A5 + 2.9300;
dT = 0.05;
%������ �������� n-�� ����� ������������
% � i� ���������� �������
for i = 2:1:length(f1)
    V1(i-1) = (f1(i)-f1(i-1))/dT;
    V2(i-1) = (f2(i)-f2(i-1))/dT;
    V3(i-1) = (f3(i)-f3(i-1))/dT;
    V4(i-1) = (f4(i)-f4(i-1))/dT;
    V5(i-1) = (f5(i)-f5(i-1))/dT;
end

%������ ������ T 
T(1)  = 0;
for i = 2:1:length(f1)
    T(i) = T(i-1) + dT; 
end 


%�������� ������� �����
figure; 
p1f1 = plot(T,f1);
xlabel('�����, �������');
ylabel('����, �������');
grid on;
title('����� ��������� ���� 1');

figure; 
p1f2 = plot(T,f2);
xlabel('�����, �������');
ylabel('����, �������');
grid on;
title('����� ��������� ���� 2');

figure; 
p1f3 = plot(T,f3);
xlabel('�����, �������');
ylabel('����, �������');
grid on;
title('����� ��������� ���� 3');

figure; 
p1f4 = plot(T,f4);
xlabel('�����, �������');
ylabel('����, �������');
grid on;
title('����� ��������� ���� 4');

figure; 
p1f5 = plot(T,f5);
xlabel('�����, �������');
ylabel('����, �������');
grid on;
title('����� ��������� ���� 5');


%�������� ������ ������� �� ���� ������
Tspeed = T;
Tspeed(length(f1)) = [];

%�������� ������� ���������

%�������� ������� �����
figure; 
p2V1 = plot(Tspeed,V1);
xlabel('�����, �������');
ylabel('��������, �������/�');
grid on;
title('����� ��������� �������� 1');

figure; 
p2V2 = plot(Tspeed,V2);
xlabel('�����, �������');
ylabel('��������, �������/�');
grid on;
title('����� ��������� �������� 2');

figure; 
p2V3 = plot(Tspeed,V3);
xlabel('�����, �������');
ylabel('��������, �������/�');
grid on;
title('����� ��������� �������� 3');

figure; 
p2V4 = plot(Tspeed,V4);
xlabel('�����, �������');
ylabel('��������, �������/�');
grid on;
title('����� ��������� �������� 4');

figure; 
p2V5 = plot(Tspeed,V5);
xlabel('�����, �������');
ylabel('��������, �������/�');
grid on;
title('����� ��������� �������� 5');

%������ ������������ �������� ��������� 
V1max = max(abs(V1));
V2max = max(abs(V2));
V3max = max(abs(V3));
V4max = max(abs(V4));
V5max = max(abs(V5));

%�������� ��������� � �������� �����

delta_f1_start_finish = abs(f1(1)-f1(length(f1)));
delta_f2_start_finish = abs(f2(1)-f2(length(f1)));
delta_f3_start_finish = abs(f3(1)-f3(length(f1)));
delta_f4_start_finish = abs(f4(1)-f4(length(f1)));
delta_f5_start_finish = abs(f5(1)-f5(length(f1)));

%�������� ������� ����������� ��������� ��������� � ������������ ���������
figure; 
hold on;
grid on;
plot(V1max, delta_f1_start_finish,'-o');
plot(V2max, delta_f2_start_finish,'-o');
plot(V3max, delta_f3_start_finish,'-o');
plot(V4max, delta_f4_start_finish,'-o');
plot(V5max, delta_f5_start_finish,'-o');
xlabel('Vmax,���/�');
ylabel('|f(0)-f(end)|,���');
%������ ��������� �������� ����������� �������� 

%�������������� ��������
x_end = f1((length(f1)));

if (x_end-f1(1)) > 0
    x_max = max(f1);
elseif (x_end - f1(1)) < 0 
    x_max = min(f1);
end
%����������������� 
pereregul = x_max - x_end;
%������������� �����������������
otn_pereregul = 100*pereregul/x_end;
%���������� ����������
otkl = 0.05*abs(x_end);
%����� ����������� �������� 
for i = length(f1):-1:1
    if( abs(x_end - f5(i))> otkl)
        t_est = i*dT
        break
    end
end
        
%������ ����� 

%������ ��������� �������� ����������
A1_id = 2.5;
A2_id = 0.5;
A3_id = -1.5;
A4_id = 3.0;
A5_id = 2.5;

f1_id = -A1_id+2.9496;
f2_id  = A2_id - 1.1345;
f3_id  = A3_id+2.5654;
f4_id  = A4_id -1.8290;
f5_id  = -A5_id + 2.9300;


%��������� ���������� ����������� 
%���������������� ��� ������� �����

df1 = f1_id - f1(length(f1));
df2 = f2_id - f2(length(f1));
df3 = f3_id - f3(length(f1));
df4 = f4_id - f4(length(f1));
df5 = f5_id - f5(length(f1));

%��������� �������������
%����������� ����������������

d1 = df1/f1_id;
d2 = df2/f2_id;
d3 = df3/f3_id;
d4 = df4/f4_id;
d5 = df5/f5_id;

% ������ ����� 
l1 = 0.07; l2 = 0.155; l3 =0.135; l45 = 0.2176; d1 = 0.033;

xA = d1 + l2*sin(f2)+l3*sin(f2+f3)+l45*sin(f2+f3+f4);
zA = l1 + l2*cos(f2)+l3*cos(f2+f3)+l45*cos(f2+f3+f4);
thetha = f2 + f3+ f4 - pi/2;

%��������� ������
figure; 
plot(xA,zA);
xlabel('x');
ylabel('z');
grid on


%���������� ������

Z = zA;
X = xA.*cos(thetha);
Y = xA.*sin(thetha);

figure; 
plot3(X,Y,Z);
xlabel('x');
ylabel('y');
zlabel('z');
grid on
