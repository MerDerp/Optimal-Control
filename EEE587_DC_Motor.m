clc; close all
%parameter value
R = [0.5,1,3]; %Electric Resistance
L = 0.5; %Electric Inductance
Ke = 0.01; %Electromotive Force Constant
Km = 0.01; %Torque-current ratio
J = 0.01; %Moment of Inertia of the Rotor
Kd = 0.1; %Damping Ratio of the Inertia of the Rotor
%motor system SS
%state: x = [i w]T , angular velocity and current
%control: voltage v
%output: y = w
A1 = [-R(1)/L -Ke/L; Km/J -Kd/J]; %Different A for Each Resistance
A2 = [-R(2)/L -Ke/L; Km/J -Kd/J];
A3 = [-R(3)/L -Ke/L; Km/J -Kd/J];
B = [1/L ; 0];
C = [0 1];  %for angular velocity output
C1 = [1 0]; %for current ouput
D = 0;
sys_ss1 = ss(A1,B,C,D); %statespace of each A and C matrices
sys_ss2 = ss(A2,B,C,D);
sys_ss3 = ss(A3,B,C,D);
sys_c1 = ss(A1,B,C1,D);
sys_c2 = ss(A2,B,C1,D);
sys_c3 = ss(A3,B,C1,D);

%plot angular velocity
figure
hold on
step(sys_ss1,5)
step(sys_ss2,5)
step(sys_ss3,5)
hold off
legend('0.5','1','3','Location','best')
xlabel('time','FontWeight','bold')
ylabel('Speed rad/s','FontWeight','bold')
title(['Motor Angular Velocity ' ...
    'System Response at Different Resistance'])
%plot current
figure
hold on
step(sys_c1,5)
step(sys_c2,5)
step(sys_c3,5)
legend('0.5','1','3','Location','best')
xlabel('time','FontWeight','bold')
ylabel('Speed rad/s','FontWeight','bold')
title('Current System Response at Different Resistance')
hold off

%plot different step inputs
opts = stepDataOptions('StepAmplitude',2); %amplitude of 2

%create plots for current
figure
subplot(1,2,1)
hold on
step(sys_c1,5,opts)
step(sys_c2,5,opts)
step(sys_c3,5,opts)
hold off
legend('0.5','1','3','Location','best')
xlabel('time','FontWeight','bold')
ylabel('Speed rad/s','FontWeight','bold')
title('Current System Response With Step Input Magnitude of 2')
subplot(1,2,2)
hold on
step(sys_c1,5)
step(sys_c2,5)
step(sys_c3,5)
legend('0.5','1','3','Location','best')
xlabel('time','FontWeight','bold')
ylabel('Speed rad/s','FontWeight','bold')
title('Current System Response With Step Input Magnitude of 1')

%create plots for angular velocity
figure
subplot(1,2,1)
hold on
step(sys_ss1,5,opts)
step(sys_ss2,5,opts)
step(sys_ss3,5,opts)
hold off
legend('0.5','1','3','Location','best')
xlabel('time','FontWeight','bold')
ylabel('Speed rad/s','FontWeight','bold')
title('Angular Velocity Response With Step Input Magnitude of 2')
subplot(1,2,2)
hold on
step(sys_ss1,5)
step(sys_ss2,5)
step(sys_ss3,5)
legend('0.5','1','3','Location','best')
xlabel('time','FontWeight','bold')
ylabel('Speed rad/s','FontWeight','bold')
title('Angular Velocity Response With Step Input Magnitude of 1')
