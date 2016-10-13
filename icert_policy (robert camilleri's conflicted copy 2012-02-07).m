function [pp_policy,fc_policy,per_policy,fnc_policy,ce_policy,ra_policy,...
    fc_wtw_policy,ce_wtw_policy,prob_tot_with_policy] = icert_policy(pp_no_policy,...
    fc_no_policy,per_no_policy,fnc_no_policy,ce_no_policy,ra_no_policy,...
    fc_wtw_no_policy,ce_wtw_no_policy,~,prob_tot_no_policy,elec_co2_per_kwh1,...
    dynamic_scrap,out_no_policy,mixed_logit,growth_damping,tvs_growth_rate,...
    start_year,end_year,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra)
global CC
global PAMD
global OFAMD
global ELEC
global TVS
global DYNAMIC
global LOGIT
global DAMPING
global OUT1
global OUT2

out_no_policy=OUT1;
elec_co2_per_kwh1=ELEC;

start_year = 2000;
end_year = CC(7);
years = end_year-start_year;
ev_subsidy_vec = zeros(years,1);
hev_subsidy_vec = ev_subsidy_vec;
phev_subsidy_vec = ev_subsidy_vec;
fcv_subsidy_vec = ev_subsidy_vec;
elec_ren_vec = elec_co2_per_kwh1*ones(years,1);
pet_price_vec = ones(years,1);
die_price_vec = pet_price_vec;
ele_price_vec = pet_price_vec;
hyd_price_vec = pet_price_vec;

%% Load fleet information
gr = 0;
tvs_growth_rate = TVS*(1+gr); %where gr is the user-defined TVS growth rate

 %% Technology investment
invest_mat = zeros(years,6);
invest_start_year = [OFAMD(2,3) OFAMD(3,3) OFAMD(4,3) OFAMD(5,3) OFAMD(6,3) OFAMD(7,3)];%[2004 2005 2006 2007 2004 2000];
invest_end_year = [OFAMD(2,4) OFAMD(3,4) OFAMD(4,4) OFAMD(5,4) OFAMD(6,4) OFAMD(7,4)];%[2005 2010 2011 2012 2005 2005];
invest = [OFAMD(2,2) OFAMD(3,2) OFAMD(4,2) OFAMD(5,2) OFAMD(6,2) OFAMD(7,2)]/100;%zeros(6,1);%[20 30 40 50 20 20]/100;

invest_start_index = invest_start_year-start_year+1;
invest_end_index = invest_start_index+invest_end_year-invest_start_year;

for i=1:6
    for j=invest_start_index(i):invest_end_index(i)
        invest_mat(j,i) = invest(i);
    end
end

%% EV subsidy 
ev_subsidy_start_year = PAMD(1,3);%2004;
ev_subsidy_end_year = PAMD(1,4);%2005;
ev_subsidy = PAMD(1,2);%0;

ev_start_index = ev_subsidy_start_year-start_year+1;
ev_end_index = ev_start_index+ev_subsidy_end_year-ev_subsidy_start_year;

ev_subsidy_vec(ev_start_index:ev_end_index) = ev_subsidy;

%% HEV subsidy
hev_subsidy_start_year = PAMD(2,3);%2005;
hev_subsidy_end_year = PAMD(2,4);%2020;
hev_subsidy = PAMD(2,2)%1500;

hev_start_index = hev_subsidy_start_year-start_year+1;
hev_end_index = hev_start_index+hev_subsidy_end_year-hev_subsidy_start_year;

hev_subsidy_vec(hev_start_index:hev_end_index) = hev_subsidy;

%% PHEV subsidy
phev_subsidy_start_year = PAMD(3,3);%2004;
phev_subsidy_end_year = PAMD(3,4);%2005;
phev_subsidy = PAMD(3,2);%0;

phev_start_index = phev_subsidy_start_year-start_year+1;
phev_end_index = phev_start_index+phev_subsidy_end_year-phev_subsidy_start_year;

phev_subsidy_vec(phev_start_index:phev_end_index) = phev_subsidy;

%% FC subsidy
fcv_subsidy_start_year = PAMD(4,3);%2004;
fcv_subsidy_end_year = PAMD(4,4);%2005;
fcv_subsidy = PAMD(4,2);%0;

fcv_start_index = fcv_subsidy_start_year-start_year+1;
fcv_end_index = fcv_start_index+fcv_subsidy_end_year-fcv_subsidy_start_year;

fcv_subsidy_vec(fcv_start_index:fcv_end_index) = fcv_subsidy;

