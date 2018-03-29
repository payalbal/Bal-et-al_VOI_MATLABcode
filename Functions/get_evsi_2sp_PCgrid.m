function output = get_evsi_2sp_PCgrid(prob_vec, c1_vec,...
    all_mods, monit_strategy)

% EVSI grid for 2 sp monitoring, non-experimental
% Output vector for p-c combinations


global B Bmax q pr_prob Start_m1
evsi1 = NaN([1,length(prob_vec)]);
evsi2 = NaN([1,length(prob_vec)]);


mod_prob_all = get_mod_prob(all_mods, pr_prob);

            
for j = 1:length(prob_vec)
    
    % EVPI 1 - OUTCOME UNDER CERTAINTY
    evsi1(j) = get_EVSI_1_2sp(all_mods, mod_prob_all, B,...
        c1_vec(j), Bmax - c1_vec(j), q, Start_m1, monit_strategy);
    % analytical solution; specific to 3 species-2threat system
    
    % EVPI 2 - OUTCOME UNDER UNCERTAINTY
    out_evpi2 = get_EVPI_2(all_mods, mod_prob_all, B, c1_vec(j),...
        Bmax - c1_vec(j), q, Start_m1);
    evsi2(j) = out_evpi2(1);
end


% EVPI ESTIMATION
output = - evsi1 + evsi2;


end
