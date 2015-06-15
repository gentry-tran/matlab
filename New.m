% Author: Gentry Tran
% April 5th, 2012
% Cellular Automata, Rule 150
% Assignment 5, part 2

% Initializing Values
k= 60; % # of Rows
n= 50; % # of Columns
m= zeroes (k,n); % Initializing matrix
m(1, n/2) = 1;




%%% Portion to initialize graph
%Now display image
%Sets color map to white (1 1 1) and black ( 0 0 0)
map = [1 1 1;
	0 0 0];
colormap(map);
%Displays the image, this is customized for Octave
image (grid+1);
axis off;


///////////
testfire.m

% grids = fire(n, probTree, probBurning, chanceLightning, chanceImmune, t);
% n = 50, probTree = 0.8, probBurning = 0.001, probLightning = 0.0001, probImmune = 0.3, and t = 50
rand('state', 1*clock);
close all;
grids = fire(15, 0.8, 0.001, 0.001, 0.3, 20);
showGraphs(grids);

///////////////
spread.m

function newSite = spread(site, N, E, S, W); 
% SPREAD - Function to return the value of a site
% at the next time step
% An empty cell remains empty.
% A burning cell becomes empty.
% If a neighbor to the north, east, south, or west of 
% a tree is burning, then the tree does not burn with a
% probability of probImmune.
% If a tree has no burning neighbors, it is hit by lightning
% and burns with a probability of probLightning * (1 - probImmune).
%
global EMPTY TREE BURNING probLightning probImmune 

% EMPTY = 0; TREE = 1; BURNING = 2;
if site == EMPTY
    newSite = EMPTY;
elseif site == BURNING
    newSite = EMPTY;
else
    if (N==BURNING | E==BURNING | S==BURNING | W==BURNING)
        if (rand < probImmune)
            newSite = TREE;
        else
            newSite = BURNING;
        end;
    elseif (rand < probLightning * (1 - probImmune))
        newSite = BURNING;
    else
        newSite = TREE;
    end;
end;




/////////////
fire.m

function grids = fire(n, probTree, probBurning, chanceLightning, chanceImmune, t);
% Fire simulation
global EMPTY TREE BURNING probLightning probImmune 
EMPTY = 0; TREE = 1; BURNING = 2;
probLightning = chanceLightning;
probImmune = chanceImmune;
%%% initialize forest
% 1 where tree or burning tree
treesOrBurns = (rand(n) < probTree);
% 1 where burning tree
burns = treesOrBurns .* (rand(n) < probBurning);
% 1 where non-burning tree
trees = treesOrBurns - burns;
% 1 where empty
empties = 1 - treesOrBurns;
% EMPTY, TREE, or BURNING
forest =  empties * EMPTY + trees * TREE + burns * BURNING;
%%%
grids = zeros(n, n, t + 1);
grids(:, :, 1) = forest;
for i = 2:(t + 1)
    forestExtended = extendLat1(forest);
    forest = applyExtended(forestExtended);
    grids(:, :, i) = forest;
end;
endfunction















///////////
showGraphs

function showGraphs(graphList);
% SHOWGRAPHS - Function to return movie visualization MODIFIED BY RAMA MARCH 17, 2010
%gnu octave does not have GETFRAME COMMAND, must use subplot() to plot multiple graphs on same screen
% Grids generated in graphList
%Note that grids (actually arrays) have to be displayed using image command,which also
%maps values to colors
map = [1 1 0;        % EMPTY   -&gt; yellow
    0.1 0.75 0.2;    % TREE    -&gt; forest green
    0.6 0.2 0.1];    % BURNING -&gt; burnt orange
colormap(map);
m = size(graphList, 3); %number of graphs
q=ceil(m/5); %Need this to figure out how many rows of graphs, cols fixed at 5 (reasonable size)
%disp([num2str(q),num2str(m)]); %used this for debug

for k = 1:m
    g = graphList(:, :,m+1-k); %assign g to a matrix for the fire display at t=k.
    subplot(q,5,m+1-k); %Use subplot command to set up multiple graph page
   image(g+1); %MUst add 1 to numbers since otherwise they are not in colormap domain
   axis off;  %Images must not have axes
endfor;
