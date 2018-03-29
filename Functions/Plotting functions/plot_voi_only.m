function plot_voi_only(x,y)
% INPUTS
%  x:  vector of x data
%  ymat:  vector of y data


    % Create figure
    figure1 = figure;

    % Create axes
%     axes1 = axes('Parent',figure1,...
%         'YTickLabel',{'0','0.005','0.010','0.015','0.020','0.025','0.030'},...
%         'XTick',[0 10 20 30 40 50 60 70 80 90 100],...
%         'FontSize',30);
%     box(axes1,'on');
%     hold(axes1,'all');


    % Create ylabel
    ylabel('EVPI','FontSize',30);

    % Create plot
    plot(x,y,'MarkerFaceColor',[0 0 0],'LineWidth',6,'Color',[0 0 0]);

end