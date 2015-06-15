% Gentry Tran
% Program Written on 3/29/12
% Random Numbers Generator Project #1 Part 1a, 1b.


global myRandValue; % Declaration of global variable so two diffferent
		    % definitions can have access to the variable 


% Part A

% Definition of mySeedRandom
function mySeedRandom (seed) % Starting to define the function to seed myRandom
			     % generator with two different seeds, based on input. 
% Body of function
	global myRandValue; % Allowing access to global variable

		if (nargin == 0) % Definition 2; when no argument, value
				 % baused on date and time
			fun= [1;1;1;1;1;1]; % Matrix to dot clock matrix with
			
	 		myRandValue = int16(dot(fun,clock)) % Dot product to assign integer
	 						    % based on date and time
	 		
				 disp ("Random Seed Value:"); % Displays string then value for 
					   	 	      %  random seed value
					   	      
					      disp(myRandValue); 	 
			
		else % Definition 1; where assigns a given integer value
	 
		myRandValue = seed;
		
			disp ("Random Seed Value:"); % Displays string then value for 
					    	     %  random seed value
					     
				     disp (myRandValue);
				     
		endif % Ends if statement	
	 
endfunction % Ends function

% function mySeedRandom is now defined and for a given argument, will assign
% an integer value to myRandValue




%------------------------------------------------------------------------------%



% Part B

% Multiplicative Linear Congruential Method to generate random from 0 to 348

% Definition of myRandom
function gen =  myRandom
 
	global myRandomValue = 1	% Will only change if not already defined 
				
	z = myRandomValue; % Sets to a dummy variable

	b = 3452349; % Multiplier

	n = 34583; % Increment

	m = 24572342; % Modulus

	myRandValue = mod(mod(b*z + n,m),348) % Sets back value for myRandomValue
				
	disp(myRandValue); % Displays Value again								
 
endfunction % Ends function
