function [output] = find_opt_manage(B, c1, c2, q, mod)
% FILENAME: find_opt_manag
% TYPE: function
% DATE: 16/05/2014

% DESCRIPTION: The decision problem consists of a 3 species, 2 threat
% system. Calculates the analytical solution to the decision problem and
% estimates optimal resource allocation in management to get highest
% expected number of species declining.

% AUTHORS: Payal Bal; help from Joshua Soderholm

% INPUTS:
% B = budget availbale for management 
% c1 & c2 = investment required to eliminate threate 1 & 2, respectively
% mod = model of the system

% OUTPUTS:
% output = [1 x 2] vector with: 
%   [1] as opt_species = expected number of species declining under optimal
%   management, and
%   [2] as opt_manage = optimal investment in management (simulataneous
%   solution of the Langrangian)




% Analytical solutions for investment in management
    % Interior solution
num = -((c2 * mod(1,:)) - (c1 * mod(2,:)) + (B * mod(1,:) .* mod(2,:))...
    + (c1 * mod(1,:) .* mod(2,:)) - (c2 * mod(1,:) .* mod(2,:)) - ...
    (c2 * mod(1,:) .* q) + (c1 * mod(1,:) .* q) - (B * mod(1,:)...
    .* mod(2,:) .* q) - (c1 * mod(1,:) .* mod(2,:) .* q) +...
    (c2 * mod(1,:) .* mod(2,:) .* q));
den = - (mod(1,:) .* mod(2,:)) + (mod(1,:) .* mod(2,:) .* q);
manage_1 = 0.5 * (sum(num)/sum(den));


% % Index equation - GIVES DIFFERENT ANSWER!!
% num = (c2 * mod(1,:)) - (c1 * mod(2,:)) + (B * (mod(1,:) .* mod(2,:)))...
%     + (c1 * (mod(1,:) .* mod(2,:))) - (c2 * (mod(1,:) .* mod(2,:)))
% den = mod(1,:) .* mod(2,:)
% manage_1 = 0.5 * (sum(num)/sum(den))


    % Boundary solutions 
manage_2 = B-c2;                       
manage_3 = B;                             
manage_4 = c1;                              
manage_5 = 0; 


% Outcomes (number of species not declining) corresponding to solutions for
% investment
out_1 = get_num_spec_analytical(manage_1,B,c1,c2,q,mod);
out_2 = get_num_spec_analytical(manage_2,B,c1,c2,q,mod);
out_3 = get_num_spec_analytical(manage_3,B,c1,c2,q,mod);
out_4 = get_num_spec_analytical(manage_4,B,c1,c2,q,mod);
out_5 = get_num_spec_analytical(manage_5,B,c1,c2,q,mod);


% Solutions matrix [exp_sp out_m1; ...]
sol = [out_1(1) out_1(2); out_2(1) out_2(2); out_3(1) out_3(2); out_4(1)...
    out_4(2); out_5(1) out_5(2)];


% % -----------------------------------------------------------------------
%     % UNCOMMENT FOR DEBUGGING MODE
%     check_sol = [out_1(1) manage_1 out_1(2); out_2(1) manage_2 out_2(2);...
%         out_3(1) manage_3 out_3(2); out_4(1) manage_4 out_4(2);...
%         out_5(1) manage_5 out_5(2)];
%     printmat(check_sol, 'check_sol', num2str(1:5), 'Exp_sp input_m1 constr_m1')
% % -----------------------------------------------------------------------


% Selecting optimal solution 
% WHEN MINIMIZING
    % first selecting non negative outcomes only
sol = sol(sol(:,1)>=0,:);    
    % optimal solution = minimum outcome for miminum investment
min_c1_mask = sol(:,1) == min(sol(:,1));    % by Joshua
min_c2_of_c1 = min(sol(min_c1_mask,2));     % by Joshua
min_c2_mask = sol(:,2) == min_c2_of_c1;     % by Joshua


% % -----------------------------------------------------------------------
% % WHEN MAXIMIZING
%     % optimal solution = maximum outcome for miminum investment
% max_c1_mask = sol(:,1) == max(sol(:,1));    % by Joshua
% min_c2_of_c1 = min(sol(max_c1_mask,2));     % by Joshua
% min_c2_mask = sol(:,2) == min_c2_of_c1;     % by Joshua
% % -----------------------------------------------------------------------


opt_sol_index = find(min_c1_mask & min_c2_mask);
output = sol(opt_sol_index(1),:);


% % -----------------------------------------------------------------------
%     % UNCOMMENT FOR DEBUGGING MODE
%     if output(1) == sum(q)
%         fprintf(2,'Zero species declining due to threats \n')
%     end
% 
% 
%     % UNCOMMENT FOR DEBUGGING MODE
%     mod
%     opt_species = output(1)
%     opt_manage = output(2)
% % -----------------------------------------------------------------------

end



