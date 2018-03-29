function [output] = get_VOI_spcase(B, all_mods, q, pr_prob, c1, c2, Start_m1)


% TYPE: function
% DATE: 2/06/2015 
% AUTHORS: Payal Bal

% DESCRIPTION:  Calculates all VOI metrics (EVPI, EVSI for all monitoring
% strategies) for BERINGA CASE STUDY (special case)

% Output is a [length(B) x 19] matrix including:
%   output[:,1]  = evpi
%   output[:,2]  = Non-exp 1 species monitoring for species 1
%   output[:,3]  = Non-exp 1 species monitoring for species 2
%   output[:,4]  = Non-exp 1 species monitoring for species 3
%   output[:,5]  = Non-exp 2 species monitoring for species 1 & 2
%   output[:,6]  = Non-exp 2 species monitoring for species 1 & 3
%   output[:,7]  = Non-exp 2 species monitoring for species 2 & 3
%   output[:,8]  = Exp 1 species monitoring for species 1, managing threat 1 
%   output[:,9]  = Exp 1 species monitoring for species 2, managing threat 1 
%   output[:,10] = Exp 1 species monitoring for species 3, managing threat 1 
%   output[:,11] = Exp 1 species monitoring for species 1, managing threat 2
%   output[:,12] = Exp 1 species monitoring for species 2, managing threat 2
%   output[:,13] = Exp 1 species monitoring for species 3,, managing threat 2
%   output[:,14] = Exp 2 species monitoring for species 1 & 2, managing threat 1
%   output[:,15] = Exp 2 species monitoring for species 1 & 3, managing threat 1
%   output[:,16] = Exp 2 species monitoring for species 2 & 3, managing threat 1
%   output[:,17] = Exp 2 species monitoring for species 1 & 2, managing threat 2
%   output[:,18] = Exp 2 species monitoring for species 1 & 3, managing threat 2
%   output[:,19] = Exp 2 species monitoring for species 2 & 3, managing threat 2


    passive_output = nan(length(B), 6);
    active_output = nan(length(B), 12);


    mod_prob_all = get_mod_prob(all_mods, pr_prob);
        % calculate model probabilities for all models


    % EVPI
    evpi1 = NaN([1,length(B)]);
    evpi2 = NaN([1,length(B)]);
    for r = 1:length(B)
        evpi1(r) = get_EVPI_1_spcase(all_mods, mod_prob_all, B(r), c1, c2, q, Start_m1);
        out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1, c2, q, Start_m1);
        evpi2(r) = out_evpi2(1);
    end
    evpi = - evpi1 + evpi2;


    % EVSI
    % I. Monitoring one species - Non-experimental
    evsi = nan(length(B), 3);
    for sp_monit = 1:3
        evsi1 = NaN([1,length(B)]);
        evsi2 = NaN([1,length(B)]);
        for r = 1:length(B)
            evsi1(1,r) = get_EVSI_1_spcase(all_mods, mod_prob_all, B(r), c1, c2,...
                q,Start_m1, sp_monit);
            out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1, c2,...
                q, Start_m1);
            evsi2(1,r) = out_evpi2(1);
        end

        evsi(:,sp_monit) = - evsi1 + evsi2;
    end

    passive_output(:,1:3) = evsi;


    % II. Monitor 2 species - Non-experimental
    evsi = nan(length(B), 3);
    sp_monit = [1,2; 1,3; 2,3];
    for monitor = 1:3
        evsi1 = NaN([1,length(B)]);
        evsi2 = NaN([1,length(B)]);
        for r = 1:length(B)
            evsi1(1,r) = get_EVSI_1_2sp_spcase(all_mods, mod_prob_all, B(r), c1,...
                c2, q, Start_m1, sp_monit(monitor,:));
            out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1, c2,...
                q, Start_m1);
            evsi2(1,r) = out_evpi2(1);
        end

        evsi(:,monitor) = - evsi1 + evsi2;
    end

    passive_output(:,4:6) = evsi;


    % III. Monitoring one species - Experimental
    evsi = nan(length(B), 6);
    manage = [1:3; 4:6];
    % threat managed: (given by index i.e. T1 = 1:3 T2 = 4:6)
    for a = 1:2
        % index for threat management
        evsi_temp = NaN([length(B),3]);
        for sp_monit = 1:3
            % species monitored (given by index)
            % ADDING MANAGEMENT
            managed_mods = all_mods; managed_mods(:,manage(a,:)) = 0;
            % new set of models after management
            evsi1 = NaN([1,length(B)]);
            evsi2 = NaN([1,length(B)]);
            for r = 1:length(B)
                evsi1(1,r) = get_EVSI_1_exp_spcase(all_mods, managed_mods,...
                    mod_prob_all, B(r), c1, c2, q, Start_m1, sp_monit);
                out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1,...
                    c2, q, Start_m1);
                evsi2(1,r) = out_evpi2(1);
            end
            evsi_temp(:,sp_monit) = - evsi1 + evsi2;
        end
        evsi(:,manage(a,:)) = evsi_temp;
    end
    active_output(:,1:6) = evsi;


    % IV. Monitoring two species - Experimental
    evsi = nan(length(B), 6);
    manage = [1:3; 4:6];
    sp_monit = [1,2; 1,3; 2,3];
    for a = 1:2
        evsi_temp = NaN([length(B),3]);
        for monitor = 1:3
            managed_mods = all_mods; managed_mods(:,manage(a,:)) = 0;
            evsi1 = NaN([1,length(B)]);
            evsi2 = NaN([1,length(B)]);
            for r = 1:length(B)
                evsi1(1,r) = get_EVSI_1_exp_2sp_spcase(all_mods, managed_mods,...
                    mod_prob_all, B(r), c1, c2, q, Start_m1,...
                    sp_monit(monitor,:));
                out_evpi2 = get_EVPI_2_spcase(all_mods, mod_prob_all, B(r), c1,...
                    c2, q, Start_m1);
                evsi2(1,r) = out_evpi2(1);
            end
            evsi_temp(:,monitor) = - evsi1 + evsi2;
        end
        evsi(:, manage(a,:)) = evsi_temp;
    end
    active_output(:,7:12) = evsi;


    % OUTPUT
    output = [evpi', passive_output, active_output];
    output(output<0.0001)=0;
%     output = round(output*100)/100;

end

