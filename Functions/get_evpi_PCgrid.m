function output = get_evpi_PCgrid(c1_vec)

global B Bmax q pr_prob Start_m1 all_mods
exp_sp_certain = NaN([1,length(c1_vec)]);
exp_sp_uncertain = NaN([1,length(c1_vec)]);


mod_prob_all = get_mod_prob(all_mods, pr_prob);

            
for j = 1:length(c1_vec)
    
    % EVPI 1 - OUTCOME UNDER CERTAINTY
    exp_sp_certain(j) = get_EVPI_1(all_mods, mod_prob_all, B,...
        c1_vec(j), Bmax - c1_vec(j), q);
    % analytical solution; specific to 3 species-2threat system
    
    % EVPI 2 - OUTCOME UNDER UNCERTAINTY
    out_evpi2 = get_EVPI_2(all_mods, mod_prob_all, B, c1_vec(j),...
        Bmax - c1_vec(j), q, Start_m1);
    exp_sp_uncertain(j) = out_evpi2(1);
end


% EVPI ESTIMATION
output = - exp_sp_certain + exp_sp_uncertain;


end
