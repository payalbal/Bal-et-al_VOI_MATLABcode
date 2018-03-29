function [output] = get_EVPI_1_optim(all_mods, mod_prob_all, B, c1, c2, q, Start_m1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% % Optimisation  
mod_sp_all = NaN([1, size(all_mods,1)]);
    % empty vector to store optimal solution for each model
        
for i = 1:size(all_mods,1)
    mod = all_mods(i,:);
    mod = [mod(1:3);mod(4:6)];
    
    % Specify special cases when optimisation is not required
    if B == 0
        m1 = 0;
        mod_sp_all(i) = optim_func_evpi1(m1, B, c1, c2, q, mod);
        fprintf(2,'Optimisation not required \n Exp_sp_certain calculated analytically \n B = 0 \n')
        
    elseif B == c1 + c2
        m1 = c1;
        mod_sp_all(i) = optim_func_evpi1(m1, B, c1, c2, q, mod);
        fprintf(2,'Optimisation not required \n Exp_sp_certain calculated analyticaly \n B = c1 + c2 \n')
        
    elseif B > c1 + c2
        error('myErrB:argChk', 'Error: Optimisation not required \n Exp_sp_certain not calculated \n B > c1 + c2')
        
    else
        % for when B > 0 and B < c1 + c2
        
%         % Optimization
%         g=@(m1)optim_func_evpi1(m1, B, c1, c2, q, mod);
% 
%         options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
%             'MaxFunEvals', 500, 'Display', 'off');
% 
%         [x, fval, exitflag, output] = fmincon(g,Start_m1,[1; -1],...
%             [c1, c2-B],[],[],B-min(B,c2),min(B,c1),[], options);
% 
%         mod_sp_all(i) = fval * mod_prob_all(i);
        

        % Optimisation - MultiStart
        g=@(m1)optim_func_evpi1(m1, B, c1, c2, q, mod);
        
        options = optimset('Algorithm','active-set', 'TolFun', 1e-8,...
            'MaxFunEvals', 500, 'Display', 'off');
        
        problem = createOptimProblem('fmincon','objective', g,'x0', Start_m1,...
            'Aineq', [1; -1], 'bineq', [c1, c2-B],'lb', B-min(B,c2),...
            'ub', min(B,c1),'options',options);
        
        ms = MultiStart('Display', 'final');
        [x,fval] = run(ms,problem,10);
        mod_sp_all(i) = fval * mod_prob_all(i);

        
% % -----------------------------------------------------------------------             
%         % UNCOMMENT FOR DEBUGGING MODE
%         % To find location of warnings from get_num_spec_optim
%         num2str(i)
%         fval
%         x
% % -----------------------------------------------------------------------       
        
    end
      
end

output = sum(mod_sp_all);

end

