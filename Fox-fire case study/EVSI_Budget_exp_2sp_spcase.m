% DESCRIPTION: EVSI estimation for experimental approach to monitoring
% DATE: 28/10/2014


clear

% LOAD INPUT DATA
load_data


% DEFINE GLOBAL VARIABLES
global s t B c1 c2 q pr_prob Start_m1 sp_monit manage
s = 3;
t = 2;
B = 0:10:100;
c1 = (real_c1/(real_c1+real_c2))*100; % Standardising costs
c2 = (real_c2/(real_c1+real_c2))*100; % Standardising costs
q = [s1q s2q s3q];
pr_prob = [s1_d1 s2_d1 s3_d1 s1_d2 s2_d2 s3_d2];
Start_m1 = 100;


% MODEL STATES & PROBABILITIES (NO MANAGEMENT)
all_mods = build_set(s,t);
% buils a matrix of all model states  of the form
%   [T1S1, T1S2, T1S3, T2S1, T2S2, T2S3]
mod_prob_all = get_mod_prob(all_mods, pr_prob);
% calculate model probabilities for all models


% CREATE EMPTY OUTPUT VECTORS
evsi1 = NaN([1,length(B)]);
evsi2 = NaN([1,length(B)]);
evsi_mat = NaN([length(B),6]);



%% EVSI ESTIMATION - EXPERIMENTAL APPROACH + MONITORING 2 SPECIES
manage = [1:3; 4:6];
% threat managed: (given by index i.e. T1 = 1:3, T2 = 4:6)
sp_monit = [1,2; 1,3; 2,3];
% all combinations of species monitored


for a = 1:2
    % index for threat management
    
    evsi = NaN([length(B),3]);
    
    for monitor = 1:3
        % species monitored (given by index)
        
        % ADDING MANAGEMENT
        managed_mods = all_mods; managed_mods(:,manage(a,:)) = 0;
        % new set of models after management
        
        
        % CALCULATE EVSI TERMS FOR EACH BUDGET
        for r = 1:length(B)
            
            % EVSI - 1
            evsi1(1,r) = get_EVSI_1_exp_2sp_spcase(all_mods, managed_mods, mod_prob_all,...
                B(r), c1, c2, q, Start_m1, sp_monit(monitor,:));
            
            % EVSI - 2 (Same as EVPI2)
            out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1, c2, q, Start_m1);
            evsi2(1,r) = out_evpi2(1);
        end
        
        % EVSI ESTIMATION
        evsi(:,monitor) = - evsi1 + evsi2;
    end
    
    evsi_mat(:, manage(a,:)) = evsi;
end



% %  PLOTS
set(0,'DefaultFigureWindowStyle','docked')

plot_exp(B,evsi_mat)
xlabel('Budget available for management','FontSize',20);
ylabel('Expected value of Sample Information','FontSize',20);
title('Experimental approach: Monitoring two species')
disp('EVSI plotted');

% % To check if lines are aligning to the correct colour
% n=1;
% plot(B, evsi_mat(:,n),'Color',[0 0 1],'LineWidth',3)

