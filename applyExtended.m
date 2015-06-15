function newmat = applyExtended(matExt); 
% APPLYEXTENDED - Function to apply 
% spread(site, N, E, S, W) to every interior
% site of square array matExt and to return 
% the resulting array
n = size(matExt, 1) - 2;
newmat = zeros(n);    
for i = 2:(n + 1)
    for j = 2:(n + 1)
        site = matExt(i, j);
        N = matExt(i - 1, j);
        E = matExt(i, j + 1);
        S = matExt(i + 1, j);
        W = matExt(i, j - 1);
        newmat(i - 1, j - 1) = spread(site, N, E, S, W);
    end;
end;