function V = LIF_model (Iapp, dt, VT, EL)
% INPUT
% Iapp - is an array of size (number of neurons)x(number of timesteps)
% dt -  is the value of the timestep
% VT -  is the threshold voltage for spiking
% EL - is the resting memebrane potential
% OUTPUT
% V - membrance potential
    
    % Prepare output variables
    V = zeros(size(Iapp));
    V(:,1) = EL;
    
    % Number of neurons (N),
    N = size(Iapp,1);
    % Number of iterations (M)
    M = size(Iapp,2);
    RK2nd_type = 'HEUN';
      
    % Perform simulation
    for i = 2:M
        % Determine V(n+1) from V(n) using 2nd order Runge-Kutta
        
        V(:,i) = RK2nd(V(:,i-1), dt, Iapp(:,i-1), Iapp(:,i), RK2nd_type);
        % Check for neurons that spiked in the previous iteration. V(t)->EL
        for j = 1:N
            if(V(j,i-1)==VT)
                V(j,i)=EL;
            end
        end
        % Check for neurons that have crossed threshold. V(t)->spike
        for j = 1:N
            if(V(j,i) >= VT)
                V(j,i)=VT;
            end
        end 
    end
    
    % Plot responses of neurons 2, 4, 6, and 8
    % plotfigure(dt*1000:dt*1000:500,V(2,:),V(4,:),V(6,:),V(8,:));    
end
%% Getting V(n+1) from V(n) and I(n): the Runge-Kutta iterations
function Vn1 = RK2nd(Vn, dt, I1, I2, type)
% Runge-Kutta second order method
        % Heun's Method, aka a2 = 1/2 ( selected)
        % midpoint Method aka a2 = 1
        % Ralson Method aka a2 = 2/3
    switch(type)
        case 'HEUN'
            Vn_1 = zeros(size(Vn)); %Intermediate value, used to calculate k2   
            Vn_1 = Vn + (f(Vn,I1))*dt; %Get intermediate value using k1
            Vn1 =Vn + (((f(Vn_1,I2))+(f(Vn,I1)))/2)*dt; %V(n+1) from k1 and k2
        otherwise
    end
end
%% The 'f' from the differential equation x' = f(x,t)
function value = f(V,I)
    C = 300e-12;% = 300pF
    gL = 30e-12; % = 30nS
    vT = 20e-3;  % = 20mV
    EL = -70e-3;  % 70mV
    value = (I - gL*(V - EL))/(C);
end