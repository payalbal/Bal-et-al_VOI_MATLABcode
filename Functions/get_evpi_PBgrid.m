function output = get_evpi_PBgrid(B_vec)

global c1 Bmax q pr_prob Start_m1 all_mods
exp_sp_certain = NaN([1,length(B_vec)]);
exp_sp_uncertain = NaN([1,length(B_vec)]);


mod_prob_all = get_mod_prob(all_mods, pr_prob);


for j = 1:length(B_vec)
    
    % EVPI 1 - OUTCOME UNDER CERTAINTY
    exp_sp_certain(j) = get_EVPI_1(all_mods, mod_prob_all,...
        B_vec(j), c1, Bmax - c1, q);
    % analytical solution; specific to 3 species-2threat system
    
    % EVPI 2 - OUTCOME UNDER UNCERTAINTY
    out_evpi2 = get_EVPI_2(all_mods, mod_prob_all, B_vec(j),...
        c1, Bmax - c1, q, Start_m1);
    exp_sp_uncertain(j) = out_evpi2(1);
end


% EVPI ESTIMATION
output = - exp_sp_certain + exp_sp_uncertain;


end