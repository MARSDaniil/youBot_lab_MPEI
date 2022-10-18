%из файла полученного от робота вытащим в массив
%и разобьем каждый столбец на переменные
inputDataRob = dlmread('D:\UMRU\lab2\S-12b-19_lab2_brig2_output (1).txt');
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
%откроем файл с данными по идеальным перемещениям
inputDataIdeal = dlmread('D:\UMRU\lab2\perfect_pointUV1 (1).txt');
Xid = inputDataIdeal(:,1);
Yid = inputDataIdeal(:,2);
psi_id = inputDataIdeal(:,3);
%откроем файл с данными по идеальным скоростям
inputDataIdSpeed = dlmread('D:\UMRU\lab2\S-12b-19_lab_2_brig_2.txt');
Vxid = inputDataIdSpeed(:,1);
Vyid = inputDataIdSpeed(:,2);
Omid = inputDataIdSpeed(:,3);
%Найдем рассогласование по координатам
dX = Xid-x0;
dY = Yid -y0;
delPsi = psi_id - psi;
dVx = Vxid - Vx_o;
dVy = Vyid - Vy_o;
ddPsi = Omid - dpsi;
%Получим скоростные интегралы для каждой из итераций скоростей
integraDVxdt(1,1) = dVx(1,1);
for i = 2:1:length(dVx)
integraDVxdt(i,1) = dVx(i,1)+integraDVxdt(i-1,1);
end 
integraDVxdt = integraDVxdt*0.1;
integraDVydt(1,1) = dVy(1,1);
for i = 2:1:length(dVx)
integraDVydt(i,1) = dVy(i,1)+integraDVydt(i-1,1);
end 
integraDVydt = integraDVydt*0.1;
integraDdpsi(1,1) = ddPsi(1,1);
for i = 2:1:length(dVx)
integraDdpsi(i,1) = ddPsi(i,1)+integraDdpsi(i-1,1);
end 
integraDdpsi = integraDdpsi*0.1;
%зададим В - блочную матрицу столбцов свободных членов
B = zeros(length(dVx)*3,1);
k = 1;
for i = 1:3:((length(dVx)*3))
    B(i,1) = dX(k,1)- integraDVxdt(k,1);
    B(i+1,1) = dY(k,1)- integraDVydt(k,1);
    B(i+2,1) = delPsi(k,1)- integraDdpsi(k,1);
    k = k + 1;
end
%зададим А - блочную матрицу коэффициентов
A = zeros(length(dVx)*3,1);
k = 1;
for i = 1:3:((length(dVx)*3))
    A(i,1) = Vxid(k,1);
    A(i+1,1) = Vyid(k,1);
    A(i+2,1) = Omid(k,1);
    k=k+1;
