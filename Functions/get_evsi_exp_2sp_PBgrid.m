function output = get_evsi_exp_2sp_PBgrid(B_vec,...
    monit_strategy, manage_strategy)

% EVSI grid for 2 sp monitoring, experimental
% Output vector for p-c combinations


global c1 Bmax q pr_prob Start_m1 all_mods
evsi1 = NaN([1,length(B_vec)]);
evsi2 = NaN([1,length(B_vec)]);


mod_prob_all = get_mod_prob(all_mods, pr_prob);
% ADDING MANAGEMENT
managed_mods = all_mods; managed_mods(:,manage_strategy) = 0;
% new set of models after management

            
for j = 1:length(B_vec)
    
    % EVPI 1 - OUTCOME UNDER CERTAINTY
    evsi1(j) = get_EVSI_1_exp_2sp(all_mods, managed_mods, mod_prob_all,...
        B_vec(j),c1, Bmax - c1, q, Start_m1, monit_strategy);
    % analytical solution; specific to 3 species-2threat system
    
    % EVPI 2 - OUTCOME UNDER UNCERTAINTY
    out_evpi2 = get_EVPI_2(all_mods, mod_prob_all, B_vec(j), c1,...
        Bmax - c1, q, Start_m1);
    evsi2(j) = out_evpi2(1);
end


% EVPI ESTIMATION
output = - evsi1 + evsi2;


end
