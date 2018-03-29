% EVSI - 2 species, experimental monitoring ONLY


set(0,'DefaultFigureWindowStyle','docked')
figure1 = figure;
axes1 = axes('Parent',figure1,'FontSize',16);
box(axes1,'on'); hold(axes1,'all');
idx = [1 2; 3 4; 5 6; 7 8];


global s t B Bmax Start_m1 q c1 c2 pr_prob prob manage sp_monit all_mods
global control_c1

s = 3;
t = 2;
Start_m1 = 100;
Bmax = 100;
q = [0.01 0.01 0.01];


% For figure in paper
control_c1 = [0.75 0.25];


all_mods = build_set(s,t);
manage = [1:3; 4:6];
sp_monit = [1,2; 1,3; 2,3];

B = 0.5 * Bmax;


for scenario = 1:4
    
    % ---------------------------------
    % Fixed c1, variable pr_prob
    % ---------------------------------
    
    for Cval = 1:length(control_c1)
        c1 = []; c2 = []; pr_prob = [];
        
        c1 = control_c1(Cval) * Bmax;
        c2 = Bmax - c1;
        prob = (0.1:0.1:0.9);
        
        % EVSI
        evsi_2sp_E = nan(length(prob), 6);
        for a = 1:2
            evsi_temp = NaN([length(prob),3]);
            for monitor = 1:3
                evsi1 = NaN([1,length(prob)]);
                evsi2 = NaN([1,length(prob)]);
                
                managed_mods = all_mods; managed_mods(:,manage(a,:)) = 0;
                pr_prob = [];
                
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
        subplot(4,2,idx(scenario, Cval))
        plot_exp(0:0.1:1,[zeros(1,6);evsi_2sp_E;zeros(1,6)])
        % because evsi is zero at p=0 and 1
        set(gca,'ylim',[0 0.20])

        
    end
end

