% Author: Gentry Tran
% April 13th, 2012
% Diffusion limited aggregation (dendritic structures)
% Assignment 6,Mod 13.2, project 1

function [xLst, yLst, dist] = RandomWalk(n)
% RANDOMWALK  Function to generate lists of x and y 
% coordinates of n steps for a random walk of n steps
% along with distance between first and last point
rand('state', sum(100*clock))
x0 = 0;
y0 = 0;
x = x0;
y = y0;
xLst = zeros(1, n + 1);
yLst = zeros(1, n + 1);
xLst(1, 1) = x0;
yLst(1, 1) = y0;
for i = 1:n
    if rand < 0.5
        x = x + 1;
    else
        x = x - 1;
    end;
    if rand < 0.5
        y = y + 1;
    else
        y = y - 1;
    end;
    xLst(1, i + 1) = x;
    yLst(1, i + 1) = y;
end;    
dist = sqrt((x - x0)^2 + (y - y0)^2);
endfunction

%---------------DISTANCESRANDOMWALK
function lstDist = distancesRandomWalk(n, numTests)
% RANDOMWALK  Function to return average distance
% between first and last point in random walk of
% n steps, where the simulation is performed
% numTests number of times
lstDist = zeros(1, n);
for i = 1:n
    lstDist(i) = distRandomWalk(i, numTests);
end;    
endfunction

%----------------------------------------------------
% TESTDISTANCES Script to modelRelationship between 
% Number of Steps and Distance Covered
% in a random walk

lstDist = distancesRandomWalk(50, 100);
pl = plot(lstDist, 'o');
pl2 = plot(lstDist.^2, 'o');
hold on
ln = polyfit(1:50, lstDist.^2, 1)
% Above command returns 1.7176   -2.4048
% Thus, the line 1.7176 x - 2.4048 fits the
% transformed data.  The following is the line.
x = 1:50;
lineValues = polyval(ln, x);
pline = plot(x, lineValues);
hold off
pl = plot(lstDist, 'o');
hold on
x = 1:0.1:50;
sqrtLineValues = sqrt(polyval(ln, x));
plot(x, sqrtLineValues);
hold off

function showWalk(xStepLst, yStepLst);
%%% showWalk - visualization of random walk
minX = min(xStepLst);
maxX = max(xStepLst);
minY = min(yStepLst);
maxY = max(yStepLst);
lng = length(xStepLst);
plot(xStepLst, yStepLst, 'ok-', ...
    'MarkerFaceColor', 'b', 'MarkerSize', 12);
hold on;
plot([xStepLst(1), xStepLst(lng)], ...
    [yStepLst(1), yStepLst(lng)], 'or', ...
    'MarkerFaceColor', 'r', 'MarkerSize', 12);
axis([minX maxX minY maxY]);
axis equal;
hold off;  


%-------------------------
function M = animWalk(xStepLst, yStepLst);
%%% showWalk - visualization of random walk
clf;
minX = min(xStepLst);
maxX = max(xStepLst);
minY = min(yStepLst);
maxY = max(yStepLst);
lng = length(xStepLst);
for i = 1:lng
    p = plot(xStepLst(1:i), yStepLst(1:i), 'ok-', ...
        'MarkerFaceColor', 'b', 'MarkerSize', 9);
%    set(gca, 'XTick', minX:maxX);
%    set(gca, 'YTick', minY:maxY);
    axis([minX maxX minY maxY]);
%    axis equal;
    hold on;
    plot([xStepLst(i)], [yStepLst(i)], 'ok', ...
        'MarkerFaceColor', 'k', 'MarkerSize', 12);
    axis([minX maxX minY maxY]);
%    axis equal;
    M(i) = getframe;
    hold off;
end;   
endfunction





%-------------------------
% Initialize grid
% Part A

% Constants
m=16
n=40
g
M=zeros(n/2-m),n/2-m) % Launching rectangle
N=zeros(n,n) % Boundary grid
N(n/2,n/2)= M(m/2,m/2)
w(rand(m),rand(m))

function dla(seed)

if (w=2)
	w=0
	

seed= randi(2)














%-------------------------
% Visualization
% -one step simulation
% -only show particles as a new particle structure
% -color, function of distance
% Part B 
%

function step(time, dla)

function coloring(color,dist)
















%-------------------------
% Simulations
% -vary sticking probability
% -how did it impact structure?
% Part C







%%% Portion to initialize graph
%Now display image
%Sets color map to white (1 1 1) and black ( 0 0 0)
map = [1 1 1;0 0 0];
colormap(map);
%Displays the image, this is customized for Octave
image (grid+1);
axis off;
























