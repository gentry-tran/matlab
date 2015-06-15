% linear congruential random number generator

% declare a global variable to hold the state of the random number generator
global MyRandValue;

% a) this function initializes the seed either to the argument, or to a function of the current date and time if no argument is given.
function MySeedRandom (seed)
	global MyRandValue;
	if (nargin == 0)
		MyRandValue = round(prod(clock()));
	else
		MyRandValue = seed;
	endif
endfunction

% b) a linear congruential generator for generating number between 0 and 348 inclusive

function rand = MyRandom

	global MyRandValue = 1;	% if MyRandValue is already 							% defined, it will not change

	a = 214013;	% the multiplier

	c = 2531011;	% the increment

	m = 2^32;	% the modulus

	MyRandValue = mod(a*MyRandValue + c, m);	

	rand = mod(bitshift(MyRandValue, -16), 349);	% we use the high bits only for better quality
endfunction
