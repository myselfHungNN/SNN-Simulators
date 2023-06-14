%% Prepare workspace enviroment
clear
close all
clc
%% Generate Input data ( can change to other values)
dt = 1e-4; % sampling duration
EL = -0.07;
VT = 0.02;
alpha = 0.1;
Ic = 2.97e-9;
NumberOfNeurons = 10;
NumberOfIterations = 5000;
Iapp = zeros(NumberOfNeurons,NumberOfIterations);

% Generate Iapp(n) for N neurons (constant)
for k = 1:NumberOfNeurons
    Iapp(k,:)= (1+(k-1)*alpha)*Ic; 
end 
clear Ic alpha k

%% Create LIF newron netwwork
V = LIF_model(Iapp,dt,VT,EL);
avg = zeros(NumberOfNeurons,5);
num = zeros(NumberOfNeurons,1);
%% Plot responses of neurons 2, 4, 6, and 8
  plotfigure(dt*1000:dt*1000:500,V(2,:),V(4,:),V(6,:),V(8,:)); 
%% Plot Average Spiking Time with Increasing Current (depending on Ipp)
for k = 1:NumberOfNeurons
    for i = 1:NumberOfIterations
        if(V(k,i)==VT)
            avg(k,1) = avg(k,2);
            avg(k,2) = i;
            avg(k,3) = avg(k,2) - avg(k,1);
            avg(k,4) = avg(k,4) + avg(k,3);
            num(k,1) = num(k,1) + 1;
        end
    end
end

for i = 1:10
    avg(i,5) = avg(i,4)/num(i,1);
end
plotfigure1(avg(:,5));
clear i k num;