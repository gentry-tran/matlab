function avgDist = distRandomWalk(n, numTests)
% RANDOMWALK  Function to return average distance
% between first and last point in random walk of
% n steps, where the simulation is performed
% numTests number of times
rand('state', sum(100*clock))
x0 = 0;
y0 = 0;
sumDist = 0;
for j = 1:numTests
    x = x0;
    y = y0;
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
    end;    
    sumDist = sumDist + sqrt((x - x0)^2 + (y - y0)^2);
end;
avgDist = sumDist/numTests;