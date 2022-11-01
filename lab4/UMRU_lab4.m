
%�� ����� ����������� �� ������ ������� � ������
%� �������� ������ ������� �� ����������
dt = 0.1;
inputDataRob = dlmread('D:\UMRU\lab4\UtkinVolosh_lab4_brig1.txt');
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
%������ ��������������� �� ���������

dVx = Vxid - Vx_o;
dVy = Vyid - Vy_o;
ddPsi = Omid - dpsi;

%������ ���������
%������� ��������� ���������
ddVx(1) = 0;
ddVy(1) = 0;
ddOm(1) = 0;
%������ �� ������� �������� �� ����� 
for i =2 :1:length(dVx)
    ddVx(i,1) = (dVx(i,1)- dVx(i-1,1))/(dt);
    ddVy(i,1) = (dVy(i,1)- dVy(i-1,1))/(dt);
    ddOm(i,1) = (ddPsi(i,1)- ddPsi(i-1,1))/(dt);
end

%�������� ���������� ��������� � ��������� ������� ���������

%����������������� �������� ������� �� ��������, ��� ��������� ��������� ��
%������ ���� ����� ������� � ����� �������������
%��������� 
ddVx(2,1) = 0.5;
%������ ��������� �������� ������������ �����
%�������  ���������������� ���������� �������� �� �������� ����� 
for i =1 :1:length(dVx)
    xp(i,1) = 0;
    yp(i,1) = 0;
    psip(i,1) = 0;
end

Vxu(1,1) = Vxid(1,1);
Vyu(1,1) = Vyid(1,1);
Omu(1,1) = Omid(1,1);
for i =2 :1:length(dVx)
    Vxp(i,1) = Vxid(i,1)+ddVx(i,1)*dt;
    xp(i,1) = Vxp(i,1) *dt+xp(i-1,1);
    Vxu(i,1) = Vxid(i,1)+ (Vxid(i,1)-Vxp(i,1))+ (Xid(i,1)-xp(i,1))/dt;
    Vyp(i,1) = Vyid(i,1)+ddVy(i,1)*dt;
    yp(i,1) = Vyp(i,1) *dt+yp(i-1,1);
    Vyu(i,1) = Vyid(i,1)+ (Vyid(i,1)-Vyp(i,1))+ (Yid(i,1)-yp(i,1))/dt;
    Omp(i,1) = Omid(i,1)+ddOm(i,1)*dt;
    psip(i,1) = Omp(i,1) *dt+psip(i-1,1);
    Omu(i,1) = Omid(i,1)+ (Omid(i,1)-Omp(i,1))+ (psi_id(i,1)-psip(i,1))/dt;
end


%������� ����� Psi
psiS(1,1) = 0;
for i =2 :1:length(dVx)
    psiS(i,1) = psiS(i-1,1) + Omp(i,1)*dt;
end

%������ VXp � VYp 
VXp = Vxp.*cos(psiS)-Vyp.*sin(psi);
VYp = Vxp.*sin(psiS)+Vyp.*cos(psi);

%�������������� ���������� �������� ��� ��������� Xp � Yp - �������� ��
%�������� ����������
Xp(1) = 0;
Yp(1) = 0;
for i =2 :1:length(dVx)
    Xp(i,1) = Xp(i-1,1) + VXp(i,1)*dt;
    Yp(i,1) = Yp(i-1,1) + VYp(i,1)*dt;
end




%������ ��������������� �� ����������� �� 
dX = Xid-Xp;
dY = Yid -Yp;
delPsi = psi_id - psiS;
dVx = Vxid - VXp;
dVy = Vyid - VYp;
ddPsi = Omid - Omp;

%��������� ��� � ���.�������� ��� dX,dY,delPsi

%������ ������� ��������
dXsr = 0; dYsr = 0; delPsisr = 0;
for i = 1:1:length(dVx)
    dXsr = dXsr + dX(i);
    dYsr = dYsr + dY(i);
    delPsisr = delPsisr + delPsi(i);
end
%dXsr dYsr delPsisr ��� �� ����� ������������
dXsr = dXsr/length(dVx); dYsr = dYsr/length(dVx); delPsisr = delPsisr/length(dVx); 

%������ ��� 
dXsrSumm = 0; dYsrSumm = 0; delPsisrSumm = 0;
for i = 1:1:length(dVx)
    dXsrSumm = dXsrSumm + (dX(i)-dXsr)^2;
    dYsrSumm = dYsrSumm + (dY(i)-dYsr)^2;
    delPsisrSumm = delPsisrSumm + (delPsi(i)-delPsisr)^2;
end

SKOdX = sqrt(dXsrSumm/(length(dVx)-1))
SKOdY = sqrt(dYsrSumm/(length(dVx)-1))
SKOdelPsi = sqrt(delPsisrSumm/(length(dVx)-1))






plot(Xp,Yp)
grid on
hold on
plot(Xid,Yid)
plot(x0,y0)