%% User-defined percentage of electricity from non fossil-fuel sources
elec_ren_start_year = OFAMD(1,3);%2004;
elec_ren_end_year =  OFAMD(1,4);%2005;
per_elec_from_nuc_ren =  OFAMD(1,2);%50;
elec_co2_per_kwh = 496;%-579*per_elec_from_nuc_ren/100+609;%*ones(years,1);
%elec_mj_per_kwh = 0.25*ones(years,1);

elec_ren_start_index = elec_ren_start_year-start_year+1;
elec_ren_end_index = elec_ren_start_index+elec_ren_end_year-elec_ren_start_year;

elec_ren_vec(elec_ren_start_index:elec_ren_end_index) = elec_co2_per_kwh;

%% Apply fuel price increases
[pet,die,ele] = fuel_prices(start_year,end_year);

pet_start_year = PAMD(5,3);%2004;
pet_end_year = PAMD(5,4);%2005;
pet_incr = PAMD(5,2)/100;%divide by 100;

pet_start_index = pet_start_year-start_year+1;
pet_end_index = pet_start_index+pet_end_year-pet_start_year;

pet_price_vec(pet_start_index:pet_end_index) = (1+pet_incr);
%pet_price_vec = pet_price_vec.*pet';
%%
die_start_year = PAMD(6,3);%2004;
die_end_year = PAMD(6,4);%2005;
die_incr = PAMD(6,2)/100;

die_start_index = die_start_year-start_year+1;
die_end_index = die_start_index+die_end_year-die_start_year;

die_price_vec(die_start_index:die_end_index) = (1+die_incr);
%die_price_vec = die_price_vec.*die';

%%
hyd_start_year = PAMD(7,3);%2004;
hyd_end_year = PAMD(7,4);%2005;
hyd_incr = PAMD(7,2)/100;

hyd_start_index = hyd_start_year-start_year+1;
hyd_end_index = hyd_start_index+hyd_end_year-hyd_start_year;

hyd_price_vec(hyd_start_index:hyd_end_index) = (1+hyd_incr);
%hyd_price_vec = hyd_price_vec.*pet';

%%
ele_start_year = PAMD(8,3);%2004;
ele_end_year = PAMD(8,4);%2005;
ele_incr = PAMD(8,2)/100;

ele_start_index = ele_start_year-start_year+1;
ele_end_index = ele_start_index+ele_end_year-ele_start_year;

ele_price_vec(ele_start_index:ele_end_index) = (1+ele_incr);
%ele_price_vec = ele_price_vec.*ele';

%% Pre allocation of vectors
pp_norm = zeros(years,6);
fc_norm = pp_norm;
ce_norm = pp_norm;
per_norm = pp_norm;
fnc_norm = pp_norm;
ra_norm = pp_norm;
fc_wtw_norm = pp_norm;
ce_wtw_norm = pp_norm;
prob_tot_with_policy = zeros(years,6);
year_num = zeros(years,6);

%% Apply clean vehicle subsidy
global NOPOLICYPP

pp_no_policy = NOPOLICYPP
pp_policy = pp_no_policy;
hev_subsidy_vec

pp_policy(:,3) = pp_no_policy(:,3)-hev_subsidy_vec;
pp_policy(:,4) = pp_no_policy(:,4)-phev_subsidy_vec;
pp_policy(:,5) = pp_no_policy(:,5)-ev_subsidy_vec;
pp_policy(:,6) = pp_no_policy(:,6)-fcv_subsidy_vec;

%% Change carbon emissions from renewables fraction
global NOPOLICYCE
global NOPOLICYCEWTW

ce_no_policy=NOPOLICYCE;
ce_wtw_no_policy=NOPOLICYCEWTW;

ce_policy = ce_no_policy;
ce_wtw_policy =ce_wtw_no_policy ;

ce_policy(:,5) = ce_no_policy(:,5).* elec_ren_vec./elec_co2_per_kwh1;
ce_wtw_policy(:,5) = ce_wtw_no_policy(:,5).* elec_ren_vec./elec_co2_per_kwh1;

%% Apply fuel price increases
global NOPOLICYFC

fc_no_policy = NOPOLICYFC;
fc_policy = fc_no_policy;

fc_policy(:,1) = fc_no_policy(:,1).*pet_price_vec;
fc_policy(:,2) = fc_no_policy(:,2).*die_price_vec;
fc_policy(:,3) = fc_no_policy(:,3).*pet_price_vec;
fc_policy(:,4) = fc_no_policy(:,4).*pet_price_vec;
fc_policy(:,5) = fc_no_policy(:,5).*ele_price_vec;
fc_policy(:,6) = fc_no_policy(:,6).*hyd_price_vec;

