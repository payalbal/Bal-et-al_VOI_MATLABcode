function plot_prob(input_mat)

% Create figure
figure1 = figure;


% Create axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',{'Species 1','Species 2',' Species 3'},...
    'XTick',[1 2 3],...
    'FontSize',16);
xlim(axes1,[-0.1 3.5])

box(axes1,'on');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(input_mat,'Parent',axes1,'MarkerSize',8,'Marker','o',...
    'LineStyle','none');
set(plot1(1),'MarkerFaceColor',[0 0.498039215803146 0],'Color',[0 0.498039215803146 0],...
    'DisplayName','Threat 1');
set(plot1(2),'MarkerFaceColor',[0 0 1],'DisplayName','Threat 2');

% Create ylabel
ylabel('Probability of impact','FontSize',16);

% Create title
title('Prior information on threats impacting species','FontSize',16);

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Location','Best');
legend(axes1, 'boxoff')