end
%определим время запаздывания 
dtzap = inv(A'*A)*A'*B;
%найдем восстановленные координаты
for i = 1:1:length(dVx)
Xvost(i,1) = x0(i,1)+Vxid(i,1)*dtzap+integraDVxdt(i,1);
end
for i = 1:1:length(dVx)
Yvost(i,1) = y0(i,1)+Vyid(i,1)*dtzap+integraDVydt(i,1);
end
for i = 1:1:length(dVx)
Psivost(i,1) = psi(i,1)+Omid(i,1)*dtzap+integraDdpsi(i,1);
end

hold on;
grid on;
for i = 1:1:length(dVx)
plot(x0,y0,'r');
plot(Xid,Yid,'b');
plot(Xvost,Yvost,'g');
end

xlabel('X,м');
ylabel('Y,м');
title('Движение мекано-платформы youBot');
legend({'Движение платформы снятое датчиками','Идеальное предполагаемое движение плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;
grid off;

%определим СКО и Мат.Ожидание для dX,dY,delPsi

%найдем среднее значение
dXsr = 0; dYsr = 0; delPsisr = 0;
for i = 1:1:200
    dXsr = dXsr + dX(i);
    dYsr = dYsr + dY(i);
    delPsisr = delPsisr + delPsi(i);
end
%dXsr dYsr delPsisr так же будут матОжиданием
dXsr = dXsr/200; dYsr = dYsr/200; delPsisr = delPsisr/200; 

%найдем СКО 
dXsrSumm = 0; dYsrSumm = 0; delPsisrSumm = 0;
for i = 1:1:200
    dXsrSumm = dXsrSumm + (dX(i)-dXsr)^2;
    dYsrSumm = dYsrSumm + (dY(i)-dYsr)^2;
    delPsisrSumm = delPsisrSumm + (delPsi(i)-delPsisr)^2;
end

SKOdX = sqrt(dXsrSumm/199);
SKOdY = sqrt(dYsrSumm/199);
SKOdelPsi = sqrt(delPsisrSumm/199);


%определим СКО и Мат.Ожидание для dX_iv,dY_iv,delPsi_iv
%Найдем массивы dX_iv, dY_iv, delPsi_iv
dX_iv = Xid - Xvost;
dY_iv = Yid - Yvost;
delPsi_iv = psi_id - Psivost;
%найдем среднее значение
dXsr_iv = 0; dYsr_iv = 0; delPsisr_iv = 0;
for i = 1:1:200
    dXsr_iv = dXsr_iv + dX_iv(i);
    dYsr_iv = dYsr_iv + dY_iv(i);
    delPsisr_iv = delPsisr_iv + delPsi_iv(i);
end
%dXsr dYsr delPsisr так же будут матОжиданием
dXsr_iv = dXsr_iv/200; dYsr_iv = dYsr_iv/200; delPsisr_iv = delPsisr_iv/200; 

%найдем СКО 
dXsrSumm_iv = 0; dYsrSumm_iv = 0; delPsisrSumm_iv = 0;
for i = 1:1:200
    dXsrSumm_iv = dXsrSumm_iv + (dX_iv(i)-dXsr_iv)^2;
    dYsrSumm_iv = dYsrSumm_iv + (dY_iv(i)-dYsr_iv)^2;
    delPsisrSumm_iv = delPsisrSumm_iv + (delPsi_iv(i)-delPsisr_iv)^2;
end

SKOdX_iv = sqrt(dXsrSumm_iv/199);
SKOdY_iv = sqrt(dYsrSumm_iv/199);
SKOdelPsi_iv = sqrt(delPsisrSumm_iv/199);

%сравним СКО и МатОжидание, для они должны быть меньше 

abs(SKOdX_iv )< abs(SKOdX)
abs(SKOdY_iv )< abs(SKOdY)
abs(SKOdelPsi_iv) < abs(SKOdelPsi)
abs(dXsr_iv) < abs(dXsr)
abs(dYsr_iv )< abs(dYsr)
abs(delPsisr_iv) < abs(delPsisr)
%построим графики для скоростей,движениям по осям, рассхождениям 
%перемещения
%перемещение Х
f = 1:1:200;
hold on;
grid on;

plot(f,x0,'r');
plot(f,Xid,'b');
plot(f,Xvost,'g');

xlabel('i');
ylabel('X,м');
title('Перемещение по Х');
legend({'Движение платформы снятое датчиками','Идеальное предполагаемое движение плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;
%перемещение Y
hold on;
grid on;

plot(f,y0,'r');
plot(f,Yid,'b');
plot(f,Yvost,'g');

xlabel('i');
ylabel('Y,м');
title('Перемещение по Y');
legend({'Движение платформы снятое датчиками','Идеальное предполагаемое движение плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;
%отклонение по углу поворота
hold on;
grid on;

plot(f,psi,'r');
plot(f,psi_id,'b');
plot(f,Psivost,'g');

xlabel('i');
ylabel('Psi,рад');
title('Изменение по углу поворота');
legend({'Движение платформы снятое датчиками','Идеальное предполагаемое движение плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;

%скорости
%cкорости Х
hold on;
grid on;

plot(f,Vx_o,'r');
plot(f,Vxid,'b');

xlabel('i');
ylabel('Vx,м/c');
title('Скорости по Х');
legend({'Скорость платформы снятая датчиками','Идеальная предполагаемая скорость плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;
%скорость по оси Y 
hold on;
grid on;

plot(f,Vy_o,'r');
plot(f,Vyid,'b');

xlabel('i');
ylabel('Vy,м/c');
title('Скорости по Y');
legend({'Скорость платформы снятая датчиками','Идеальная предполагаемая скорость плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;
%угловая скорость 
hold on;
grid on;

plot(f,dpsi,'r');
plot(f,Omid,'b');

xlabel('i');
ylabel('Om,рад/c');
title('Угловая скорость');
legend({'Скорость платформы снятая датчиками','Идеальная предполагаемая скорость плафтормы','Восстановленное движение платформы'},'Location','southwest');

hold off;