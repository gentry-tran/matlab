% Author: Gentry Tran
% April 24th, 2012
% Lattice-Gas Cellular Automata Models (LGCA)
% HHP/FHP Model simulations
% Final Project

% PowerPoint Presentation (30 points) on Tuesday, May 1.
% Final Project Report (25 points) on Wednesday, May 2 with
% zipped files of code, printed copy of 6 page project report
% "HELP" text file, print, and zipped

% hpp.m file summary
% This file is a simulation that runs the Hardy, Pomeau, de Pazzis model for 
% Lattice Boltzmann methods of fluid dynamics. The main function is 
% simulate(timesteps,n,p), where it calls several smaller functions to start.
% The first function that is called is init(n,p), where it creats an [n x n x 4]
% matrix, where p is the distribution of particles over the entire grid based on
% random probability with random direction. Then, the particles begin to propagate
% called from the function propagation, which assigns new boolean values to cells
% based on the previous direction and turns around if at boundary
% unless there is a collision. When a collision occurs, the function collision 
% is called which is when two cells are diagonal from each other and are rotated
% 90 degrees of original motion for both particles. The last function called
% is the display function, which maps out each particle in the entire matrix 
% to a new matrix which has a four lattice structure from the 4-components
% in the Kth dimension depending on the direction.

setenv("GNUTERM", "x11");

global collisionvalues;
global pressurevalues;

collisionvalues = 0; % Keep track of collisions with PARTICLES ONLY, be able to access them from multiple sites
pressurevalues = 0; % Keep track of collisions BOUNDARIES ONLY, be able to access them from multiple sites


% 1st function called to initialize particles in matrix. Parameters that should 
% be given are n, which are dimensions of (i,j) portion of matrix multiplied by
% a height of 4 for values to store directional movement. p is the 
function Grid = init(n,p) 

Grid = zeros(n,n,4);	% Create a zeros-matrix based on user input n parameter 

for i= 1:n
	
	for j= 1:n
		
		for k= 1:4	% Nested loops to go through every cell in matrix
			
			
			 % If Statement: Since rand values are [0,1], given parameter p
						   % sets a distribution to partially populate matrix
						   % p should be <<1 because all cells would be filled at 
						   % p == 1, and the rest of cells are set empty
			if rand < p
						  
				Grid(i,j,k) = 1;
				
			else
				
				Grid(i,j,k) = 0;
				
			endif
			
		endfor
		
	endfor
	
endfor

endfunction



% This function is called propagation is the movement of the particles in the matrix,
% which is called 2nd, after function collide in the loop from the main program to move the particles.
% Uses the given stored value from the initialized grid above to move the particles
% based on a stored value in the Kth component. For cells in K(1) component set to 
% one moves particle down, when K(2) is 1, then it moves upward,...etc. (defined below)

function Newgrid = propagation(Oldgrid) % Uses oldgrid output from previous function as parameter

global pressurevalues; % Keep track of collisions with boundaries, be able to access them from multiple sites

	n = length(Oldgrid(:,1,1));	% Initializes n value based on previous (could
											% have used a global to pass value)
	
	Newgrid = zeros(n,n,4);	% A new matrix to store new values in, based on previous matrix
									% Computing a movement from an blueprint of previous step 
	
	for i= 1:n
	
		for j= 1:n	% Loops for all particles in [n x n] matrix, and depending on 
						% the Kth() component, the cell value of 1 location within 
						% 1,2,3, or 4th component will tell the direction of movement
					
				if Oldgrid(i,j,1) == 1 % Checks if 1st component is occupied with particle (i.e == 1)
											
						% Stores all new values in output matrix, "Newgrid"
					
						if i < n
						
							Newgrid(i+1,j,1) = 1; % Particle continues downward, unless it 
														 % it reaches the boundary line of n because
													 	 % that is the lengtch of matrix
				 	
					 	else 
				 	
					 		Newgrid(i,j,2) = 1; % Changes upward (direction only), but no movement
					 								  % the cell that ==1 has the value shifted into 
					 							     % the Kth(2) component, which is opposite (up) direction
					 							  
					 		pressurevalues = pressurevalues + 1; % counters to measure contact with boundary
					 		
					 	endif
				 	
				endif
						
				if Oldgrid(i,j,2) == 1
					
						if i == 1
						
							Newgrid(i,j,1) = 1; % Change downward  (direction only), but no movement
					 								  % the cell that ==1 has the value shifted into 
					 							     % the Kth(2) component, which is opposite (up) direction
					 							  
							pressurevalues = pressurevalues + 1;  % counters to measure contact with boundary
							
					 	else
				 	
					 		Newgrid(i-1,j,2) = 1; % Continues upward, unless it 
														 % it reaches the boundary line of n because
													 	 % that is the lengtch of matrix
					 		
					 	endif
					
				endif
					
				if Oldgrid(i,j,3) == 1
					
						if j < n
						
							Newgrid(i,j+1,3) = 1; % Continuing right, unless it 
														 % it reaches the boundary line of n because
													 	 % that is the lengtch of matrix
				 	
						else
				 	
							Newgrid(i,j,4) = 1; % Change left (direction only), but no movement
					 								  % the cell that ==1 has the value shifted into 
					 							     % the Kth(2) component, which is opposite (up) direction
							
							pressurevalues = pressurevalues + 1;  % counters to measure contact with boundary
							
						endif
					
				endif
					
				if Oldgrid(i,j,4) == 1
					
						if j == 1
					
							Newgrid(i,j,3) = 1; % (direction only), but no movement
					 								  % the cell that ==1 has the value shifted into 
					 							     % the Kth(2) component, which is opposite (up) direction
							
							pressurevalues = pressurevalues + 1;  % counters to measure contact with boundary
							
						else
				 	
							Newgrid(i,j-1,4) = 1; % Continuing left, unless it 
														 % it reaches the boundary line of n because
													 	 % that is the lengtch of matrix
				 	
						endif
			
				endif
					
		endfor
	
	endfor
	
