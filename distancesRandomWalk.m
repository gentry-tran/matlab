function lstDist = distancesRandomWalk(n, numTests)
% RANDOMWALK  Function to return average distance
% between first and last point in random walk of
% n steps, where the simulation is performed
% numTests number of times
lstDist = zeros(1, n);
for i = 1:n
    lstDist(i) = distRandomWalk(i, numTests);
end;    