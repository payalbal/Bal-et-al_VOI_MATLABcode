% 1. EVPI and EVSI PB grids

clear

% Figure specifications
set(0,'DefaultFigureWindowStyle','docked')

% For EVPI and EVSI plots in one figure
figure1 = figure('Colormap',...
    [0.0431372560560703 0.517647087574005 0.780392169952393;0.0721330940723419 0.532263815402985 0.756743907928467;0.101128935813904 0.546880602836609 0.733095645904541;0.130124777555466 0.561497330665588 0.70944744348526;0.159120619297028 0.576114118099213 0.685799181461334;0.188116461038589 0.590730845928192 0.662150919437408;0.217112302780151 0.605347633361816 0.638502657413483;0.246108144521713 0.619964361190796 0.614854454994202;0.275103986263275 0.63458114862442 0.591206192970276;0.304099828004837 0.6491978764534 0.56755793094635;0.333095669746399 0.663814663887024 0.543909668922424;0.362091511487961 0.678431391716003 0.520261466503143;0.391087353229523 0.693048119544983 0.496613204479218;0.420083194971085 0.707664906978607 0.472964942455292;0.449079036712646 0.722281634807587 0.449316710233688;0.478074878454208 0.736898422241211 0.425668448209763;0.50707072019577 0.75151515007019 0.402020215988159;0.53606653213501 0.766131937503815 0.378371953964233;0.565062403678894 0.780748665332794 0.35472372174263;0.594058215618134 0.795365452766418 0.331075459718704;0.623054087162018 0.809982180595398 0.307427227497101;0.652049899101257 0.824598968029022 0.283778965473175;0.681045770645142 0.839215695858002 0.260130733251572;0.710041582584381 0.853832423686981 0.236482471227646;0.739037454128265 0.868449211120605 0.212834224104881;0.768033266067505 0.883065938949585 0.189185976982117;0.797029137611389 0.897682726383209 0.165537729859352;0.826024949550629 0.912299454212189 0.141889482736588;0.855020821094513 0.926916241645813 0.118241235613823;0.884016633033752 0.941532969474792 0.0945929884910584;0.913012504577637 0.956149756908417 0.0709447413682938;0.942008316516876 0.970766484737396 0.0472964942455292;0.971004188060761 0.985383272171021 0.0236482471227646;1 1 0;1 0.980000019073486 0;1 0.959999978542328 0;1 0.939999997615814 0;1 0.920000016689301 0;1 0.899999976158142 0;1 0.879999995231628 0;1 0.860000014305115 0;1 0.839999973773956 0;1 0.819999992847443 0;1 0.800000011920929 0;1 0.780000030994415 0;1 0.759999990463257 0;1 0.740000009536743 0;1 0.720000028610229 0;1 0.699999988079071 0;1 0.680000007152557 0;1 0.660000026226044 0;1 0.639999985694885 0;1 0.620000004768372 0;1 0.600000023841858 0;1 0.579999983310699 0;1 0.560000002384186 0;1 0.540000021457672 0;1 0.519999980926514 0;1 0.5 0;1 0.480000019073486 0;1 0.46000000834465 0;1 0.439999997615814 0;1 0.420000016689301 0;1 0.400000005960464 0]);
axes1 = axes('Parent',figure1,'Layer','top','FontSize',18,'CLim',[0 6]);
idx1 = reshape(1:12,[3,4])';


global s t B Bmax c1 c2 q pr_prob Start_m1 sp_monit manage all_mods

% Fixed parameters
s = 3;
t = 2;
Start_m1 = 100;
Bmax = 100;
c1 = 0.5 * Bmax;
c2 = Bmax - c1;
q = [0.001, 0.001, 0.001];


% Variables
global B_grid prob_grid prob

B = 0:10:100;
prob = (0:0.05:1);
[B_grid, prob_grid] = meshgrid(B,prob);


% Strategies - Monitoring, Experiment
sp_monit = [1,2; 1,3; 2,3];
manage = [1:3; 4:6];


% Models
all_mods = build_set(s,t);



%% SCENARIO ANALYSIS

