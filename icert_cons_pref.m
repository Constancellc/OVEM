function [pp,fc,per,fnc,ce,ra,fc_wtw,ce_wtw,batt_cap,mj_per_km,prob_tot,...
    elec_co2_per_kwh1,dynamic_scrap,out,mixed_logit,growth_damping,...
    tvs_growth_rate,start_year,end_year,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra] = icert_cons_pref

global CC
start_year = 2000;
end_year = CC(7)+1;
years = end_year-start_year;
batt_cost = 1000*ones(years,1);

global TVS_GR
global MXD_LGT
mixed_logit = 0;
MXD_LGT = mixed_logit;

global DYN_SCR
dynamic_scrap = 0;
DYN_SCR = dynamic_scrap;

global GRW_DAM
growth_damping = 1;
GRW_DAM = growth_damping;

tvs_growth_rate = 1.012; %where gr is the user-defined TVS growth rate
TVS_GR = tvs_growth_rate;
invest_mat = zeros(years,6);

%% Load engine maps
di_map = single(xlsread('die_map.xls'));
si_turbo_map = single(xlsread('si_turbo_map.xls'));
si_map = single(xlsread('si_map.xls'));
ele_map = single(xlsread('ele_map.xls'));

max_di_eff = max(max(di_map));
max_ele_eff = max(max(ele_map));

[r,c,~] = find(max_ele_eff>95);
max_ele_eff(r,c) = 95;

%% Load drive cycle information
drive_cycle_selection=1;%input('Enter the drive cycle selection: ');
number_of_drive_cycles=1;%input('Enter the number of drive cycles: ');
[v_req,t,slope,distance_req,distance_req_alt,timestep,~,drive_cycle_length]=...
   drive_cycle_3(drive_cycle_selection,number_of_drive_cycles);

%% Load vehicle characteristics
[motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    Cd,Af,rho_air,glider_mass,Crr,elec_brake_state,gearbox_type,min_w,min_n_w,...
    max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    simulate,peak_ice_T_2,peak_ice_w_2,w_at_peak_T,max_P,powertrain_type,...
    number_of_motors,front_or_rear_wheel_drive,dynamic_braking,wheelbase,...
    fuel_tank,h,range_km,overall_mass_fac,batt_V,old_ice_cost,cap_cost,mj_eff,...
    ttw_ghg,range1,mj_die_km,fc_kw,e_motor_peak_T,motor_selection,ESS1_selection,...
    ESS2_selection] = load_veh_para(v_req,t,timestep,drive_cycle_length,slope,...
    distance_req,distance_req_alt,di_map,max_di_eff,max_ele_eff);

%% Timing Triggers
[pet,die,ele] = fuel_prices(start_year,end_year);

% fuel_cost_kwh = .09; %£/kWh:  Structural indicator for UK 2007 electricity 
% %prices for households consuming 3500 kwh annually, of which 1300 kwh are 
% %at night.  See Eurostat table nrg_pc_priceind
% 
% fuel_cost_petrol = 1.076; %Use 1,076 £/l operating cost for petrol in Apr 2008, based on 
% %DfT Transport Statistics GB 2008, ss 3, Table 3,3 for petrol including
% %taxes
% 
% fuel_cost_diesel = 1.166; %Use 1,166 £/l operating cost for diesel in Apr 2008, based on 
% %DfT Transport Statistics GB 2008, ss 3, Table 3,3 for diesel including
% %taxes
% 
% pet = fuel_cost_petrol*ones(years,1);
% die = fuel_cost_diesel*ones(years,1);
% ele = fuel_cost_kwh*ones(years,1);

%% User defined betas
b_pp = CC(1);%10;
b_fc = CC(2);%5;
b_per = CC(3);%5;
b_fnc = CC(4);%4;
b_ce = CC(5);%3;
b_ra = CC(6);%2;
%% Run OVEM
year_num = zeros(years,6);
tic

global ELE_CO2
elec_co2_per_kwh1 = 496;
ELE_CO2 = elec_co2_per_kwh1;
elec_mj_per_kwh1 = 0.25*3.6;

for i=1:years
    
%% Initialize time vector
    if i==1;
        year_num(1,1:6) = start_year;
    else
        year_num(i,1:6) = start_year-1+i;
    end
end
    
%% Pre allocation of vectors
pp = ones(years,6);
pp_norm = pp;
fc_norm = pp;
per = pp;
fnc = pp;
ce_norm = pp;
ra = pp;
fc_wtw_norm = pp;
ce_wtw_norm = pp;
per_norm = pp;
fnc_norm = pp;
ra_norm = pp;
fc = pp;
ce = pp;
fc_wtw = pp;
ce_wtw = pp;
prob_tot = pp;
batt_cap = pp;
mj_per_km = pp;

