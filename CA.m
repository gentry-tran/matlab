% 1 dimensional cellular automaton simulation with adjustable rule
clear all;
setenv('GNUTERM','X11');

% constants
rows = 100; % generations to simulate
cols = 2*rows; % width of the automaton
rule = 86; % rules of the automaton

% initialize variables
rc = 1; % row counter
matrix = zeros(1,cols); % output matrix
matrix(round(cols/2)) = 1;

% compute all generations
while rc != rows
	lastrow = matrix(rc,:); % the state of the current generation
	newrow = zeros(1,cols);
	for i = 2:cols-1	% set new row equal to a bit of the rule given the state of its neighbourhood in the current generation
		newrow(i) = bitand(bitshift(rule, -(4*lastrow(i-1)+2*lastrow(i)+lastrow(i+1))), 1);
	endfor
	matrix = [matrix; newrow];	% add newly computed generation to the output
	rc = rc + 1;	% increment row counter
endwhile

% map numbers to colors
map = [1,1,1;0,0,0];
colormap(map);

% display output
image(matrix+1);
axis equal;
axis off;