for scenario = 1:4
    
    %--------------------------------------------------------------------------
    % EVPI
    %--------------------------------------------------------------------------
    
    evpi_grid = zeros(size(B_grid));
    
    for k=1:size(prob_grid,1)
        
        % Specify pr_prob according to scenario
        pr_prob = scenario_prob(prob_grid,scenario,k);
        
        % Calculate EVPI
        evpi_vec = get_evpi_PBgrid(B_grid(k,:));
        evpi_grid(k,:) = evpi_vec;
        
    end
    
    % Constraining EVPI at p = 0 or 1 to zero
    evpi_grid([1,21],:) = 0;
    
    max_evpi = max(evpi_grid(:));
    
    figure(1)
    subplot(4,3,idx1(scenario,1))
    imagesc(B,prob,evpi_grid)
    axis xy; % reverse axes
    set(gca,'XTickLabel','') % remove labels
    
    
    %--------------------------------------------------------------------------
    % EVSI - TARGETED STRATEGY - 2 SPECIES
    %--------------------------------------------------------------------------
    % (Estimating 2 species before 1 species to set max limit for
    % EVSI density plots)
    
    temp = nan(size(prob_grid,1), size(prob_grid,2), 6);
    
    for a = 1:2
        for monitor=1:3
            for k=2:size(prob_grid,1)-1
                pr_prob = scenario_prob(prob_grid,scenario,k);
                evsi1_vec = get_evsi_exp_2sp_PBgrid(B_grid(k,:),...
                    sp_monit(monitor,:), manage(a,:));
                if a == 1
                    temp(k,:,monitor) = evsi1_vec;
                elseif a == 2
                    temp(k,:,monitor+3) = evsi1_vec;
                end
            end
        end
    end
    
    temp(temp<0.01)=0;
    temp = round(temp*100)/100;
    
    % Find max EVSI (optimal strategy) and selected strategy index
    % Optimal strategy = optimal species and threat selection
    [evsi_grid] = nanmax(temp, [], 3);
    
    max_evsi = max(evsi_grid(:));
    
    % Plotting
    figure(1) % EVSI vs EVPI
    subplot(4,3,idx1(scenario,2));
    h=imagesc(B,prob,evsi_grid);
    set(h,'alphadata',~isnan(evsi_grid))
    set(gca,'clim',[0 max_evpi])
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
    axis xy;
    bar=colorbar;
    tempos = get(bar, 'position');
    set(bar,'Position', [tempos(1)+0.08 tempos(2) tempos(3) tempos(4)]);
    % to move colour bar to the right
    
    
    
    %-------------------------------------------------------------------------
    % EVSI - SURVEILLANCE STRATEGY - 2 SPECIES
    %--------------------------------------------------------------------------
    % (Estimating 2 species before 1 species to set max limit for
    % EVSI density plots)
    
    temp = nan(size(prob_grid,1), size(prob_grid,2), 6);
    
    for a = 1:2
        for monitor=1:3
            for k=2:size(prob_grid,1)-1
                pr_prob = scenario_prob(prob_grid,scenario,k);
                evsi1_vec = get_evsi_exp_2sp_PBgrid(B_grid(k,:),...
                    sp_monit(monitor,:), manage(a,:));
                if a == 1
                    temp(k,:,monitor) = evsi1_vec;
                elseif a == 2
                    temp(k,:,monitor+3) = evsi1_vec;
                end
            end
        end
    end
    
    temp(temp<0.01)=0;
    temp = round(temp*100)/100;
    
    % Find max EVSI (optimal strategy) and selected strategy index
    % Optimal strategy = optimal species and threat selection
    [evsi_grid] = nanmax(temp, [], 3);
    
    max_evsi = max(evsi_grid(:));
    
    % Plotting
    figure(1) % EVSI vs EVPI
    subplot(4,3,idx1(scenario,3));
    h=imagesc(B,prob,evsi_grid);
    set(h,'alphadata',~isnan(evsi_grid))
    set(gca,'clim',[0 max_evpi])
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
    axis xy;
    bar=colorbar;
    tempos = get(bar, 'position');
    set(bar,'Position', [tempos(1)+0.08 tempos(2) tempos(3) tempos(4)]);
    % to move colour bar to the right
    
    
end



