function M = animWalk(xStepLst, yStepLst);
%%% showWalk - visualization of random walk
clf;
minX = min(xStepLst);
maxX = max(xStepLst);
minY = min(yStepLst);
maxY = max(yStepLst);
lng = length(xStepLst);
for i = 1:lng
    p = plot(xStepLst(1:i), yStepLst(1:i), 'ok-', ...
        'MarkerFaceColor', 'b', 'MarkerSize', 9);
%    set(gca, 'XTick', minX:maxX);
%    set(gca, 'YTick', minY:maxY);
    axis([minX maxX minY maxY]);
%    axis equal;
    hold on;
    plot([xStepLst(i)], [yStepLst(i)], 'ok', ...
        'MarkerFaceColor', 'k', 'MarkerSize', 12);
    axis([minX maxX minY maxY]);
%    axis equal;
    M(i) = getframe;
    hold off;
end;   