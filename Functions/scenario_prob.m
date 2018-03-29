function [output] = scenario_prob(input_grid,scenario,k)

% DESCRIPTION: Specifies pr_prob according to the scenario

% input_grid = prob_grid
% output = pr_prob

global all_mods

    if scenario == 1
        % Sc 1 - Homogeneous
        output = input_grid(k,(1:size(all_mods, 2)));
    elseif scenario == 2
        % Sc 2 - Variability among threats, not species
        output = input_grid(k,(1:size(all_mods,2)));
        output(4:6) = input_grid(end + 1 - k, 1);
    elseif scenario == 3
        % Sc 3 - Variability among species, not threats
        output([2,5]) = 0.5;
        output([1,4]) = input_grid(k, 1);
        output([3,6]) = input_grid(end + 1 - k, 1);
    elseif scenario == 4
        % Sc 4 - Variability among threats and species
        output([2,5]) = 0.5;
        output([1,6]) = input_grid(k, 1);
        output([3,4]) = input_grid(end + 1 - k, 1);        
    end

end

