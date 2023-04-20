inputDataRob = dlmread('D:\UMRU\8term\lab2\Lr2_Voloshin_Utkin_out_2.txt');
%enter the initial parameters taken from the robot 
%and make their transition to the angle ?

    % first paragraph
    % 
    %Statement of the problem as a given trajectory
    %
    %
    %


A2 = inputDataRob(:,2);
A3 = inputDataRob(:,3);
A4 = inputDataRob(:,4);
f1 = A2;
f2 = A2 - 1.1345;
f3 = A3+2.5654;
f4 = A4 -1.8290;
dT = 0.05;

A2 = A2';
A3 = A3';
A4 = A4';
f2 = f2';
f3 = f3';
f4 = f4';

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
%set start(s) and finish(f) coordinats 

x1As = 0.3;
x1Af = 0.1;
z1As = 0.45;
z1Af = 0.45;

    % second paragraph
    % 
    %derive an analytical solution connecting the direct
    %
    %problem of geometry and the inverse
    %





    % third paragraph
    % 
    %build graphs of angle changes
    %and justify the choice of a set of angles.
    %
    %

%do not use A1 and A5 because they do not change


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
%plus(phi_i_p) acos
for i = 1:1:length(f1)
xv = X(i) - d1 - l45*cos(thetha);
zv = Z(i) - l1 + l45*sin(thetha);
phi3p(i) = acos((xv^2+zv^2-l2^2-l3^2)/(2*l2*l3));
phi2p(i) = atan2(l2+l3*cos(phi3p(i)),l3*sin(phi3p(i)));
phi2p(i) = atan2((l2+l3*cos(phi3p(i))),(l3*sin(phi3p(i))))-atan2(zv,xv);
phi4p(i) = thetha -phi2p(i)-phi3p(i)+pi/2;
end 
%minus(phi_i_m) acos
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


%create plots of angles
figure;
hold on;
grid on;
plot(T,phi2p);
plot(T,phi2m);
plot(T,f2);
plot(T,g2u);
plot(T,g2l);
xlabel('time,sec');
ylabel('phi2,rad');
legend({'Ideal phi, plus acos','Ideal phi, minus acos','Real phi','upper line','bottom line'},'Location','southwest')
hold off;

figure;
hold on;
grid on;
plot(T,phi3p);
plot(T,phi3m);
plot(T,f3);
plot(T,g3u);
plot(T,g3l);
xlabel('time,sec');
ylabel('phi3,rad');
legend({'Ideal phi, plus acos','Ideal phi, minus acos','Real phi','upper line','bottom line'},'Location','southwest')
hold off;


figure;
hold on;
grid on;
plot(T,phi4p);
plot(T,phi4m);
plot(T,f4);
plot(T,g4u);
plot(T,g4l);
xlabel('time,sec');
ylabel('phi4,rad');
legend({'Ideal phi, plus acos','Ideal phi, minus acos','Real phi','upper line','bottom line'},'Location','southwest')
hold off;

%plots of real angulars:

figure;
hold on;
grid on;
plot(T,f2);
xlabel('time,sec');
ylabel('f2,rad');

figure;
hold on;
grid on;
plot(T,f3);
xlabel('time,sec');
ylabel('f3,rad');

figure;
hold on;
grid on;
plot(T,f4);
xlabel('time,sec');
ylabel('f4,rad');

    %fourth paragraph
    %construct the resulting motion trajectory
    %
    %
    %and compare it with the ideal trajectory.
    %
    %
    %
%create real translation

xAReal = d1 + l2*sin(f2)+l3*sin(f2 + f3) + l45*sin(f2+f3+f4);
zAReal = l1 + l2*cos(f2)+l3*cos(f2 + f3) + l45*cos(f2+f3+f4);
thethaReal = f2 + f3 + f4 - pi/2;


for i = 1:1:length(f1)
    yAReal(i) = 0;
end

%2D plot of translation
figure;
hold on;
grid on;
plot(X,Z)
plot(xAReal,zAReal)
xlabel('x,m');
ylabel('z,m');

%3D plot of translation

figure;
hold on;
grid on;
plot3(xAReal,yAReal,zAReal)
plot3(X,yAReal,Z)
xlabel('x,m');
ylabel('y,m');
zlabel('z,m');

    %fifth paragraph
    %motion error parameters
    %
    %
    %(look last term)
    %

%introduce errors between real and ideal coordinates

deltaX = xAReal - X;
deltaZ = zAReal- Z;
deltaThetta = thethaReal-thetha;

%plot deltaX
figure;
hold on;
grid on;
plot(T,deltaX)
xlabel('time, sec');
ylabel('delta xA,m');

%plot deltaZ
figure;
hold on;
grid on;
plot(T,deltaZ)
xlabel('time, sec');
ylabel('delta zA,m');

%plot deltaThettha
figure;
hold on;
grid on;
plot(T,deltaThetta)
xlabel('time, sec');
ylabel('delta thetta,rad');


% find Standard deviation(SKO) and Expected value(X/Z_sr)

%find the average value
dXsr = 0; dZsr = 0; dThettha = 0;
for i = 1:1:length(f1)
    dXsr = dXsr + deltaX(i);
    dZsr = dZsr + deltaZ(i);
    dThettha = dThettha + deltaThetta(i);
end
%dXsr dYsr delPsisr are also expected value
dXsr = dXsr/length(f1)
dZsr = dZsr/length(f1)
dThettha = dThettha/length(f1)

%found standard deviation(SKO)
dXsrSumm = 0; dZsrSumm = 0; delThetthaSumm = 0;
for i = 1:1:length(f1)
    dXsrSumm = dXsrSumm + (deltaX(i)-dXsr)^2;
    dZsrSumm = dZsrSumm + (deltaZ(i)-dZsr)^2;
    delThetthaSumm = delThetthaSumm + (deltaThetta(i)-dThettha)^2;
end

SKOdX = sqrt(dXsrSumm/(length(f1)-1))
SKOdZ = sqrt(dZsrSumm/(length(f1)-1))
SKOdelPsi = sqrt(delThetthaSumm/(length(f1)-1))

for i = 1:1:length(f1)
   thetha(i) = -1;
end

%mismatch in the angles of real and ideal


variables1 = {'fi3Ideal, fi4Ideal, fi5Ideal, xIdeal,  zIdeal '};
data1 = [phi2p' phi3p' phi4p' X' Z'];
sw1 = ['' sprintf('%s', variables1{:}) sprintf('\n')];
sw1 = [sw1 sprintf('%.5f %.5f %.5f %.5f  %.5f\n', data1')];
fid1 = fopen('IdealData.txt', 'wt');
fprintf(fid1, '%s', sw1);
fclose(fid1);
type('IdealData.txt');


deltaf2 = phi2p - f2;
deltaf3 = phi3p - f3;
deltaf4 = phi4p - f4;

variables2 = {'deltaX  ,  deltaZ, deltaf2, deltaf3, deltaf4'};
data2 = [deltaX' deltaZ' deltaf2' deltaf3' deltaf4' ];
sw2 = ['' sprintf('%s', variables2{:}) sprintf('\n')];
sw2 = [sw2 sprintf('%.5f %.5f %.5f %.5f  %.5f\n', data2')];
fid2 = fopen('dataFrom2To4.txt', 'wt');
fprintf(fid2, '%s', sw2);
fclose(fid2);
type('dataFrom2To4.txt');

