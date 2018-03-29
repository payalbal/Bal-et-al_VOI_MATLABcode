function [output] = get_EVSI_1_exp_spcase(all_mods, managed_mods, mod_prob_all, ...
    B, c1, c2, q, Start_m1, sp_monit)


% DESCRIPTION: Calculates the first term for EVSI for monitoring ONE
% SPECIES uneder EXPERIMENTAL MANAGEMENT


% INPUTS:
% all_mods = 64 x 6 matrix of 64 possible model combination for 3 species,
%   2 threat system where managed threats are turned off
%   (managed threat specified by index 'a' in parent code)
% managed_mods = 64 x 6 matrix of 64 possible model combination for 3 species,
%   2 threat system where threat
% mod_prob_all = (prior) proability of all 64 possible models
% B = budget available for management 
% c1 & c2 = investment required to eliminate threate 1 & 2, respectively
% q = background probability of decline for each species
% Start_m1 = starting value of m1 for optimization
% sp_monit = index specifying the ONE species monitored (index for ONE 
%   column from a 2-threat x 3-species matrix for a specific 
%   model


% OUTPUTS:
% output = EVSI first term
%   (ie. optimal outcome across all models for a given investment)


output_terms = [];

for sample_x_notmanaged = 0:1
    temp_terms = [];
     
    for sample_x_managed = 0:1 
        
        samp_postprob_notmanaged = get_samp_postprob(all_mods, q, sample_x_notmanaged, sp_monit);
        % probaility of observing sample under no management
        samp_postprob_managed = get_samp_postprob(managed_mods, q, sample_x_managed, sp_monit);
        % probaility of observing sample under management
        samp_postprob = samp_postprob_notmanaged .* samp_postprob_managed;
        % probaility of observing both (sample under management and no
        %   management)
        
        
        samp_prob = get_samp_prob(mod_prob_all, samp_postprob);
        % calculates probability of sample information, (x1,x2)
        
        
        % Specify special cases when optimisation is not required
        if B == 0
            m1 = 0;
            exp_spec = optim_func_evsi1_spcase(m1, all_mods, mod_prob_all, ...
                B, c1, c2, q, samp_postprob);
            fprintf(2,'Optimisation not required \n Exp_sp_uncertain calculated analytically \n B = 0 \n')
            
        elseif B == c1 + c2
            m1 = c1;
            exp_spec = optim_func_evsi1_spcase(m1, all_mods, mod_prob_all, ...
                B, c1, c2, q, samp_postprob);
            fprintf(2,'Optimisation not required \n Exp_sp_uncertain calculated analyticaly \n B = c1 + c2 \n')
            
        elseif B > c1 + c2
            error('myErrB:argChk', 'Error: Optimisation not required \n Exp_sp_uncertain not calculated \n B > c1 + c2')
            
        else
            % Optimization
            h=@(m1)optim_func_evsi1_spcase(m1, all_mods, mod_prob_all, B, c1, c2, q, samp_postprob);
            
            options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
                'MaxFunEvals', 500, 'Display', 'off');
            
            [~, fval] = fmincon(h,Start_m1,[1; -1],[c1, c2-B],...
                [],[],B-min(B,c2),min(B,c1),[], options);
            % the optimiser statement
            
            exp_spec = fval;
            
            
            %             % Optimisation - MultiStart
            %             h=@(m1)optim_func_evsi1(m1, all_mods, mod_prob_all, B, c1,...
            %                 c2, q, samp_postprob);
            %
            %             options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
            %                 'MaxFunEvals', 500, 'Display', 'off');
            %
            %             problem = createOptimProblem('fmincon','objective', h,'x0', Start_m1,...
            %                 'Aineq', [1; -1], 'bineq', [c1, c2-B],'lb', B-min(B,c2),'ub',...
            %                 min(B,c1),'options',options);
            %
            %             ms = MultiStart('Display', 'off');
            %             [~,fval] = run(ms,problem,10);
            %             exp_spec = fval;
            
        end
        temp_terms(1, sample_x_managed + 1) = samp_prob * exp_spec;
        
    end
    output_terms = [output_terms, temp_terms];
    
end
output = sum(output_terms);

end