%% No changes to other vehicle attributes
global NOPOLICYPER
global NOPOLICYFNC
global NOPOLICYRA
global NOPOLICYFCWTW

ra_no_policy = NOPOLICYRA;
ra_policy = ra_no_policy;

fnc_no_policy = NOPOLICYFNC;
fnc_policy = fnc_no_policy;

per_no_policy = NOPOLICYPER;
per_policy = per_no_policy;

fc_wtw_no_policy = NOPOLICYFCWTW;
fc_wtw_policy = fc_wtw_no_policy;

for i=1:years
   
%% Initialize time vector
    if i==1;
        year_num(1,1:6) = start_year;
    else
        year_num(i,1:6) = start_year-1+i;
    end
    
%% Normalize to petrol;
pp_norm(i,:) = pp_policy(i,:)/pp_policy(i,1);
fc_norm(i,:) = fc_policy(i,:)/fc_policy(i,1);
per_norm(i,:) = per_policy(i,:)/per_policy(i,1);
fnc_norm(i,:) = fnc_policy(i,:)/fnc_policy(i,1);
ce_norm(i,:) = ce_policy(i,:)/ce_policy(i,1);
ra_norm(i,:) = ra_policy(i,:)/ra_policy(i,1);
fc_wtw_norm(i,:) = fc_wtw_policy(i,:)/fc_wtw_policy(i,1);
ce_wtw_norm(i,:) = ce_wtw_policy(i,:)/ce_wtw_policy(i,1);



%% User defined betas
b_pp = CC(1);%10;
b_fc = CC(2);%5;
b_per = CC(3);%5;
b_fnc = CC(4);%4;
b_ce = CC(5);%3;
b_ra = CC(6);%2;

%% Determine consumer preference probabilities at each time step
mixed_logit=LOGIT
prob_tot_with_policy(i,:) = cons_pref2(pp_norm(i,:),fc_norm(i,:),per_norm(i,:),...
    fnc_norm(i,:),ce_norm(i,:),ra_norm(i,:),mixed_logit,b_pp,b_fc,b_per,b_fnc,...
    b_ce,b_ra);

%% Check for Q trigger conditions
% tot_batt_kwh(i) = batt_cap_no_policy(i,:)*prob_tot_with_policy(i,:)';
% 
% sum(tot_batt_kwh)
% tot_batt_kwh(1)
% sum(dbl_batt)
% if sum(tot_batt_kwh)>tot_batt_kwh(1)*2^sum(dbl_batt);
%     %Doubling of Q
%     dbl_batt(i) = 1;
%     batt_cost(i:end) = batt_cost(i)* (1-batt_cost_lr)^(sum(dbl_batt)); %Replace remainder of batt-cost vector with new batt_cost;
% else batt_cost(i:end) = batt_cost(i);
%     dbl_batt(i) = 0;
% end

end
toc


%% Plot vehicle stock growth to end of simulation horizon
growth_damping=DAMPING;
dynamic_scrap=DYNAMIC;

[~,out] = diff_curve2(tvs_growth_rate,prob_tot_with_policy,years,dynamic_scrap,...
    growth_damping,invest_mat);

OUT2=out;

%% Find km per vehicle

% km_coeff = polyfit(annual_km(:,1),annual_km(:,2)*10^9,1);
% km_line = polyval(km_coeff,year_num(:,1));
% %km_line = 15000*ones(length(year_num(:,1)),1);
% annual_km_per_veh = km_line./out(:,1);
% upper_km_per_vehicle = 45000;%2*annual_km_per_veh(5);
% 
% for i=1:length(years)+1
%     if annual_km_per_veh(i)>upper_km_per_vehicle;
%         annual_km_per_veh(i)=upper_km_per_vehicle;
%     else
%     end
% end

%%
%total annaul km will be proportional to number of vehicles on the road per
%technology type and inversely proportional to refuelling availability.
% his_dat(3,:);
% g_per_km(:,2);



if dynamic_scrap == 1
    new_tvs = out;
    [net_tvs,scrap_tvs] = dyn_scrap2(new_tvs);
    %[net_tvs,scrap_tvs,total_mj,total_co2] = dyn_scrap3(new_tvs,annual_km_per_veh,ra,mj_per_km,ce_norm);
    total_scrap = sum(scrap_tvs,2);
    out = [sum(net_tvs,2) net_tvs];%net_tvs

else

end
%     total_mj = ene_his(out(:,2:end),annual_km_per_veh,ra,mj_per_km)/10^5;
%     total_co2 = emm_his(out(:,2:end),annual_km_per_veh,ra,ce_norm);
%% Add in emissions and energy use, cf current fleet.
% - take scrappage rate, spread equally across the probability of set of technologies in a
% given year

