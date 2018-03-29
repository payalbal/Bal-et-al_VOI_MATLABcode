function [exp_spec] = get_num_spec_optim_spcase(m1,B,c1,c2,q,mod)

% FILENAME: get_num_spec.m
% TYPE: function
% AUTHORS: Payal Bal, Jonathan Rhodes

% DESCRIPTION: Calculates the expected number of species declining after
% management of threats. The decision problem consists of a 3 species, 2
% threat system

% INPUTS: 
%   m1 = investment in managing threat 1 B = budget availbale for
%   management c1 & c2 = investment required to eliminate threate 1 & 2,
%   respectively 
%   q = probability of factors other than the threats causing
%   a decline in the 3 species; 1 x 3 vector 
%   mod = 3 (species) x 4 (probability of threats causing decline) matrix 
%   of a given model
%
% OUTPUTS:
%   exp_spec = Expected number of species declining 
%

    % Checking if input m1 value satisfies the constraints
%     if m1 < 0
%         error('myErr1:argChk', 'Error: m1 value not within constraints \n m1 < 0'); 
%     elseif m1 > min(c1,B)
%         error('myErr2:argChk', 'Error: m1 value not within constraints \n m1 < min(c1,B)'); 
%     elseif m1 < B - min(c2,B)
%         error('myErr2:argChk', 'Error: m1 value not within constraints; \n m1 < B - min(c2,B)');
%     end
    

    % Checking if constrains hold
    if m1 < 0
        disp('Warning (Optimisation): m1 value not within constraints; m1 < 0');
        disp(['m1 = ' ' ' num2str(m1, 20)])
        % to avoid breaking of constraints by very small values
        m1 = 0;
        disp ('m1 contsrained to 0')
    elseif m1 > min(c1,B)
        disp('Warning (Optimisation): m1 value not within constraints; m1 > min(c1,B)');
        disp(['c1 = ' num2str(c1) '  and  ' 'm1 =' ' ' num2str(m1, 20)])
        m1 = min(c1,B);
        disp ('m1 contsrained to min(c1,B)')
    elseif m1 < B - min(c2,B)
        disp('Warning (Optimisation): m1 value not within constraints; m1 < B - min(c2,B)');
        disp(['c2 = ' num2str(c2) '  and  ' 'm2 = (B-m1)' ' ' num2str(B-m1, 20)])   
        m1 = B - min(c2,B);
        disp ('m1 contsrained to B - min(c2,B)')
    end

    
    % Calculating expected number of species (if above conditions are not
    % violated)
    sp_status = NaN([1,size(mod,2)]);
    
    for j = 1:size(mod,2)
        if j == 3
            sp_status(j) = q(j) + (1 - q(j)) * (1 - (1 - mod(1,j) * ...
                (1 - (m1/c1))) * (mod(2,j) - mod(2,j) * (1 - ((B - m1)/c2))));
        else
            sp_status(j) = q(j) + (1 - q(j)) * (1 - (1 - mod(1,j) * ...
                (1 - (m1/c1))) * (1 - mod(2,j) * (1 - ((B - m1)/c2))));
        end
        
    end
    
    exp_spec = sum(sp_status);
    
end

