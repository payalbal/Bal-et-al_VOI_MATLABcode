function [output] = get_EVPI_2(all_mods, mod_prob_all, B, c1, c2, q, Start_m1)

% DESCRIPTION: Calculates the second term of the EVPI equation (ie.
%   expected outcome under uncertainty. 
%   We assume prior porbabilities to be 0 or 1 because even if there IS
%   UNCERTAINTY, we only consider onE model at a time with certainty for
%   EVPI_2 calculation. So we use mod instead or prob_mat.


% TYPE: function
% AUTHORS: Payal Bal

% INPUTS:

% OUTPUTS:
% output = [1 x 2] vector of [opt_species opt_manage]
%   Opt_ species is  the expected number of species declining under no
%   uncertainty


% EVPI - OUTCOME UNDER UNCERTAINTY
 
% Specify special cases when optimisation is not required
if B == 0
    m1 = 0;
    out = optim_func_evpi2_spcase(m1, all_mods, mod_prob_all, B, c1, c2, q);
    output = [out, m1];
    fprintf(2,'Optimisation not required \n Exp_sp_uncertain calculated analytically \n B = 0 \n')
    
elseif B == c1 + c2
    m1 = c1;
    out = optim_func_evpi2_spcase(m1, all_mods, mod_prob_all, B, c1, c2, q);
    output = [out, m1];
    fprintf(2,'Optimisation not required \n Exp_sp_uncertain calculated analyticaly \n B = c1 + c2 \n')
    
elseif B > c1 + c2
    error('myErrB:argChk', 'Error: Optimisation not required \n Exp_sp_uncertain not calculated \n B > c1 + c2')
    
else
    % Optimization
    f=@(m1)optim_func_evpi2_spcase(m1, all_mods, mod_prob_all, B, c1, c2, q);

    options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
        'MaxFunEvals', 500, 'Display', 'off');
    
    [x, fval] = fmincon(f,Start_m1,[1; -1],[c1, c2-B],...
        [],[],B-min(B,c2),min(B,c1),[], options);
      % the optimiser statement

    output = [fval,x];
    

%     % Optimisation - MultiStart
%     f=@(m1)optim_func_evpi2(m1, all_mods, mod_prob_all, B, c1, c2, q);
%     
%     options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
%         'MaxFunEvals', 500, 'Display', 'off');
%     
%     problem = createOptimProblem('fmincon','objective', f,'x0', Start_m1,...
%         'Aineq', [1; -1], 'bineq', [c1, c2-B],'lb', B-min(B,c2),'ub',...
%         min(B,c1),'options',options);
%     
%     ms = MultiStart('Display', 'off');
%     [x,fval] = run(ms,problem,10);
%     output = [fval, x];
    
end

end