endfunction





% This function defines what happens when a particle in a square lattice meets
% with another particle diagonally. The two configurations are that when these
% particles are diagonal from eachother, the directions get inverted for both
% particles, essentially rotating 90 from original propagation direction. This
% is called by the main program 1st in the loop to check and see if any particles
% are located diagonal from each other.

function Newgrid = collide(Oldgrid) % Outputs a computed grid, based on diagonal
												% local neighboring cells in the matrix

global collisionvalues

Newgrid = Oldgrid; % Sets old matrix equal to new matrix to compute new positions
						 % based on previous locations in matrix

n = length(Oldgrid(:,1,1)); % Uses original length of matrix for looping parameters 

for i= 1:n

	for j= 1:n % Loop through all particles in matrix
		
		
		
		% Depending on the Kth component of these particles (The directions stored
		% in the any of the 4 components of K. When direction values are diagonal
		% which is either 1 & 2, or 3 & 4, we rotate them, which means setting the
		% other two components of K that are empty to 1, and the ones that are full
		% to 0.
	
		if Oldgrid(i,j,1) == 1  &&  Oldgrid(i,j,2) == 1 &&  Oldgrid(i,j,3) == 0 &&  Oldgrid(i,j,4) == 0 
			
			Newgrid(i,j,1) = 0;
			Newgrid(i,j,2) = 0;
			Newgrid(i,j,3) = 1;
			Newgrid(i,j,4) = 1;
			
			collisionvalues = collisionvalues + 1; % Keep track of collisions with PARTICLES ONLY
			
		endif
		
		if Oldgrid(i,j,1) == 0  &&  Oldgrid(i,j,2) == 0 &&  Oldgrid(i,j,3) == 1 &&  Oldgrid(i,j,4) == 1 
			
			Newgrid(i,j,1) = 1;
			Newgrid(i,j,2) = 1;
			Newgrid(i,j,3) = 0;
			Newgrid(i,j,4) = 0;
			collisionvalues = collisionvalues + 1; % Keep track of collisions with PARTICLES ONLY
			
		endif

	endfor
	
endfor

endfunction

	
% This is the display function of the program. From the output matrix after the
% collisions and propagation, we use the matrix values to map to a newly created 
% matrix of length [2n x 2n]. This is because the model is based on a square lattice structure.

function matrix = display(Oldgrid)

n = length(Oldgrid(:,1,1)); % Uses original length of matrix for looping parameters

matrix = zeros(2*n,2*n); % Uses original length of matrix to create new matrix


for i= 1:n
	
	for j= 1:n
		
		% Places the downward particle in bottom right of square lattice
	
		if Oldgrid(i,j,1) == 1 
				
				matrix(2*i,2*j) = 1;
						
		endif	
		
		% Places the upward particle in top left of square lattice
		if Oldgrid(i,j,2) == 1 
				
				matrix(2*i-1,2*j-1) = 1;
						
		endif	
		
		% Places the rightward particle in top right of square lattice
		if Oldgrid(i,j,3) == 1 
				
				matrix(2*i-1,2*j) = 1;
						
		endif	
		
		% Places the leftward particle in bottom left of square lattice
		if Oldgrid(i,j,4) == 1 
				
				matrix(2*i,2*j-1) = 1;
						
		endif	
		
	endfor
	
endfor

endfunction






% Main function of the program 
% This function calls all the other functions to simulate the model. 
% To run this function, run hpp.m file, then enter the function along with 
% parameters. 

% "Timesteps" (integer) is how many frames you will be seeing, or how many 
% moves you will be computing. 

% The "n" parameter (integer) is the dimensions of the matrix
% that you would like to see.
% The "p" parameter is a value from 0 to 1, where it gives you the
% amount of particles distributed in the matrix of random probability. If set to
% 1, then the entire matrix is full and won't run.

function simulate(timesteps, n, p) 

global collisionvalues; % Allows access to values 
global pressurevalues; % Allows access to values

pressurevalues = 0;
collisionvalues = 0;
numparticles = 0;

Grid = init(n,p); % Initialize grid
map = [1,1,1; 0,0,0]; % Black and white color map
colormap(map);

for i= 1:timesteps % Loops until input timesteps value

Grid = collide(Grid); % Calls function collide to compute matrix based on diagonal neighbors	
Grid = propagation(Grid); % Call function propagation to move particles in grid
								  % based on previous position, avoiding boundaries from [1 to n]
image(display(Grid)+1); % displays color black and white based on the color map of 1-black, 0-white
pause(0.01); % Pauses in between simulations to see movement of particles

endfor

disp("number of particle vs. particle collisions ="); % displays collisionvalues
disp(collisionvalues);

disp("pressure values (boundary vs particle collisions) =");
disp(pressurevalues);

disp("The actual total number of particles present = ");
numparticles = sum(sum(sum(Grid)));
disp(numparticles);

endfunction

