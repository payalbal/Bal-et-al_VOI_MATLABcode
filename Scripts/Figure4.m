% DESCRIPTION: VOI plots including EVPI and optimal EVSI strategies for
% case studies

clear
profile on
set(0,'DefaultFigureWindowStyle','docked')

global s t B Bmax Start_m1 q c1 c2 pr_prob all_mods
s = 3;
t = 2;
Start_m1 = 100;
Bmax = 100;
B = 0:10:Bmax;

all_mods = build_set(s,t);

for i = 1:2
    
    if i == 1
        load_Fortescue1     % Pilbara
    else
        load_data           % Fitz-Sterling (fox-fire)
    end
    
    c1 = (real_c1/(real_c1+real_c2))*100; % Standardising costs (out of 100)
    c2 = (real_c2/(real_c1+real_c2))*100; % Standardising costs (out of 100)
    q = [s1q s2q s3q];
    pr_prob = [s1_d1 s2_d1 s3_d1 s1_d2 s2_d2 s3_d2];
    
    if i == 1
        temp = get_VOI(B, all_mods, q, pr_prob, c1, c2, Start_m1);
        % Pilbara
    else
        temp = get_VOI_spcase(B, all_mods, q, pr_prob, c1, c2, Start_m1);
        % Fitz-Sterling (fox-fire)
    end
    
    passive_1sp = temp(:,2:4);
    passive_2sp = temp(:,5:7);
    active_1sp = temp(:,8:13);
    active_2sp = temp(:,14:19);
    
    % adding small amounts to sperate VOI lines
    if i == 1
        passive_1sp(2:10,2) = passive_1sp(2:10,2) + 0.0005;
        passive_1sp(2:10,3) = passive_1sp(2:10,3) + 0.001;
        
        passive_2sp(2:10,2) = passive_2sp(2:10,2) + 0.0005;
        passive_2sp(2:10,3) = passive_2sp(2:10,3) + 0.001;
        
    else
        passive_1sp(2:10,2) = passive_1sp(2:10,2) + 0.0005;
        active_1sp(2:10,6) = active_1sp(2:10,6) + 0.0005;
    end
    
    
    % Plots
    figure(i)
    subplot(2,2,1)
    plot(B,passive_1sp,'Linewidth', 2)
    set(gca,'ylim',[0 0.06])
    subplot(2,2,2)
    plot_exp(B,active_1sp)
    set(gca,'ylim',[0 0.06])
    subplot(2,2,3)
    plot(B,passive_2sp,'Linewidth', 2)
    set(gca,'ylim',[0 0.06])
    subplot(2,2,4)
    plot_exp(B,active_2sp)
    set(gca,'ylim',[0 0.06])
    
end


