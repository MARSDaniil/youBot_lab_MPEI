%�� ����� ����������� �� ������ ������� � ������
%� �������� ������ ������� �� ����������
inputDataRob = dlmread('D:\UMRU\lab1\S12b_19_brig_1.txt');
t = inputDataRob(:,1);
omega_1 = inputDataRob(:,2);
omega_2= inputDataRob(:,3);
omega_3= inputDataRob(:,4);
omega_4= inputDataRob(:,5);
M1= inputDataRob(:,6);
M2= inputDataRob(:,7);
M3= inputDataRob(:,8);
M4= inputDataRob(:,9);
Vx_o= inputDataRob(:,10);
Vy_o= inputDataRob(:,11);
dpsi= inputDataRob(:,12);
x0= inputDataRob(:,13);
y0= inputDataRob(:,14);
psi = inputDataRob(:,15);
%������� ���� � ������� �� ��������� ������������
inputDataIdeal = dlmread('D:\UMRU\lab1\perfect_squareUV1.txt');
Xid = inputDataIdeal(:,1);
Yid = inputDataIdeal(:,2);
psi_id = inputDataIdeal(:,3);
%������� ���� � ������� �� ��������� ���������
inputDataIdSpeed = dlmread('D:\UMRU\lab1\square.txt');
Vxid = inputDataIdSpeed(:,1);
Vyid = inputDataIdSpeed(:,2);
Omid = inputDataIdSpeed(:,3);
%������ ��������������� �� �����������
dX = Xid-x0;
dY = Yid -y0;
delPsi = psi_id - psi;
dVx = Vxid - Vx_o;
dVy = Vyid - Vy_o;
ddPsi = Omid - dpsi;
%������� ���������� ��������� ��� ������ �� �������� ���������
integraDVxdt(1,1) = t(1)*dVx(1,1);
for i = 2:1:length(dVx)
integraDVxdt(i,1) = t(i)*dVx(i,1)+integraDVxdt(i-1,1);
end 

integraDVydt(1,1) = t(1)*dVy(1,1);
for i = 2:1:length(dVx)
integraDVydt(i,1) = t(i)*dVy(i,1)+integraDVydt(i-1,1);
end 

integraDdpsi(1,1) = t(1)*ddPsi(1,1);
for i = 2:1:length(dVx)
integraDdpsi(i,1) = t(i)*ddPsi(i,1)+integraDdpsi(i-1,1);
end 
%������� � - ������� ������� �������� ��������� ������
B = zeros(length(dVx)*3,1);
k = 1;
for i = 1:3:((length(dVx)*3))
    B(i,1) = dX(k,1)- integraDVxdt(k,1);
    B(i+1,1) = dY(k,1)- integraDVydt(k,1);
    B(i+2,1) = delPsi(k,1)- integraDdpsi(k,1);
    k = k + 1;
end
%������� � - ������� ������� �������������
A = zeros(length(dVx)*3,1);
k = 1;
for i = 1:3:((length(dVx)*3))
    A(i,1) = Vxid(k,1);
    A(i+1,1) = Vyid(k,1);
    A(i+2,1) = Omid(k,1);
    k=k+1;
end
%��������� ����� ������������ 
dtzap = inv(A'*A)*A'*B;
%������ ��������������� ����������
for i = 1:1:length(dVx)
Xvost(i,1) = x0(i,1)+Vxid(i,1)*dtzap+integraDVxdt(i,1);
end
for i = 1:1:length(dVx)
Yvost(i,1) = y0(i,1)+Vyid(i,1)*dtzap+integraDVydt(i,1);
end