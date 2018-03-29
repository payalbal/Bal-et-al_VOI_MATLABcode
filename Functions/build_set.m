function [output] = build_set(s,t)
% FILENAME: build_set
% TYPE: function

% DESCRIPTION: Constructs a matrix of all possible outcomes for a 3 species, 2 threat system

% AUTHORS: Payal Bal

% INPUTS:
% s = number of species
% t = number of threats

% OUTPUTS:
% n_outcomes = number of possible outcomes if threat is a binary varaible
% (on or off) 
% n_models = number of possible models
% all_mods = matrix of all possible model states


n_outcomes = s * t;
n_models = 2^n_outcomes;
output = dec2bin(0:(2^n_outcomes-1),n_outcomes)-'0';

end

%% ADDITIONAL BITS 

% Save as dataset
% header = {'n_species', num2str( 'p12' 'p13' 'p21' 'p22' 'p23'}
% all_mods_dat = dataset({all_mods,header{:}})