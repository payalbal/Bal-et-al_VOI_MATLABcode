function plot_opt_strategy(x, ymat)
% INPUTS
%  x:  bar xvector
%  ymat:  bar matrix data

    % Create figure
    figure1 = figure('PaperSize',[20.98404194812 29.67743169791]);

    % Create axes
    axes1 = axes('Parent',figure1,'YTick',[0 10 20 30 40 50 60 70 80 90 100],...
        'XTick',[0 10 20 30 40 50 60 70 80 90 100],...
        'FontSize',30);
    % Uncomment the following line to preserve the X-limits of the axes
    xlim(axes1,[-5 110]);
    %% Uncomment the following line to preserve the Y-limits of the axes
    % ylim(axes1,[0 100]);
%     box(axes1,'on');
%     hold(axes1,'all');


    % Create ylabel
    ylabel('Budget spent','FontSize',30);

    % Create multiple lines using matrix input to bar
    bar1 = bar(x,ymat,'BarLayout','stacked');
    set(bar1(1),'FaceColor',[0 0.5 0],'DisplayName','Investment in Fox management');
    set(bar1(2),'FaceColor',[0 0 1],'DisplayName','Investment in Fire management');

    % Create legend
    legend1 = legend(axes1,'show');
    set(legend1,'Location','Best');
end



