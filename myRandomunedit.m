% Gentry Tran
% Program Written on 3/29/12
% Random Numbers Generator Project #1 Part 1a.


global myRandValue; % Declaration of global variable so two diffferent
% definitions can have access to the variable 

% Definition of mySeedRandom
function mySeedRandom = mrv (k = int16(abs(input("Give an integer value, please  ")))) % Starting to define the function to seed
										       % myRandom generator with two different seeds, based on input. For empty
									       	       % arguments, must input value for k=0 for it to work
% Body of function
global myRandValue;

	if (k > 0) % Definition 1; where assigns a given integer value to
		 
		myRandValue = k;
		
			disp ("Random Seed Value:"); % Displays string then value for 
					    	     %  random seed value
				     disp (myRandValue);	 
			
	else % Definition 2; assigns value associated with the date and time to
	 
		fun= [1;1;1;1;1;1]; % Matrix to dot clock matrix with
		
	 		k = dot(fun,clock) % Dot product to assign one value
			
	 		myRandValue = int16(k)
	 		
				 disp ("Random Seed Value:"); % Displays string then value for 
					   	 	      %  random seed value	 
					      disp(myRandValue);
						
	 end % Ends if statement	
	 
end % Ends function
	
 
% function mySeedRandom is now defined and for a given argument, will assign
%  an integer value k to myRandValue


% Main program portion
% global myRandValue;

if (myRandValue > 0) % If we called mySeedRandom, this would be the computation
		     %  for this if/else statement
	global myRandValue; % Allows us to use change value of global variable
	
	z = myRandValue	% Sets myRandValue to dummy variable for calculations

		if (z >= 348) % Parameters to compute and output values in range
	
			z = z/348		% For each of the
						% computations, I
			z = myRandValue		% have left out
						% the semicolon
			z = z+5 		% to be able to see 
						% where any mistakes
			z = z*229 		% or values mess up
				
			myRandValue = rem (z,348) % Sets dummy back to myRandValue
				
				disp(myRandValue) % Displays Value again
		
		else
			
			% More computations without semicolons to see outputs
			z = myRandValue
		
			z = z+2

			z = z*229
				
			myRandValue = rem (z,348) % Sets dummy back to myRandValue
				
				disp(myRandValue) % Displays Value again
		
		end %
		
else
	% More computations without semicolons to see outputs to show each output step
	z = 1
	
	z = z+2

	z = z*229
	
	myRandValue = rem (z,348) % Sets dummy back to myRandValue
				
		disp(myRandValue) % Displays Value again								
 
end
