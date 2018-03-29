function [output] = optim_func_evpi1_spcase(m1, B, c1, c2, q, mod)
% FILENAME: optim_func_evpi2
% TYPE: function

% DESCRIPTION: Calculates optimal outcome across all models for a given
% investment. Function is used to calculate 2nd term of EVPI which is the
% outcome under uncertainty. BUT here also, we consider one model at a time
% and so we use mod and not prob_mat

% AUTHORS: Payal Bal

% INPUTS:

% OUTPUTS:

       output = get_num_spec_optim_spcase(m1, B, c1, c2, q, mod);

end


