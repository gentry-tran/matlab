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
	 
endfunction % Ends mySeedRandom function

% function mySeedRandom is now defined and for a given argument, will assign
% an integer value to myRandValue




%------------------------------------------------------------------------------%



% Part B

% Multiplicative Linear Congruential Method to generate random from 0 to 348

% Definition of myRandom

function myRandValue = myRandom

global myRandValue;

z = myRandValue; % Sets myRandValue to dummy variable for calculations


if (myRandValue > 0) % If mySeedRandom was called
	   

		if (z > 348) % Parameters to compute and output values in range
	
			z = z/348	
							
			z = z+5 	
						
			z = z*229
				
			myRandValue = rem (z,348) % Sets dummy back to myRandValue
				
				disp(myRandValue) % Displays Value again
		
		else
			
			% More computations without semicolons to see outputs
		
			z = myRandValue
		
			z = z+2

			z = z*229
				
			myRandValue = rem (z,348) % Sets dummy back to myRandValue
				
				disp(myRandValue) % Displays Value again
		endif
				
		
else % If mySeedRandom was not called
	
	z = 1
	
	z = z+2

	z = z*229
	
	myRandValue = rem (z,348) % Sets dummy back to myRandValue
				
		disp(myRandValue) % Displays Value again								
 
endif

endfunction % Ends myRandom function
