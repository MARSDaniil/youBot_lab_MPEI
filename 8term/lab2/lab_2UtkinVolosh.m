inputDataRob = dlmread('D:\UMRU\8term\lab2\Lr2_Voloshin_Utkin_out_2.txt');
%enter the initial parameters taken from the robot 
%and make their transition to the angle ?
%do not use A1 and A5 because they do not change

A2 = inputDataRob(:,2);
A3 = inputDataRob(:,3);
A4 = inputDataRob(:,4);
f1 = A2;
f2 = A2 - 1.1345;
f3 = A3+2.5654;
f4 = A4 -1.8290;
dT = 0.05;

%set default setting
l1 = 0.07;
l2 = 0.155; 
l3 =0.135; 
l45 = 0.2176; 
d1 = 0.033;
thetha = -1;
%create Time arrow
T(1)  = 0;
for i = 2:1:length(f2)
    T(i) = T(i-1) + dT; 
end 

%and add lenght(f1) - becouse we use this lenght at last lab
f1 = A2;
length(f1);
%set start and finish coordinats 

x1As = 0.3;
x1Af = 0.1;
z1As = 0.45;
z1Af = 0.45;

%create step for coordinats arrow
dx = 2*(x1Af- x1As)/length(f1);
dz = 2*(z1Af- z1As)/length(f1);

X(1) = x1As;
Z(1) = z1As;

%create arrow for coordinats
for i = 2:1:(length(f1))
    if(i < (length(f1)/2+1))
        X(i) = X(i-1)+dx;
        Z(i) = Z(i-1)+dz;
    else
        X(i) = X(i-1) - dx;
        Z(i) = Z(i-1) - dz;
    end
end

%create arror for angles 
%plus acos
for i = 1:1:length(f1)
xv = X(i) - d1 - l45*cos(thetha);
zv = Z(i) - l1 + l45*sin(thetha);
phi3p(i) = acos((xv^2+zv^2-l2^2-l3^2)/(2*l2*l3));
phi2p(i) = atan2(l2+l3*cos(phi3p(i)),l3*sin(phi3p(i)));
phi2p(i) = atan2((l2+l3*cos(phi3p(i))),(l3*sin(phi3p(i))))-atan2(zv,xv);
phi4p(i) = thetha -phi2p(i)-phi3p(i)+pi/2;
end 
%minus acos
for i = 1:1:length(f1)
xv = X(i) - d1 - l45*cos(thetha);
zv = Z(i) - l1 + l45*sin(thetha);
phi3m(i) = -acos((xv^2+zv^2-l2^2-l3^2)/(2*l2*l3));
phi2m(i) = atan2(l2+l3*cos(phi3m(i)),l3*sin(phi3m(i)))-atan2(zv,xv);
phi4m(i) = thetha -phi2m(i)-phi3m(i)+pi/2;
end 

%restrictions for rotation angles

for i = 1:1:length(f1)
    g2u(i) = 2.62 - 1.13;
    g2l(i) = 0.01 - 1.13;
    g3u(i) = -0.01 + 2.56;
    g3l(i) = -4.8 + 2.56;
    g4u(i) = 3.43 - 1.8;
    g4l(i) = 0.022 - 1.8;
end



figure;
hold on;
grid on;
plot(T,phi2p);
%plot(T,phi2m);
plot(T,f2);
plot(T,g2u);
plot(T,g2l);
xlabel('time,sec');
ylabel('phi2,rad');
legend({'Ideal phi','Real phi','upper line','bottom line'},'Location','southwest')
hold off;

figure;
hold on;
grid on;
plot(T,phi3p);
%plot(T,phi3m);
plot(T,f3);
plot(T,g3u);
plot(T,g3l);
xlabel('time,sec');
ylabel('phi3,rad');
legend({'Ideal phi','Real phi','upper line','bottom line'},'Location','southwest')
hold off;


figure;
hold on;
grid on;
plot(T,phi4p);
%plot(T,phi4m);
plot(T,f4);
plot(T,g4u);
plot(T,g4l);
xlabel('time,sec');
ylabel('phi4,rad');
legend({'Ideal phi','Real phi','upper line','bottom line'},'Location','southwest')
hold off;
