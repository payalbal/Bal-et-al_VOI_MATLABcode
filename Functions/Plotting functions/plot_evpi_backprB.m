function plot_evpi_backprB(x, ymat)
% DATE: 5/12/2014

% DESCRIPTION: Plots EVPI vs background probability (q) at different
% budgets

% INPUTs
% x:  vector of x data
% ymat:  matrix of y data

% OUTPTS
% plots


% Create figure
figure1 = figure('PaperSize',[20.98404194812 29.67743169791]);

% Create axes
axes1 = axes('Parent',figure1,'FontSize',16);
box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(x,ymat,'Parent',axes1,'LineWidth',2);
set(plot1(1),'DisplayName','B=0');
set(plot1(2),'Color',[0 0.498039215803146 0],'DisplayName','B=10');
set(plot1(3),'DisplayName','B=20');
set(plot1(4),'DisplayName','B=30');
set(plot1(5),'DisplayName','B=40');
set(plot1(6),'DisplayName','B=50');
set(plot1(7),'LineWidth',6,'LineStyle',':','DisplayName','B=60');
set(plot1(8),'LineWidth',6,'LineStyle',':',...
    'Color',[0.39215686917305 0.474509805440903 0.635294139385223],...
    'DisplayName','B=70');
set(plot1(9),'LineWidth',6,'LineStyle',':','Color',[1 1 0],...
    'DisplayName','B=80');
set(plot1(10),'LineWidth',6,'LineStyle',':','Color',[0 1 0],...
    'DisplayName','B=90');
set(plot1(11),'LineWidth',6,'LineStyle',':','Color',[0 1 1],...
    'DisplayName','B=100');

% Create ylabel
ylabel('Expected value of Perfect Information','FontSize',20);

% Create xlabel
xlabel('Background probabillity of decline (q)','FontSize',20);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',14);

