% FOR CASE STUDY
% DESCRIPTION: EVSI estimation for varying budgets



% clear

% LOAD INPUT DATA
load_data


% DEFINE GLOBAL VARIABLES
global s t B c1 c2 q pr_prob Start_m1 sp_monit
s = 3;
t = 2;
B = 0:10:100;
c1 = (real_c1/(real_c1+real_c2))*100; % Standardising costs
c2 = (real_c2/(real_c1+real_c2))*100; % Standardising costs
q = [s1q s2q s3q];
pr_prob = [s1_d1 s2_d1 s3_d1 s1_d2 s2_d2 s3_d2];
Start_m1 = 100;


% MODEL STATES & PROBABILITIES
all_mods = build_set(s,t);
% buils a matrix of all model states
%   [T1S1, T1S2, T1S3, T2S1, T2S2, T2S3]
mod_prob_all = get_mod_prob(all_mods, pr_prob);
% calculate model probabilities for all models


% CREATE EMPTY OUTPUT VECTORS
evsi1 = NaN([1,length(B)]);
evsi2 = NaN([1,length(B)]);
evsi = NaN([length(B),3]);
% opt_strategy = NaN([2,length(B)]);


%% EVSI ESTIMATION - PASSIVE MONITORING + MONITORING 1 SPECIES


% CALCULATE EVSI TERMS FROM EACH RUN
for sp_monit = 1:3
    
    for r = 1:length(B)
        
        % EVSI - 1
        evsi1(1,r) = get_EVSI_1_spcase(all_mods, mod_prob_all, B(r), c1, c2, q,...
            Start_m1, sp_monit);
        
        % EVSI - 2 (Same as EVPI2)
        out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1, c2, q, Start_m1);
        evsi2(1,r) = out_evpi2(1);
%         opt_strategy (1,r) = out_evpi2(2);
%         % optimal strategy for managemnt of threat 1 (m1)
%         opt_strategy (2,r) = B(r) - out_evpi2(2);
%         % optimal strategy for managemnt of threat 2 (m2)
    end
    
    % EVSI ESTIMATION
    evsi(:,sp_monit) = - evsi1 + evsi2;
end


%  PLOTS
% close ALL
%     % closes all previous windows
set(0,'DefaultFigureWindowStyle','docked')
% to dock figures by default

% % Plotting probabilities
% prob_mat = [pr_prob(1:3); pr_prob(4:6)]';
% plot_prob(prob_mat)
% hold off;

% Plotting EVSI
plot_species(B,evsi)
xlabel('Budget available for management','FontSize',20);
ylabel('Expected value of Sample Information','FontSize',20);
title('Monitoring one species')
disp('EVSI plotted');
