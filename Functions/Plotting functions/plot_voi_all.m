function plot_voi_all(x, ymat)

% FILENAME: plot_evpi
% TYPE: funtion
% DATE: 13/06/2014

% DESCRIPTION: Plots calculated EVPI values against total budget (B), B/c1 and B/c2

% AUTHORS: MATLAB, Payal Bal

% INPUTs
% x:  vector of x data
% ymat:  matrix of y data

% OUTPTS
% plots


    % Create figure
    figure1 = figure;

    % Create axes
    axes1 = axes('Parent',figure1,'FontSize',16);
    ylim(axes1,[0 3]);
    box(axes1,'on');
    hold(axes1,'all');

    % Create xlabel
    xlabel('Budget available for management', 'FontSize',20);
    % Create ylabel
    ylabel('Value of information','FontSize',20);
    
    % Create multiple lines using matrix input to plot
    plot1 = plot(x,ymat,'Parent',axes1,'Marker','o','LineWidth',1,...
        'LineStyle',':');
    set(plot1(1),'MarkerFaceColor',[0 0.498039215803146 0],...
        'Color',[0 0.498039215803146 0],...
        'DisplayName','Outcome under certainty');
    set(plot1(2),'MarkerFaceColor',[0 0 1],'Color',[0 0 1],...
        'DisplayName','Outcome under uncertainty');
    set(plot1(3),'MarkerFaceColor',[0 0 0],'LineWidth',2,'DisplayName',...
        'EVPI/EVSI', 'Color',[0 0 0]);
    

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,'Location','Best');

end
