function plot_species(x, ymat)

% DATE: 2/12/2014

% DESCRIPTION: Plots EVSI for all 3 species against budget

% AUTHORS: MATLAB, Payal Bal

% INPUTs
% x:  vector of x data
% ymat:  matrix of y data

% OUTPTS
% plots


% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'YTickLabel',{'0','0.02','0.04','0.06','0.08','0.10','0.12','0.14'},...
    'YTick',[0 0.02 0.04 0.06 0.08 0.1 0.12 0.14],...
    'FontSize',30);
% ylim(axes1,[0 0.14]);
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(x,ymat,'Parent',axes1,'Marker','o','LineWidth',3);

% For monitoring 1 species
set(plot1(1),'DisplayName','Strategy 1');
set(plot1(2),'DisplayName','Strategy 2');
set(plot1(3),'DisplayName','Strategy 3');

% % For monitoring 2 species
% set(plot1(1),'DisplayName','Strategy 1 & 2');
% set(plot1(2),'DisplayName','Strategy 1 & 3');
% set(plot1(3),'DisplayName','Strategy 2 & 3');

% % Create legend
% legend1 = legend(axes1,'show');
% set(legend1,'Location','NorthWest');
% legend(axes1, 'boxoff')

