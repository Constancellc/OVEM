function prob_tot = cons_pref2(pp,fc,per,fnc,ce,ra,mixed,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra)

%Mixed logit, V.7. M Tran, July 06, 2011

%Objectives:
%1)disaggregate X's 
%2)scale down X's 
%3)test B's 

%%%%%%%%%%%%



 
 
 % simulation_years = 50;
%New X vector: purchase price (pp), fuel consumption (fc), acceleration (per), range (fnc), ...
%carbon emissions (ce), refuelling availiability (ra)
%Use new X values indexed to petrol (see conversion tables)

%%% Reference:  PP(-log), FC(-log), Per(-log), Rang(norm), Env(norm), Refuel(+log): Refuel: Petrol (100%) Diesel (100%) HEV(100%) Ph (1%)EV(1%) FC(0.5%) = 
%%% Reference Prob = ~0.44, 0.25, 0.21, 0.019, 0.068, 0.0059 note: avg: depends on n

%% Initialize X parameters:

%Petrol
ppp = pp(1);  
fcp = fc(1);
perp = per(1);
fncp = fnc(1);
cep = ce(1);  
rap = ra(1);

%Diesel
ppd = pp(2);  
fcd = fc(2);
perd = per(2);
fncd = fnc(2);
ced = ce(2);  
rad = ra(2);

%HEV
pph = pp(3);  
fch = fc(3);
perh = per(3);
fnch = fnc(3);
ceh = ce(3);  
rah = ra(3);

%PHEV
ppph = pp(4);  
fcph = fc(4);
perph = per(4);
fncph = fnc(4);
ceph = ce(4);  
raph = ra(4);

%EV
ppe = pp(5);  
fce = fc(5);
pere = per(5);
fnce = fnc(5);
cee = ce(5);  
rae = ra(5);

%FC
ppfc = pp(6);  
fcfc = fc(6);
perfc = per(6);
fncfc = fnc(6);
cefc = ce(6);  
rafc = ra(6);

%% Define X'
% ppp_ch = zeros(simulation_years+1,1);
% fcp_ch = ppp_ch;
% perp_ch = ppp_ch;
% fncp_ch = ppp_ch;
% cep_ch = ppp_ch;
% rap_ch = ppp_ch;
% 
% ppd_ch = zeros(simulation_years+1,1);
% fcd_ch = ppp_ch;
% perd_ch = ppp_ch;
% fncd_ch = ppp_ch;
% ced_ch = ppp_ch;
% rad_ch = ppp_ch;
% 
% pph_ch = zeros(simulation_years+1,1);
% fch_ch = ppp_ch;
% perh_ch = ppp_ch;
% fnch_ch = ppp_ch;
% ceh_ch = ppp_ch;
% rah_ch = ppp_ch;
% 
%  ppph_ch = zeros(simulation_years+1,1);
% fcph_ch = ppp_ch;
% perph_ch = ppp_ch;
% fncph_ch = ppp_ch;
% ceph_ch = ppp_ch;
% raph_ch = ppp_ch;
% 
% ppe_ch = zeros(simulation_years+1,1);
% fce_ch = ppp_ch;
% pere_ch = ppp_ch;
% fnce_ch = ppp_ch;
% cee_ch = ppp_ch;
% rae_ch = ppp_ch;
% 
% ppfc_ch = zeros(simulation_years+1,1);
% fcfc_ch = ppp_ch;
% perfc_ch = ppp_ch;
% fncfc_ch = ppp_ch;
% cefc_ch = ppp_ch;
% rafc_ch = ppp_ch;
% 
% for i = 1:simulation_years+1

ppp = ppp * 1; %1= no change    
ppp_ch = ppp;  

fcp = fcp * 1;%0.9827; %1.73 p.a.(Factor 0.9827)
fcp_ch = fcp;

perp = perp *1;
perp_ch = perp;

fncp = fncp * 1;
fncp_ch = fncp;

cep = cep * 1;%0.9827;
cep_ch = cep;

rap = rap * 1;
rap_ch = rap;

%end

% %Diesel
% 
% ppd = 1.1374; %/1.3;
% fcd = 0.84;
% perd = 1.5;
% fncd = 1.11;
% ced = 0.875;
% rad = 1;

%for i = 1:simulation_years+1

ppd = ppd * 1; %1= no change    
ppd_ch = ppd;  

fcd = fcd * 1;%0.9827; %1.73 p.a.
fcd_ch = fcd;

perd = perd *1;
perd_ch = perd;

