function [output] = optim_func_evsi1_spcase(m1, all_mods, mod_prob_all, B,...
    c1, c2, q, samp_postprob)

% DESCRIPTION: creates the function that is optimized in EVSI - 1st term
%   investment

% TYPE: function

% AUTHORS: Payal Bal

% INPUTS:

% OUTPUTS:

mod_species_all = NaN([1,size(all_mods,1)]);

for i = 1:size(all_mods,1)
    mod = all_mods(i,:);
    mod = [mod(1:3);mod(4:6)];
    
    mod_species_all(1,i) = get_num_spec_optim_spcase(m1,B,c1,c2,q,mod);
    
end

mod_postprob_all = get_mod_postprob(mod_prob_all, samp_postprob);
    % calculates model posterior probabilities for all models

output = sum(mod_postprob_all .* mod_species_all);

end