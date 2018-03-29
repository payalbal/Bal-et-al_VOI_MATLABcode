function plot_2Dcol(x,y,col)

% TYPE: function
% DATE: 2/06/2015 
% AUTHORS: Payal Bal

% DESCRIPTION:  Plot y such that line segments are coloured according to
% 'col' variable 

for i = 1:length(x)-1
    hold all
    plot(x(i:i+1), y(i:i+1), 'Color', col(i+1,:))
end