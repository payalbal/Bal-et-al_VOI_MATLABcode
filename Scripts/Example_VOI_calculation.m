format long

global s t Bmax c1 c2 q Start_m1 pr_prob B
s = 3;
t = 2;
Start_m1 = 100;
Bmax = 100;
c1 = 0.5*Bmax;
c2 = Bmax-c1;
q = [0.01, 0.01, 0.01];


pr_prob = [];
pr_prob (1:3)= [0.75 0.5 0.25];
pr_prob(4:6) = [0.75 0.5 0.25];

B = 0:10:Bmax;

all_mods = build_set(s,t);
mod_prob_all = get_mod_prob(all_mods, pr_prob);

temp = get_VOI(B, all_mods, q, pr_prob, c1, c2, Start_m1);
evpi = temp(:,1);

% Optimal strategies for each
nonexp1 = max(temp(:,2:4),[],2);
nonexp2 = max(temp(:,5:7),[],2);
exp1 = max(temp(:,8:13),[],2);
exp2 = max(temp(:,14:19),[],2);

figure()
plot(B,[evpi,nonexp1, nonexp2, exp1, exp2])

