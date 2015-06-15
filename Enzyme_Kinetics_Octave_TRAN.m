% Gentry Tran
% Program Written on 3/25/12
% Enzyme Kinetics Model for [ES] Concentration LSODE solver

Close all;

setenv("GNUTERM", "x11"); % Allows for plotting function to work for mac

% string that names the function to call to compute the
% vector of right hand sides for the set of equations

function xdot = f (x,t); %x is a vector, and t is a scalar

xdot= zeros(4,1); %Initialize vector for 1 differential equation

%Initialize Rate Constants Values
	
K1= 1; % units defined as: 1/(mmoles*seconds)
K2=.3; % units defined as: 1/(seconds)
K3= 1; % units defined as: 1/(seconds)
K4=.3; % units defined as: 1/(mmoles*seconds)

% The differential equation of the form
% d[ES]/dt = K1[E][S] - K2[ES] - K3[ES] + K4[P][E]

% Values in coupled equations
% x(1)= Enzyme, x(2)= Substrate, x(3)= ES Complex, x(4)= Product

% d[E]/dt = K2[ES] + K3[ES] - K1[P][E] - K4[E][S]
xdot(1)= (K2*x(3)) + (K3*x(3)) - (K1*x(1)*x(2)) - (K4*x(4)*x(1));

% d[S]/dt = K2[ES] - K1[P][E]
xdot(2)= (K2*x(3)) - (K1*x(1)*x(2));

% d[ES]/dt = K1[E][S] - K2[ES] - K3[ES] + K4[P][E]
xdot(3)= (K1*x(1)*x(2)) - (K2*x(3)) - (K3*x(3)) + (K4*x(4)*x(1));

% d[P]/dt = K3[ES] - K4[P][E]
xdot(4)= (K3*x(3)) - (K4*x(4)*x(1));

endfunction

%function is now defined

%Initialize values for concentration values in mmoles

Enzyme = .2;
Substrate = 1;
ESComplex = 0;
Product = 0;

x0 = [Enzyme; Substrate; ESComplex; Product]; %Initial concentrations in matrix form

t= linspace (0,30,240); % Time boundary conditions

y= lsode ("f", x0, t); % Calls function LSODE differential equation solver

% Plotting time evolution of concentrations below

plot(t,y(:,1),'r',"markersize",1); % column vector 1 - Enzyme
hold on;

plot(t,y(:,2),'b',"markersize",1); % column vector 2 - Substrate
hold on;

plot(t,y(:,3),'g',"markersize",1); % column vector 3 - ES Complex
hold on;

plot(t,y(:,4),'p',"markersize",1); % column vector 4 - Product
hold on;

xlabel("Time (Seconds)");
ylabel("Concentrations (mmols), [E]-red, [S]-blue, [ES]-green, [P]-purple");

print(/users/gentrytran/desktop/fig1.png","-dpng"); % Saves image to desktop for Mac