fncd = fncd * 1;
fncd_ch = fncd;

ced = ced * 1;%0.9827; %1.73 p.a.
ced_ch = ced;

rad = rad *1;
rad_ch = rad;

%end

%Hybrid
% pph = 1.6268; %/1.27;
% fch = 0.57; %use split between referenced data sources; 6.2; 4.7
% perh = 1.5;
% fnch = 1.72;
% ceh = 0.750;
% rah = 1;

%for i = 1:simulation_years+1

pph = pph * 1; %1= no change    
pph_ch = pph;  

fch = fch * 1;%0.9820; %1.80 p.a.
fch_ch = fch;

perh = perh *1;
perh_ch = perh;

fnch = fnch * 1;
fnch_ch = fnch;

ceh = ceh * 1;%0.9820; %1.8 p.a.
ceh_ch = ceh;

rah = rah * 1;
rah_ch = rah;

%end

%Plugin hybrid
% ppph = 2.0851; %/1.27; %use split between data Volt 24K and 26K
% fcph = 0.34; %use split between Volt=3.9 and Prius=2.3
% perph = 1.8;
% fncph = 1.13;
% ceph = 0.688;
% raph = 0.01;

%for i = 1:simulation_years+1

ppph = ppph * 1; %1= no change    
ppph_ch = ppph;  

fcph = fcph * 1;%0.9817; %1.83 p.a.
fcph_ch = fcph;

perph = perph *1;
perph_ch = perph;

fncph = fncph * 1;
fncph_ch = fncph;

ceph = ceph * 1;%0.9817; %1.83 p.a.
ceph_ch = ceph;

raph = raph * 1;
raph_ch = raph;

%end

% %Battery electric
% ppe = 2.3645; %/1.27;
% fce = 0.28;
% pere = 1.5;
% fnce = 0.296;
% cee = 0; %note EVs set to zero tailpipe emissions for consistency
% rae = 0.01;

%for i = 1:simulation_years+1

ppe = ppe * 1; %1= no change   
ppe_ch = ppe;  

fce = fce * 1;%0.9814; %1.86 p.a.
fce_ch = fce;

pere = pere *1;
pere_ch = pere;

fnce = fnce * 1;
fnce_ch = fnce;

cee = cee * 1;%0.9814; %1.86 p.a.
cee_ch = cee;

rae = rae * 1;
rae_ch = rae;

%end

%Fuel cell
% ppfc = 3.2345; %/1.27;
% fcfc = 0.39;
% perfc = 2.0;
% fncfc = 0.715;
% cefc = 0;
% rafc = 0.005;

%for i = 1:simulation_years+1

ppfc = ppfc * 1; %1= no change    
ppfc_ch = ppfc;  

fcfc = fcfc * 1;%0.9814; %1.86 p.a. (multiply factor = 0.9814)
fcfc_ch = fcfc;

perfc = perfc *1;
perfc_ch = perfc;

fncfc = fncfc * 1;
fncfc_ch = fncfc;

cefc = cefc * 1;%0.9814; %1.86 p.a.
cefc_ch = cefc;

rafc = rafc * 1;
rafc_ch = rafc;

% end

%Note: have not specified distribution parameters, default is mu=0;sigma = 1

% seed = 1;
% randn('state',1);

%Initialize time step:

% time = [2000:2050]';
% %Initialize B's and loop:
% 
% pet1 = zeros(simulation_years+1,1);
% die1 = pet1;
% hyb1 = pet1;
% phyb1 = pet1;
% ev1 = pet1;
% fc1 = pet1;

if mixed == 1
%% Mixed logit
%Initialize random draws (n increases variance decreases)
n = 10000;  

%for i = 1:simulation_years+1;
    
pet1 = single(exp((sum(-ppp_ch * exp(randn(1,n)),2)/n) + (sum(-fcp_ch * exp(randn(1,n)),2)/n) + (sum(-perp_ch * exp(randn(1,n)),2)/n)...
    + (sum(fncp_ch * (randn(1,n)),2)/n) + (sum(-cep_ch * exp(randn(1,n)),2)/n) + (sum(rap_ch * exp(randn(1,n)),2)/n)));

%pet1(i) = pet(i); %place results in array

die1 = single(exp((sum(-ppd_ch * exp(randn(1,n)),2)/n) + (sum(-fcd_ch * exp(randn(1,n)),2)/n) + (sum(-perd_ch * exp(randn(1,n)),2)/n)...
    + (sum(fncd_ch * (randn(1,n)),2)/n) + (sum(-ced_ch * exp(randn(1,n)),2)/n) + (sum(rad_ch * exp(randn(1,n)),2)/n)));
