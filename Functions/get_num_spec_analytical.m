function [output] = get_num_spec_analytical(m1,B,c1,c2,q,mod)

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

    % Constraining m1 value
    if m1 > min(c1,B)
        m1 = min(c1,B);
    elseif m1 < B - min(c2,B)
        m1 = B - min(c2,B); % to ensure B is nver sufficient and m2 > c2
    end
    
%     % Checking if constrains hold
%     if m1 < 0
%         disp('Warning (Analytical): m1 value not within constraints; m1 < 0'); 
%         disp(['m1 = ' ' ' num2str(m1)])
%     elseif m1 > min(c1,B)
%         disp('Warning (Analytical): m1 value not within constraints; m1 > min(c1,B)');
%         disp(['m1 =' ' ' num2str(m1) '  and  ' 'c1 = ' num2str(c1) '  and  ' 'B =' ' ' num2str(B)])
%     elseif m1 < B - min(c2,B)
%         disp('Warning (Analytical): m1 value not within constraints; m1 < B - min(c2,B)');
%         disp(['c2 = ' num2str(c2) '  and  ' 'm2 = (B-m1)' ' ' num2str(B-m1)])      
%     end
    
    
    % Calculating expected number of species declining
    sp_status = NaN([1,size(mod,2)]);
    
    for j = 1:size(mod,2)
        
        sp_status(j) = q(j) + (1 - q(j)) * (1 - (1 - mod(1,j) * ...
            (1 - (m1/c1))) * (1 - mod(2,j) * (1 - ((B - m1)/c2))));

    
    end
    
    exp_spec = sum(sp_status);
    out_m1 = m1;
        % m1 after applying constraints

    output = [exp_spec out_m1];

end

