% EVSI - 2 species, experimental monitoring ONLY with errors

clear 

% IMPORTANT!!!
% Change function get_samp_posprob

% Figure specifications
set(0,'DefaultFigureWindowStyle','docked')
figure1 = figure;
axes1 = axes('Parent',figure1,'FontSize',16);
box(axes1,'on'); hold(axes1,'all');
ind2 = [1 3 5 7; 2 4 6 8];  % specify index for plotting in plot window


% Global variables
global s t B q pr_prob Bmax prob Start_m1 sp_monit manage...
     all_mods type1 type2


% Fixed parameters
s = 3;
t = 2;
Start_m1 = 100;
Bmax = 100;   % Budget required to eliminate all threats Bmax = c1 + c2
B = 0.5 * Bmax; % Budget fixed at 50% of Bmax
q = repmat(0.01, 1, 3);

% Variables
prob = (0.1:0.1:0.9);
c1 = 0.75 * Bmax;
c2 = Bmax - c1;

% Strategies - Monitoring, Experiment
sp_monit = [1,2; 1,3; 2,3];
manage = [1:3; 4:6];

% Models
all_mods = build_set(s,t);


for err = 1:2
    
    if err == 1
        type1 = 0.1; type2 = 0;
    elseif err == 2
        type1 = 0; type2 = 0.1;
%     elseif err == 3
%         type1 = 0.3; type2 = 0.3; % EVSI is close to zero, not
%         interesting to plot
    end
    
    for scenario = 1:4
        pr_prob = [];
        
        % EVSI
        evsi_2sp_E = nan(length(prob), 6);
        for a = 1:2
            evsi_temp = NaN([length(prob),3]);
            for monitor = 1:3
                evsi1 = NaN([1,length(prob)]);
                evsi2 = NaN([1,length(prob)]);
                
                managed_mods = all_mods; managed_mods(:,manage(a,:)) = 0;
                
                for r = 1:length(prob)
                    
                    if scenario == 1
                        pr_prob = repmat(prob(r),1,6);
                    elseif scenario == 2
                        pr_prob(1:3) = prob(r); pr_prob(4:6) = prob(end + 1 - r);
                    elseif scenario == 3
                        pr_prob([2,5]) = 0.5;
                        pr_prob([1,4]) = prob(r);
                        pr_prob([3,6]) = prob(end + 1 - r);
                    elseif scenario == 4
                        pr_prob([2,5]) = 0.5;
                        pr_prob([1,6]) = prob(r);
                        pr_prob([3,4]) = prob(end + 1 - r);
                    end
                    
                    mod_prob_all = get_mod_prob(all_mods, pr_prob);
                    
                    evsi1(1,r) = get_EVSI_1_exp_2sp(all_mods, managed_mods,...
                        mod_prob_all, B, c1, c2, q, Start_m1,...
                        sp_monit(monitor,:));
                    out_evpi2 = get_EVPI_2(all_mods, mod_prob_all, B, c1,...
                        c2, q, Start_m1);
                    evsi2(1,r) = out_evpi2(1);
                    
                end
                evsi_temp(:,monitor) = - evsi1 + evsi2;
                
            end
            evsi_2sp_E(:, manage(a,:)) = evsi_temp;
        end
        
        evsi_2sp_E(evsi_2sp_E < 0.01) = 0;
        evsi_2sp_E = round(evsi_2sp_E * 100)/100;
        
        % Adding small amounts to seperate overlapping species lines
        evsi_2sp_E(:,[2,5]) = evsi_2sp_E(:,[2,5]) + 0.002;
        evsi_2sp_E(:,[3,6]) = evsi_2sp_E(:,[3,6]) + 0.004;
        
        
        % Plot
        figure(1)
        subplot(4,2,ind2(err,scenario))
        plot_exp(0:0.1:1,[zeros(1,6);evsi_2sp_E;zeros(1,6)])
        % because evsi is zero at p=0 and 1
        ylim([0 0.2])

    end
end