%% Find vehicle performance
[pp_vec,fc_vec,per_vec,fnc_vec,ce_vec,ra_vec,fc_wtw_vec,ce_wtw_vec,batt_cap_vec,mj_per_km_vec] ...
    = ovem3(batt_cost(1),pet(1),die(1),ele(1),di_map,si_turbo_map,si_map,ele_map,v_req,t,slope,distance_req,...
    distance_req_alt,timestep,drive_cycle_length,elec_co2_per_kwh1,elec_mj_per_kwh1,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    Cd,Af,rho_air,glider_mass,Crr,elec_brake_state,gearbox_type,min_w,min_n_w,...
    max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    simulate,peak_ice_T_2,peak_ice_w_2,w_at_peak_T,max_P,powertrain_type,...
    number_of_motors,front_or_rear_wheel_drive,dynamic_braking,wheelbase,...
    fuel_tank,h,range_km,overall_mass_fac,batt_V,old_ice_cost,cap_cost,mj_eff,...
    ttw_ghg,range1,mj_die_km,fc_kw,e_motor_peak_T,motor_selection,ESS1_selection,...
    ESS2_selection);


for i=1:years
%% Expand vehicle attributes
pp(i,:) = pp_vec;
fc(i,:) = fc_vec;
per(i,:) = per_vec;
fnc(i,:) = fnc_vec;
ce(i,:) = ce_vec;
ra(i,:) = ra_vec;
fc_wtw(i,:) = fc_wtw_vec;
ce_wtw(i,:) = ce_wtw_vec;
batt_cap(i,:) = batt_cap_vec;
mj_per_km(i,:) = mj_per_km_vec;

%% Apply fuel costs
fc(i,1) = fc(i,1)*pet(i)/pet(1);
fc(i,2) = fc(i,2)*die(i)/die(1);
fc(i,3) = fc(i,3)*pet(i)/pet(1);
fc(i,4) = fc(i,4)*pet(i)/pet(1);
fc(i,5) = fc(i,5)*ele(i)/ele(1);
fc(i,6) = fc(i,6)*pet(i)/pet(1);
   

%% Normalize to petrol;
pp_norm(i,:) = pp(i,:)/pp(i,1);
fc_norm(i,:) = fc(i,:)/fc(i,1);
per_norm(i,:) = per(i,:)/per(i,1);
fnc_norm(i,:) = fnc(i,:)/fnc(i,1);
ce_norm(i,:) = ce(i,:)/ce(i,1);
ra_norm(i,:) = ra(i,:)/ra(i,1);
fc_wtw_norm(i,:) = fc_wtw(i,:)/fc_wtw(i,1);
ce_wtw_norm(i,:) = ce_wtw(i,:)/ce_wtw(i,1);
    
prob_tot(i,:) = cons_pref2(pp_norm(i,:),fc_norm(i,:),per_norm(i,:),fnc_norm(i,:),...
    ce_norm(i,:),ra_norm(i,:),mixed_logit,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra);

prob_tot_mixed_logit(i,:) = cons_pref2(pp_norm(i,:),fc_norm(i,:),per_norm(i,:),fnc_norm(i,:),...
    ce_norm(i,:),ra_norm(i,:),1,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra);

end

% pp_norm,fc_norm,per_norm,fnc_norm,...
%     ce_norm,ra_norm,mixed_logit,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra

global PP_NP
global FC_NP
global CE_NP
global CE_WTW_NP
global RA_NP
global FNC_NP
global PER_NP
global FC_WTW_NP
 
PP_NP = pp;
FC_NP = fc;
PER_NP = per;
FNC_NP = fnc;
CE_NP = ce;
RA_NP = ra;
FC_WTW_NP = fc_wtw;
CE_WTW_NP = ce_wtw;


%% Plot vehicle stock growth to end of simulation horizon
[~,out] = diff_curve2(tvs_growth_rate,prob_tot,years,dynamic_scrap,...
    growth_damping,invest_mat);

[~,out_mixed_logit] = diff_curve2(tvs_growth_rate,prob_tot_mixed_logit,years,dynamic_scrap,...
    growth_damping,invest_mat);

if dynamic_scrap == 1
    new_tvs = out;
    [net_tvs,scrap_tvs] = dyn_scrap2(new_tvs);
    total_scrap = sum(scrap_tvs,2);
    out = [sum(net_tvs,2) net_tvs];%net_tvs

else
    
end

global CONSUMEROK
global PROBTOT
global OUT_NP
global PROBTOT_ML
global OUT_ML
OUT_NP = out;
OUT_ML = out_mixed_logit;
PROBTOT_ML = prob_tot_mixed_logit;

PROBTOT=prob_tot;
CONSUMEROK=1;

% figure(1)
% plot(year_num,prob_tot,'MarkerSize',8,'LineWidth',2)
% legend('Petrol','Diesel','Hybrid','Plugin Hybrid','Battery Electric','Fuel cell')
% xlabel('Time')
% ylabel('Probability')
% hold off
