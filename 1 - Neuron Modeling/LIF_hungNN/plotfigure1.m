function plotfigure1(Y1)
%plotFIGURE1(Y1)
%  Y1:  vector of y data

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[20 50]);
box(axes1,'on');
hold(axes1,'all');

% Create plot
plot(Y1);

% Create title
title('Average Spiking Time with Increasing Current');

% Create xlabel
xlabel('Neuron Number (k)');

% Create ylabel
ylabel('Average Time (ms)');

