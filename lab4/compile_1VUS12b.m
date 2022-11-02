%�� ����� ����������� �� ������ ������� � ������
%� �������� ������ ������� �� ����������
dt = 0.1;

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
%ddVx(2,1) = 0.5;
%������ ��������� �������� ������������ �����
%������� ���������������� ���������� �������� �� �������� �����
for i =1 :1:length(dVx)
xp(i,1) = 0;
yp(i,1) = 0;
psip(i,1) = 0;
end
Vxu(1,1) = Vxid(1,1);
Vyu(1,1) = Vyid(1,1);
Omu(1,1) = Omid(1,1);


Vxp(2,1) = Vxid(2,1)+ddVx(2,1)*dt;
xp(2,1) = Vxp(2,1) *dt+xp(2-1,1);
Vxu(2,1) = Vxid(2,1)+ (Vxid(2,1)-Vxp(2,1))+ (Xid(2,1)-xp(2,1))*dt;
Vyp(2,1) = Vyid(2,1)+ddVy(2,1)*dt;
yp(2,1) = Vyp(2,1) *dt+yp(2-1,1);
Vyu(2,1) = Vyid(2,1)+ (Vyid(2,1)-Vyp(2,1))+ (Yid(2,1)-yp(2,1))*dt;
Omp(2,1) = Omid(2,1)+ddOm(2,1)*dt;
psip(2,1) = Omp(2,1) *dt+psip(2-1,1);
Omu(2,1) = Omid(2,1)+ (Omid(2,1)-Omp(2,1))+ (psi_id(2,1)-psip(2,1))*dt;
dt = 0.1; kp = 0.4; ki = 1;
for i =3 :1:length(dVx)
Vxp(i,1) = Vxu(i-1,1)+ddVx(i,1)*dt;
xp(i,1) = Vxp(i,1) *dt+xp(i-1,1);
Vxu(i,1) = Vxid(i,1)+ kp*(Vxid(i,1)-Vxp(i,1))+ (Xid(i,1)-xp(i,1))*ki;
Vyp(i,1) = Vyu(i-1,1)+ddVy(i,1)*dt;
yp(i,1) = Vyp(i,1) *dt+yp(i-1,1);
Vyu(i,1) = Vyid(i,1)+ kp*(Vyid(i,1)-Vyp(i,1))+ (Yid(i,1)-yp(i,1))*ki;
Omp(i,1) = Omu(i-1,1)+ddOm(i,1)*dt;
psip(i,1) = Omp(i,1) *dt+psip(i-1,1);
Omu(i,1) = Omid(i,1)+ kp*(Omid(i,1)-Omp(i,1))+ (psi_id(i,1)-psip(i,1))*ki;
end
dt = 0.1;
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
%���������� ��������
grid on
hold on
plot(x0,y0,'r')
plot(Xid,Yid,'b')
plot(Xp,Yp,'g')
xlabel('X,m');
ylabel('Y,m');
title('�����������');
legend({'�������� ��������� ������ ��������� � ��1','��������� �������������� �������� ���������','�������� ��������� ������ ��������� � ���'},'Location','southwest');
hold off;
