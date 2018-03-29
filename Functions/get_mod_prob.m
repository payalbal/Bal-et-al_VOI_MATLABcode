function [output] = get_mod_prob(models, pr_prob)

% FILENAME: get_mod_prob
% TYPE: function
% DATE: 25/09/2014 
%       (reverted back to get_mod_prob from VOI_0.1_old set with some
%       modifications)
% AUTHORS: Payal Bal

% DESCRIPTION: Calculates prior probailities for all models

% BACKGROUND INFORMATION: 3 species, 2 threat system; 64 possible models
% where threats are either turned on or off; each threat affects a species
% with a given prior probability

% FUNCTIONS USED:
% build_mod

% INPUTS:
% models = 64 x 6 matrix of 64 possible model combination for 3 species, 2 threat system
%            where threats are either turned on or off
% pr_prob = 1 x 6 vector of proability of threats affecting species


% OUTPUTS:
% output = prior proability for all 64 possible models stored as a vector

nonzero_decline_prod = NaN([1,size(models,1)]);
    % specifies an empty vector

zero_non_decline_prod = NaN([1,size(models,1)]);
    % specifies an empty vector

prob_mat =  bsxfun(@times, models, pr_prob);
    % produces a matrix of probabilities WHERE THREATS ARE 
        % CAUSING A DECLINE for all models 
    % element-wise multiplication;
    
    
if pr_prob == [0 0 0 0 0 0]
    prob_mat_inv = ~prob_mat;
    % to subsitiute the 0 with 1 and vice versa in the prob_mat
else
    prob_mat_inv = flipud(prob_mat);
    % produces a matrix of probabilities WHERE THREATS ARE NOT
        % CAUSING A DECLINE for all models. This is the same as flipping
        % prob_mat over
    % see alternate methods below
end

for i = 1: size(models, 1)
    
    % (Model-wise) Product of probabilities of threats causing decline
    [~, ~, val] = find(prob_mat(i,:));
        % find non zero values
    nonzero_decline_prod(i) = prod(val);
        % product of non-zero probabilities; product of probability of
        % decline for threats that are causing species declines
    
    % (Model-wise) Product of 1-probabilities of threats NOT causing declines
    [~, ~, val] = find(prob_mat_inv(i,:));    
    zero_non_decline_prod(i) = prod(1-val);
        % product of 1-probabily of decline for threats that are NOT causing
        % species declines
    
end

output = nonzero_decline_prod .* zero_non_decline_prod;
% model probabilities for all model states specified


end


%% NOTES

% For locating probabilities when threat are not causing a decline:
% Method 1:
% inv_all_mods = models==0
% prob_mat =  bsxfun(@times, inv_all_mods, pr_prob);
% [~, ~, val] = find(prob_mat(i,:));
% zero_non_decline_prod(i) = prod(1-val);

% Method 2:
% inv_all_mods = flipud(models) 
%   % flips the matrix vertically; same result as above
% prob_mat =  bsxfun(@times, inv_all_mods, pr_prob);
% ...

% Method 3: 
% prob_mat = flipud(prob_mat)
% ...

%Method 4:
% Same as previous versions
%  for i = 1: size(prob_mat, 1)
%         [~, ~, val] = find(prob_mat(i,:));  
%         % find values and ind
%         nonzero_prob_prod(i) = prod(val);           
%         % product of non-zero probabilities; product of probability of
%         % decline for threats that are causing species declines
%                                                     
%         nonzero_prob_non_decline_prod(i) = prod(1-val);  
%         % product of 1-probabily of decline for threats that are causing
%         % species declines
%         
%     end
%    
%     output = nonzero_prob_prod .* (prod(1-pr_prob) ./ nonzero_prob_non_decline_prod);
%     % model probabilities for all model states specified


    
        
                