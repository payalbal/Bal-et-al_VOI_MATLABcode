function plot_exp(x, ymat)

% DATE: 2/12/2014

% DESCRIPTION: Plots EVSI for all 3 species under experimental approach

% AUTHORS: MATLAB, Payal Bal

% INPUTs
% x:  vector of x data
% ymat:  matrix of y data

% OUTPTS
% plots


% Create multiple lines using matrix input to plot
plot1 = plot(x,ymat,'Marker','o');
set(plot1(1),'DisplayName','Strategy 1','MarkerFaceColor',[0 0 1],'LineWidth',2,'Color',[0 0 1]);
set(plot1(2),'DisplayName','Strategy 2','MarkerFaceColor',[1 0.843137264251709 0], 'LineWidth',2, 'Color',[1 0.843137264251709 0]);
set(plot1(3),'DisplayName','Strategy 3','MarkerFaceColor',[0 0.498039215803146 0],'LineWidth',2,'Color',[0 0.498039215803146 0]);
set(plot1(4),'DisplayName','Strategy 4','LineWidth',1,'LineStyle','--','Color',[0 0 1]);
set(plot1(5),'DisplayName','Strategy 5','LineWidth',1,'LineStyle','--','Color',[1 0.843137264251709 0]);
set(plot1(6),'DisplayName','Strategy 6','LineWidth',1,'LineStyle','--','Color',[0 0.498039215803146 0]);

% Create xlabel
xlabel('','FontSize',20);

% Create ylabel
ylabel('','FontSize',20);


