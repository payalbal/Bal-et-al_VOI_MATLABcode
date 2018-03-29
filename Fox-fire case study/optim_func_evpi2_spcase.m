function [output] = optim_func_evpi2_spcase(m1, all_mods, mod_prob_all, B, c1, c2, q)
% FILENAME: optim_func_evpi2
% TYPE: function

% DESCRIPTION: Calculates optimal outcome across all models for a given
% investment. Function is used to calculate 2nd term of EVPI which is the
% outcome under uncertainty. BUT here also, we consider one model at a time
% and so we use mod and not prob_mat

% AUTHORS: Payal Bal

% INPUTS:

% OUTPUTS:

mod_species_all = NaN([1,size(all_mods,1)]);

    for i = 1:size(all_mods,1)
    mod = all_mods(i,:);
    mod = [mod(1:3);mod(4:6)];
        
    mod_species_all(1,i) = get_num_spec_optim_spcase(m1,B,c1,c2,q,mod);
    end

output = sum(mod_prob_all .* mod_species_all);

% To get # sp for each model, comment line 25 and uncomment line 28
% output= mod_species_all;

end