%die1(i) = die(i);

hyb1 = single(exp((sum(-pph_ch * exp(randn(1,n)),2)/n) + (sum(-fch_ch * exp(randn(1,n)),2)/n) + (sum(-perh_ch * exp(randn(1,n)),2)/n)...
    + (sum(fnch_ch * (randn(1,n)),2)/n) + (sum(-ceh_ch * exp(randn(1,n)),2)/n) + (sum(rah_ch * exp(randn(1,n)),2)/n)));
%hyb1(i) = hyb(i);

phyb1 = single(exp((sum(-ppph_ch * exp(randn(1,n)),2)/n) + (sum(-fcph_ch * exp(randn(1,n)),2)/n) + (sum(-perph_ch * exp(randn(1,n)),2)/n)...
    + (sum(fncph_ch * (randn(1,n)),2)/n) + (sum(-ceph_ch * exp(randn(1,n)),2)/n) + (sum(raph_ch * exp(randn(1,n)),2)/n)));
%phyb1(i) = phyb(i);

ev1 = single(exp((sum(-ppe_ch * exp(randn(1,n)),2)/n) + (sum(-fce_ch * exp(randn(1,n)),2)/n) + (sum(-pere_ch * exp(randn(1,n)),2)/n)...
    + (sum(fnce_ch * (randn(1,n)),2)/n) + (sum(-cee_ch * exp(randn(1,n)),2)/n) + (sum(rae_ch * exp(randn(1,n)),2)/n)));
%ev1(i) = ev(i);

fc1 = single(exp((sum(-ppfc_ch * exp(randn(1,n)),2)/n) + (sum(-fcfc_ch * exp(randn(1,n)),2)/n) + (sum(-perfc_ch * exp(randn(1,n)),2)/n)...
    + (sum(fncfc_ch * (randn(1,n)),2)/n) + (sum(-cefc_ch * exp(randn(1,n)),2)/n) + (sum(rafc_ch * exp(randn(1,n)),2)/n)));
%fc1(i) = fc(i);

%end

%% Simple logit
else

pet1 = single(exp(-ppp_ch*b_pp + -fcp_ch*b_fc + -perp_ch*b_per + fncp_ch*b_fnc ...
    + -cep_ch*b_ce + rap_ch*b_ra));

die1 = single(exp(-ppd_ch*b_pp + -fcd_ch*b_fc + -perd_ch*b_per + fncd_ch*b_fnc ...
    + -ced_ch*b_ce + rad_ch*b_ra));

hyb1 = single(exp(-pph_ch*b_pp + -fch_ch*b_fc + -perh_ch*b_per + fnch_ch*b_fnc ...
    + -ceh_ch*b_ce + rah_ch * b_ra));

phyb1 = single(exp(-ppph_ch*b_pp + -fcph_ch*b_fc + -perph_ch*b_per + fncph_ch*b_fnc ...
    + -ceph_ch*b_ce + raph_ch*b_ra));

ev1 = single(exp(-ppe_ch*b_pp + -fce_ch*b_fc + -pere_ch*b_per + fnce_ch*b_fnc ...
    + -cee_ch*b_ce + rae_ch*b_ra));

fc1 = single(exp(-ppfc_ch*b_pp + -fcfc_ch*b_fc + -perfc_ch*b_per + fncfc_ch*b_fnc ...
    + -cefc_ch*b_ce + rafc_ch * b_ra));

end

%% Define denominator in mixed logit 
 
tech_sum = (pet1 + die1 + hyb1 + phyb1 + ev1 + fc1); %note; placed in column vectors and sum
 

%% Calculate individual probabilities for each technology (moving average over 50 years)
 
%Petrol
Ppet1 = pet1 / tech_sum;

%Diesel
Pdie1 = die1 / tech_sum;
 
%Hybrid
Phyb1 = hyb1 / tech_sum;

%PHEV
Pphyb1 = phyb1 / tech_sum;
 
%EV
Pev1 = ev1 / tech_sum;

%FC
Pfc1 = fc1 / tech_sum;

%matrix of moving average probabilities

prob_tot = [Ppet1 Pdie1 Phyb1 Pphyb1 Pev1 Pfc1];
%time = [time time time time time time];


% plot(time,prob_tot)
% legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')

%tech_mean = mean(prob_tot);    %note: mean of moving average over 50 time steps.
%tech_std = std(prob_tot);  %note std moving average 50 time steps.


                            
                      