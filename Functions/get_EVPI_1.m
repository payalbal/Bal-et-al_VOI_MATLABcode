function [output] = get_EVPI_1(all_mods, mod_prob_all, B, c1, c2, q)

% DESCRIPTION: Calculates the first term of the EVPI equation (ie. expected
%   outcome under no uncertainty.
%   We assume prior porbabilities to be 0 or 1 because there is NO
%   UNCERTAINTY and use mod %   instead or prob_mat


% INPUTS:

% OUTPUTS:
% opt_sol_matrix = matrix to store optimal solution for each model
%   [opt_species opt_manage; ...]
% output = first term of EVPI i.e. Expected number of species declining
%   under no uncertainty


opt_sol_matrix = NaN([size(all_mods,1),2]);
% creates empty matrix

for i = 1:size(all_mods,1);
    mod = all_mods(i,:);
    mod = [mod(1:3);mod(4:6)];
        % [2 x 3] threats by species matrix
    
    % % -----------------------------------------------------------------------
    %     % UNCOMMENT FOR DEBUGGING MODE
    %     num2str(i)
    %     % to display counter in outputs to identify model
    % % -----------------------------------------------------------------------
    
    % Specify special cases when optimisation is not required
    if B == 0
        m1 = 0;
        opt_sol_matrix(i,:) = get_num_spec_analytical(m1,B,c1,c2,q,mod);
%         fprintf(2,'Optimisation not required \n Exp_sp_certain calculated analytically \n B = 0 \n')
        
    elseif B == c1 + c2
        m1 = c1;
        opt_sol_matrix(i,:) = get_num_spec_analytical(m1,B,c1,c2,q,mod);
%         fprintf(2,'Optimisation not required \n Exp_sp_certain calculated analyticaly \n B = c1 + c2 \n')
        
    elseif B > c1 + c2
        error('myErrB:argChk', 'Error: Optimisation not required \n Exp_sp_certain not calculated \n B > c1 + c2')
        
    else
        opt_sol_matrix(i,:) = find_opt_manage(B, c1, c2, q, mod);
        % calculates optimal solution for the specified model
        % opt_sol_matrix(:,1) = opt_species from find_opt_manage
        %   expected number of species declining without uncertainty
        
    end
    
end


output = sum(mod_prob_all' .* opt_sol_matrix(:,1));


% % -----------------------------------------------------------------------
%     % UNCOMMENT FOR DEBUGGING MODE
%     opt_sol_matrix
% % -----------------------------------------------------------------------


end


