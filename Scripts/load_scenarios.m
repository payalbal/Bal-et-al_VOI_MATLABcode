% SCENARIOS FOR VOI 

%% VARIABLES FOR SCENARIO SPECIFICATION

low_q = 0.001;
high_q = 0.75;
equal_c1 = 50;
high_c1 = 75;
equal_p = 0.5;
high_p = 0.75;
low_p = 0.25;

% c2 is calculated later as Bmax-c1



%% HIGH EVPI SCENARIOS (HAND PICKED TO SHOW TRENDS)
   
% max EVPI but evsi is same for all species
scenario1 = [0.001 0.001 0.001 0.4 0.4 0.4 0.4 0.4 0.4 50]; 
    
%  max EVSI switches between species
scenario2 = [0.001 0.001 0.001 0.5 0.5 0.9 0.01 0.2 0.5 75];


%% LOW q SCENARIOS

% p1j = p2g scenario
scenario3 = [repmat(low_q,1,3) repmat(equal_p,1,6) equal_c1];        
scenario4 = [repmat(low_q,1,3) repmat(high_p,1,6) equal_c1];
scenario5 = [repmat(low_q,1,3) repmat(low_p,1,6) equal_c1];
    % c1 > c2
    scenario6 = [repmat(low_q,1,3) repmat(equal_p,1,6) high_c1];        
    scenario7 = [repmat(low_q,1,3) repmat(high_p,1,6) high_c1];
    scenario8 = [repmat(low_q,1,3) repmat(low_p,1,6) high_c1];

% p1j ~= p2g scenario; p1j constant
scenario9 = [repmat(low_q,1,3) repmat(equal_p,1,3) repmat(high_p,1,3) equal_c1];
scenario10 = [repmat(low_q,1,3) repmat(equal_p,1,3) repmat(low_p,1,3) equal_c1];
    % c1 > c2
    scenario11 = [repmat(low_q,1,3) repmat(equal_p,1,3) repmat(high_p,1,3) high_c1];
    scenario12 = [repmat(low_q,1,3) repmat(equal_p,1,3) repmat(low_p,1,3) high_c1];    

% pi1 = pi2 ~= pi3; pi1 and pi2 constant
scenario13 = [repmat(low_q,1,3) equal_p equal_p high_p equal_p equal_p high_p equal_c1];
scenario14 = [repmat(low_q,1,3) equal_p equal_p low_p equal_p equal_p low_p equal_c1];
    % c1 > c2
    scenario15 = [repmat(low_q,1,3) equal_p equal_p high_p equal_p equal_p high_p high_c1];
    scenario16 = [repmat(low_q,1,3) equal_p equal_p low_p equal_p equal_p low_p high_c1];    

    
    
%% HIGH q SCENARIOS

% p1j = p2g scenario
scenario17 = [repmat(high_q,1,3) repmat(equal_p,1,6) equal_c1];        
scenario18 = [repmat(high_q,1,3) repmat(high_p,1,6) equal_c1];
scenario19 = [repmat(high_q,1,3) repmat(low_p,1,6) equal_c1];
    % c1 > c2
    scenario20 = [repmat(high_q,1,3) repmat(equal_p,1,6) high_c1];        
    scenario21 = [repmat(high_q,1,3) repmat(high_p,1,6) high_c1];
    scenario22 = [repmat(high_q,1,3) repmat(low_p,1,6) high_c1];

% p1j ~= p2g scenario; p1j constant
scenario23 = [repmat(high_q,1,3) repmat(equal_p,1,3) repmat(high_p,1,3) equal_c1];
scenario24 = [repmat(high_q,1,3) repmat(equal_p,1,3) repmat(low_p,1,3) equal_c1];
    % c1 > c2
    scenario25 = [repmat(high_q,1,3) repmat(equal_p,1,3) repmat(high_p,1,3) high_c1];
    scenario26 = [repmat(high_q,1,3) repmat(equal_p,1,3) repmat(low_p,1,3) high_c1];    

% pi1 = pi2 ~= pi3; pi1 and pi2 constant
scenario27 = [repmat(high_q,1,3) equal_p equal_p high_p equal_p equal_p high_p equal_c1];
scenario28 = [repmat(high_q,1,3) equal_p equal_p low_p equal_p equal_p low_p equal_c1];
    % c1 > c2
    scenario29 = [repmat(high_q,1,3) equal_p equal_p high_p equal_p equal_p high_p high_c1];
    scenario30 = [repmat(high_q,1,3) equal_p equal_p low_p equal_p equal_p low_p high_c1]; 
    

%% SCENARIO MATRIX

scenarios = nan(30,length(scenario1));

for i = 1:30
    scenarios(i,:) = eval(['scenario' num2str(i)]);
    clear(['scenario' num2str(i)])
end



