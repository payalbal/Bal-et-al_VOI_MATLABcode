function [output] = get_mod_postprob(mod_prob_all, samp_postprob)
% FILENAME: get_mod_postprob
% TYPE: function

% DESCRIPTION: function for probability of model given sample information
% i.e. Pr(s(k) given x)
% This is the posterior probability of the mmodel s(k)
% Same as mod_prob but with another input x where x can be 0 or 1 
% If one species is monitored, x can be o or 1
% If two species are monitored, x will be a vector with two numbers i.e. 00, 01, 10, 11. Therefore a vector
% of four outcomes/ matrix?

% AUTHORS: Payal Bal

% INPUTS:
% sample_x = sample information; can either be 0 or 1

% OUTPUTS:

output = (samp_postprob .* mod_prob_all) / sum(samp_postprob .* mod_prob_all);
      
end

