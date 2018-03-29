function [output] = get_samp_prob(mod_prob_all, samp_postprob)

% FILENAME: get_samp_prob
% TYPE: function
% AUTHORS: Payal Bal

% DESCRIPTION: function to calculate probability of obtaining sample
% information, x. This is used in the estimation of EVSI.


% INPUTS:
% mod_prob_all = (prior) proability of all 64 possible models
% samp_postprob = posterior probability of sample information, x


% OUTPUTS:
% output = prior probability of sample information, x

output = sum(samp_postprob .* mod_prob_all);

% NOTE: if x==1 elseif x==0 is not mentioned here because samp_postprob is estimated according to vaue of sample_x

end

