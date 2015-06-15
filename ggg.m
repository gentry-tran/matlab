% Author: Gentry Tran
% April 13th, 2012
% Diffusion limited aggregation (dendritic structures)
% Assignment 6,Mod 13.2, project 1

% Function for launching rectangle
% Random probability for particle to release at boundary of m x m matrix

function [x,y] = launch_pos(m, n)
	r = randi(4*m);
	if r <= m
		x = round((n-m)/2);
		y = round((n-m)/2) + r;
		return;
	endif
	r = r - m;
	if r <= m
		x = round((n-m)/2) + r;
		y = round((n-m)/2) + m;
		return;
	endif
	r = r - m;
	if r <= m
		x = round((n-m)/2) + m;
		y = round((n-m)/2) + m - r;
		return;
	endif
	r = r - m;
	x = round((n-m)/2) + m - r;
	y = round((n-m)/2);	
endfunction

%-------------------------
% Initialize grid
% Part A
% Simulations
% Set parameters mainsteps, and everystep to false to see fast output

% Part B 
% Visualization
% First, set first boolean mainstep, and everystep to be true to see each 
% output for the resulting grid
% Second,set function to be a function of distance

% Visualization to map color as a function of distance
function color_cr(m, cr)
	n = length(cr);
	map = zeros(22,3);
	for i = 1:21
		map(i,1) = sqrt((i-1)*(1/20));
		map(i,2) = sqrt((i-1)*(1/20));
		map(i,3) = sqrt((i-1)*(1/20));
	endfor
	% Maps out different colors
	map(22,1) = 1;
	map(22,2) = 1;
	map(22,3) = 1;
	colormap(map);
	for i = 1:n;
		for j = 1:n;
			if cr(i,j) == 1
				% Pythagorean theorem here to calculated distance
				dist = sqrt( ( (i - round(n/2))^2 + (j - round(n/2))^2 ) );
				cr(i,j) = round( 20 * ( dist / ceil( (sqrt(2)*(m+1) ) ) ) );
			else
				cr(i,j) = 22;
			endif
		endfor
	endfor
	image(cr + 1);
	axis equal;
endfunction

% Part C
% -vary sticking probability
% -how did it impact structure?


% Main function

function cr = simulate(m, n, sprob, mainsteps, everystep)

	% Now display image
	% Sets color map to white (1 1 1) and black ( 0 0 0)
	move = [1,0; -1,0; 0,1; 0,-1]; % 1/4 possible movements
	map = [1,1,1; 0,0,0];
	colormap(map);
	
	cr = zeros(n,n);
	cr(round(n/2),round(n/2)) = 1; % Initial seed, center of n x n matrix
	its_over = false;
	
	% Loops until the strucutre reaches the outside of the m x m matrix,
	% which prevents the grid from seeding on top of dendritic structure

	while !its_over

		[wx, wy] = launch_pos(m, n);
		done = false;

		while !done
			
			for j = 1:4
				if cr(wx+move(j,1),wy+move(j,2)) == 1
					if rand < sprob
						done = true;
					endif
				endif
			endfor
			if done
				if wx == round((n-m)/2) || wy == round((n-m)/2) || wx == round((n-m)/2) + m || wy == round((n-m)/2) + m
					its_over = true;
				endif
				break;
			endif
			
			d = randi(4);
			cr(wx,wy) = 0;
			wx = wx + move(d,1);
			wy = wy + move(d,2);
			if wx == 1 || wy == 1 || wx == n || wy == n
				done = true;
			else
				cr(wx,wy) = 1;
			endif

			if everystep
				image(cr+1);
				axis off;
				pause(0.0001);
			endif

		endwhile

		if mainsteps
			image(cr+1);
			axis off;
			pause(0.05);
		endif
		
	endwhile
	
endfunction