% - calculate fleet emissions, energy use and cost/km transport.

%% Outputs
% Prob, TVS, emissions, energy

% fleet_tot_mj = total_mj/10^5;
% fleet_tot_co2 = total_co2/10^12;
% fleet_km_per_veh = total_co2./km_line;

% figure(4)
% subplot(2,2,1)
% plot(year_num(:,1),total_mj/10^5,'MarkerSize',8,'LineWidth',2)
% %hold on
% %plot(his_dat(1,:),his_dat(2,:)*41868*10^6/10^3,'r','MarkerSize',8,'LineWidth',2)
% xlabel('Year')
% ylabel('Total fuel energy used by fleet (GJ)')
% %legend('Projected','Actual')
% xlim([start_year end_year])
% hold off
% 
% subplot(2,2,2)
% plot(year_num(:,1),total_co2/10^12,'MarkerSize',8,'LineWidth',2)
% %hold on
% %plot(his_dat(1,:),his_dat(3,:),'r','MarkerSize',8,'LineWidth',2)
% xlabel('Year')
% ylabel('Total CO2 emissions from fleet (Mt)')
% xlim([start_year end_year])
% %legend('Projected','Actual')
% hold off
% 
% subplot(2,2,3)
% %plot(annual_km(:,1),annual_km(:,2)*10^9./(TVS_tot(:,2)*1000),'MarkerSize',8,'LineWidth',2)
% %hold on
% plot(year_num(:,1),km_line./out(:,1),'MarkerSize',8,'LineWidth',2)
% xlabel('Year')
% ylabel('Annual vehicle kilometres travelled (veh-km)')
% xlim([start_year end_year])
% %legend('Projected','Actual')
% hold off
% 
% subplot(2,2,4)
% %plot(g_per_km(:,1),g_per_km(:,2),'MarkerSize',8,'LineWidth',2)
% %hold on
% plot(year_num(:,1),total_co2./km_line,'MarkerSize',8,'LineWidth',2)
% xlabel('Year')
% xlim([start_year end_year])
% ylabel('Average new car emissions (g CO2/km)')
% %legend('Projected','Actual')
% hold off

% tot_batt_kwh = cumsum(tot_batt_kwh);
% cum_batt_cost = batt_cost;
% cumsum_dbl_batt = cumsum(dbl_batt);

% figure(5)
% subplot(3,1,1)
% plot(year_num(:,1),cumsum(tot_batt_kwh),'MarkerSize',8,'LineWidth',2)
% xlabel('Time')
% ylabel('Cumulative battery demand (kWh)')
% 
% subplot(3,1,2)
% plot(year_num(:,1),batt_cost,'MarkerSize',8,'LineWidth',2)
% xlabel('Time')
% ylabel('Battery cost (€/kWh)')
% 
% subplot(3,1,3)
% plot(year_num(:,1),cumsum(dbl_batt),'MarkerSize',8,'LineWidth',2)
% xlabel('Time')
% ylabel('Binary variable representing the doubling of cumulative battery demand')

global PROBTOT
prob_tot_no_policy=PROBTOT
global PROBTOTWP
PROBTOTWP=prob_tot_with_policy

global POLICYOK
POLICYOK=[1];

global TIME
global YEAR


%figure(3)
%plot(year_num,prob_tot_with_policy,'-','MarkerSize',8,'LineWidth',2)
%hold on
%plot(year_num,prob_tot_no_policy,'--','MarkerSize',8,'LineWidth',2)
%legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
%xlabel('Time')
%ylabel('Probability')
%hold off

time = [year_num year_num(:,1)];
TIME=time;
YEAR=year_num;

% figure(6)
% bar(time(:,1:6),abs_veh_stock,'stacked')
% legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
% xlabel('Time')
% ylabel('Number of new vehicles added to the total vehicle stock per year')

%figure(2)
%plot(time(:,1),out(:,1),'k-','MarkerSize',8,'LineWidth',2)
%hold on
%plot(time(:,2:end),out(:,2:end),'-','MarkerSize',8,'LineWidth',2)
%hold on
%plot(time(:,1),out_no_policy(:,1),'k--','MarkerSize',8,'LineWidth',2)
%hold on
%plot(time(:,2:end),out_no_policy(:,2:end),'--','MarkerSize',8,'LineWidth',2)
%legend('Total Vehicle Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
%title('Technology diffusion based on high investment into low carbon vehicles and evolving consumer choice due to increasing engine efficiency and lower carbon emissions')
%xlabel('Years')
%ylabel('Total number of vehicles per technology')
%hold off
