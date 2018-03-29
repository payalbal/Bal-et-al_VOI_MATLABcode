function [output] = get_EVSI_1_2sp(all_mods, mod_prob_all, ...
    B, c1, c2, q, Start_m1, sp_monit)


% DESCRIPTION: Calculates the first term for EVSI for monitoring TWO
% SPECIES 


% INPUTS:
% all_mods = 64 x 6 matrix of 64 possible model combination for 3 species,
%   2 threat system where threats are either turned on or off
% mod_prob_all = (prior) proability of all 64 possible models
% B = budget available for management 
% c1 & c2 = investment required to eliminate threate 1 & 2, respectively
% q = background probability of decline for each species
% Start_m1 = starting value of m1 for optimization
% sp_monit = index specifying the TWO species monitored (index for TWO 
%   columnS from a 2-threat x 3-species matrix for a specific 
%   model


% OUTPUTS:
% output = EVSI first term
%   (ie. optimal outcome across all models for a given investment)


output_terms = [];
samp = [];


for sample_x1 = 0:1
    temp_terms = [];
    temp_samp = NaN(2,2);
    
    
    for sample_x2 = 0:1
        
        
        samp_postprob_sp1 = get_samp_postprob(all_mods, q, sample_x1, sp_monit(1));
        samp_postprob_sp2 = get_samp_postprob(all_mods, q, sample_x2, sp_monit(2));
        %  probaility of observing sample (x1) AND (x2) individually given the
        %   model(s), Pr(x given S)
        
        samp_postprob = samp_postprob_sp1 .* samp_postprob_sp2;
        % probaility of observing sample (x1,x2) given the model(s),
        %   Pr((x1,x2) given S)
        
        samp_prob = get_samp_prob(mod_prob_all, samp_postprob);
        % calculates probability of sample information, (x1,x2)
        
        
        % Specify special cases when optimisation is not required
        if B == 0
            m1 = 0;
            exp_spec = optim_func_evsi1(m1, all_mods, mod_prob_all, ...
                B, c1, c2, q, samp_postprob);
%             fprintf(2,'Optimisation not required \n Exp_sp_uncertain calculated analytically \n B = 0 \n')
            
        elseif B == c1 + c2
            m1 = c1;
            exp_spec = optim_func_evsi1(m1, all_mods, mod_prob_all, ...
                B, c1, c2, q, samp_postprob);
%             fprintf(2,'Optimisation not required \n Exp_sp_uncertain calculated analyticaly \n B = c1 + c2 \n')
            
        elseif B > c1 + c2
            error('myErrB:argChk', 'Error: Optimisation not required \n Exp_sp_uncertain not calculated \n B > c1 + c2')
            
        else
            % Optimization
            h=@(m1)optim_func_evsi1(m1, all_mods, mod_prob_all, B, c1, c2, q, samp_postprob);
            
            options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
                'MaxFunEvals', 500, 'Display', 'off');
            
            [~, fval] = fmincon(h,Start_m1,[1; -1],[c1, c2-B],...
                [],[],B-min(B,c2),min(B,c1),[], options);
            % the optimiser statement
            
            exp_spec = fval;
            
% %------------------------------------------------------------------------            
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
% %------------------------------------------------------------------------            
            
        end
        temp_terms(1, sample_x2 + 1) = samp_prob * exp_spec;
        temp_samp (sample_x2 + 1, :) = [sample_x1, sample_x2];
        
        
    end
    output_terms = [output_terms, temp_terms];
    samp  = [samp; temp_samp];
    % stores observed values of x1 and x2

    
end
output = sum(output_terms);


end






