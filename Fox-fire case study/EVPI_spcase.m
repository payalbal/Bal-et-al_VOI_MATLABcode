% DESCRIPTION: EVPI estimation for varying budgets
% based on new_EVPI.m


clear

% LOAD INPUT DATA
load_data


% DEFINE GLOBAL VARIABLES
global s t B c1 c2 q pr_prob Start_m1 
s = 3;
t = 2;
B = 0:10:100;  
c1 = (real_c1/(real_c1+real_c2))*100; % Standardising costs
c2 = (real_c2/(real_c1+real_c2))*100; % Standardising costs
q = [s1q s2q s3q];
pr_prob = [s1_d1 s2_d1 s3_d1 s1_d2 s2_d2 s3_d2];
Start_m1 = 100; 

% c1 = (0:0.1:1) * max(B); 
% c2 = max(B) - c1;

% MODEL STATES & PROBABILITIES
all_mods = build_set(s,t);
    % buils a matrix of all model states   
mod_prob_all = get_mod_prob(all_mods, pr_prob);
    % calculate model probabilities for all models
    
% CREATE EMPTY OUTPUT VECTORS
exp_sp_certain = NaN([1,length(B)]);
exp_sp_uncertain = NaN([1,length(B)]);
opt_strategy = NaN([2,length(B)]);


%% CALCULATE EVPI TERMS FROM EACH RUN

for r = 1:length(B)
    
    % EVPI 1 - OUTCOME UNDER CERTAINTY
    exp_sp_certain(r) = get_EVPI_1_spcase(all_mods, mod_prob_all, B(r), c1, c2, q, Start_m1);
    % analytical solution; specific to 3 species-2threat system
    
    % EVPI 2 - OUTCOME UNDER UNCERTAINTY
    out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1, c2, q, Start_m1);
    exp_sp_uncertain(r) = out_evpi2(1);
    opt_strategy (1,r) = out_evpi2(2);
        % optimal strategy for managemnt of threat 1 (m1)
    opt_strategy (2,r) = B(r) - out_evpi2(2);
        % optimal strategy for managemnt of threat 2 (m2)
    
end


% EVPI ESTIMATION
evpi = - exp_sp_certain + exp_sp_uncertain
disp('EVPI calculated for all budgets');



%% STORING AND DISPLAYING RESULTS
outputs = [exp_sp_certain; exp_sp_uncertain; evpi];
threat_reduction(1,:) = (opt_strategy(1,:)/c1)*100;
threat_reduction(2,:)= (opt_strategy(2,:)/c2)*100;

disp('Displaying results - Varying Budget')
disp('c1  &  c2')
disp([c1, c2])
disp('pr_prob')
disp(pr_prob)
result_mat = [exp_sp_certain; exp_sp_uncertain; evpi; opt_strategy];
printmat(result_mat', 'Results', num2str(B), 'exp_sp_cert exp_sp_uncert EVPI Opt_m1 Opt_m2')
% print line to inform user of code progress    


%  EVPI PLOTS
% close ALL
    % closes all previous windows
set(0,'DefaultFigureWindowStyle','docked')
    % to dock figures by default 

% plot_voi_all(B,outputs')
% title('EVPI')

plot_opt_strategy(B,opt_strategy')
    % plots optimal investment in management of threat 1 (m1) and threat 2 (m2)
    % vs total budget available

% plot_voi_only(B,evpi)
% title('Expected Value of Perfect Information')
% 
% disp('EVPI plotted');
%     % print line to inform user of code progress    
%     

% To plot on the same graph

figure2 = figure;
plot_voi_only(B,evpi) % for the next run of the code


