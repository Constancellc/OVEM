function [pp,fc,per,fnc,ce,ra,fc_wtw,ce_wtw,med_batt_cap,mj_km,vehmass] = ...
    ovem3(batt_cost_kwh,fuel_cost_petrol,fuel_cost_diesel,fuel_cost_kwh,...
    di_map,si_turbo_map,si_map,ele_map,v_req,t,slope,distance_req,...
    distance_req_alt,timestep,drive_cycle_length,elec_co2_per_kwh,elec_mj_per_kwh,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    Cd,Af,rho_air,glider_mass,Crr,elec_brake_state,gearbox_type,min_w,min_n_w,...
    max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    simulate,peak_ice_T_2,peak_ice_w_2,w_at_peak_T,max_P,powertrain_type,...
    number_of_motors,front_or_rear_wheel_drive,dynamic_braking,wheelbase,...
    fuel_tank,h,range_km,overall_mass_fac,batt_V,old_ice_cost,cap_cost,~,...
    ~,range1,mj_die_km,fc_kw,e_motor_peak_T,motor_selection,ESS1_selection,...
    ESS2_selection)
 
% di_map = xlsread('C:\Users\Chris\Documents\Justin\OVEM\die_map');
% si_turbo_map = xlsread('C:\Users\Chris\Documents\Justin\OVEM\si_turbo_map');
% si_map = xlsread('C:\Users\Chris\Documents\Justin\OVEM\si_map');

%% Header

% This function takes pre-loaded vehicle parameters for the unique vehicle
% types under study and passes them through the OVEM Level 2 model.

%The outputs are:  median conversion efficiency, fuel consumed, TTW and WTW
%fuel and carbon efficiency and running costs per 12000 mi.

% Created 11 November 2009 (Justin Bishop)

%% Load vehicle parameters

%Powertrain types: 1 = EV; 2 = series HEV; 3 = parallel HEV; 4 = dual HEV;
%5 = pure ICE

%ICE types = 5 for natural-aspirated PISI; 6 for turbo-charged DICI; 7 for
%turbo-charged PISI or 8 for super-charged PISI

%ICE types = 9 for natural-aspirated DISI; 10 for turbo-charged DISI; 11 for
%turbo-charged DISI or 12 for super-charged DISI

%Hybrid types: 2 = series PISI HEV; 3 = parallel PISI HEV; 4 = dual PISI HEV; 
%9 = series DISI HEV; 10 = parallel DISI HEV; 11 = dual DISI HEV; 12 =
%series DICI HEV; 13 parallel DICI HEV; 14 = dual DICI HEV;

%FC types: 15 = pure FC EV; 16 = series FC HEV; 17 = parallel FC HEV; 18 =
%dual FC HEV; 19 = pure FC + reformer; 20 = series FC + reformer HEV; 21 =
%parallel FC + reformer HEV; 22 = dual FC + reformer HEV;

%PHEV types: 23 = series PISI PHEV; 24 = parallel PISI PHEV; 25 = dual PISI PHEV; 
%26 = series DISI PHEV; 27 = parallel DISI PHEV; 28 = dual DISI PHEV; 29 =
%series DICI PHEV; 30 parallel DICI PHEV; 31 = dual DICI PHEV;

%% Vehicle inputs: mini, smini, l med, u med, exec, lux, sports, suv, mpv

% test_mass = single(180);%driver
% glider_mass = single([925 966 1327 1515 1575 1970 1318 1647 1613]);
% glider_mass = glider_mass + test_mass;
% rho_air=single(1.2);%Density of air
% Crr= single([0.0085 0.0099 0.0106 .0096 .0096 .0096 .0096 .0096 .0096]);
% Cd = single([0.32 0.32 0.32 0.27 0.25 0.26 0.34 0.32 0.31]);  
% Af = single([1.97 2.04 2.05 2.17 2.05 2.21 2.14 2.44 2.45]);
%     
% tire_dia_in=[14 16 16 17 16 17 17 17 16]; %in
% tire_radius = single(tire_dia_in.*2.54/100/2);
% 
% top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
% final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];
% top_gear_number = [5 5 5 6 6 7 6 6 6];
% peak_ice_T_2 = [98 125 185 400 360 500 280 350 280];
% peak_ice_w_2 = single(9000*ones(1,9));
% w_at_peak_T = single([2800 4200 4250 2000 2100 1700 3450 2000 2300]);
% 
% max_n_w = w_at_peak_T;
% min_n_w = max_n_w;
% min_w = 1000*ones(1,9);%w_at_peak_T;
% max_P = [49 70.5 104.4 145 99.9 149.9 154.7 110 92];
% 
% number_of_driven_wheels = [2 2 2 2 2 2 2 4 2];
% motor_in_or_out_of_wheel = zeros(1,9);
% elec_brake_state= zeros(1,9);
% gearbox_type= ones(1,9);
% 
% 
% % Actual performance
% %fuel_eff = [5 5.7 7.1 6.1 6.1 8 7.5 6.5 6];l/100km
 mj_eff = [174 198 247 235 235 309 261 251 232];%MJ/100km
% %mpg = [57 50 40 46 46 34 38 44 47];
% ttw_ghg = [119 133 169 160 160 221.5 174 173 159];
% %op_cost 
% cap_cost = [8340 11995 17795 25920 25770 58440 23615 22880 21465];
% 
% front_or_rear_wheel_drive = [1 1 1 0 0 0 1 0 1];
% dynamic_braking = zeros(1,9);
% number_of_motors = ones(1,9);
% gear_ratio_vector = [3.545 1.894 1.192 .853 .719 1;
%                     3.58 1.93 1.28 0.95 0.76 1;
%                     1 1 1 1 1 1;
%                     5.08 2.804 1.783 1.26 1 .835 ;
%                     1 1 1 1 1 1;
%                     1 1 1 1 1 1;
%                     1 1 1 1 1 1;
%                     3.9333 2.037 1.189 .928 .777 .653;
%                     1 1 1 1 1 1 ];
% simulate = ones(1,9);%[0 0 1 0 1 1 1 0 1];
% wheelbase = [2.38 0 0 0 0 0 0 0 0];
% h = 0.3*ones(1,9); %height of the vehicle centre of mass
% fuel_tank = [35 0 0 0 0 0 0 0 0];
% 
% 
% %5 5 5 6 6 6 7 6 6
% old_ice_cost = max_P.*[23 23 23 27 27 27 27 27 27]*.596; %Assume turbo pisi = turbo dici
% 
% %% Unit conversion
% 
% %RPM to rad/s
% max_n_w = max_n_w*2*pi()/60;
% min_n_w = min_n_w*2*pi()/60;
% min_w = min_w*2*pi()/60;
% peak_ice_w_2 = peak_ice_w_2*2*pi()/60;
% 
% %kW to W
% max_P = max_P*1000;
% 
% %% Pre-allocate matrices
% 
% %pet, die, hyb, phyb, ev, fc = 5, 6, 4, 16, 1, 15
% powertrain_type = [5 5 5 6 6 6 7 6 6;
%     6 6 6 6 6 6 6 6 6;
%     4 4 4 4 4 4 4 4 4;
%     16 16 16 16 16 16 16 16 16 ;
%     1 1 1 1 1 1 1 1 1;
%     15 15 15 15 15 15 15 15 15];
%     %2 2 2 2 2 2 2 2 2];
% 
% cv_range = 950;
% ev_range = 100;
% phev_aer = 50;
% hev_aer = 0.00399*cv_range;
% range_km = [cv_range*ones(1,9); 
% cv_range*ones(1,9); 
% hev_aer*ones(1,9); 
% phev_aer*ones(1,9);
% ev_range*ones(1,9);
% hev_aer*ones(1,9)];
% %hev_aer*ones(1,9)];
%     
[r,c] = size(powertrain_type);
total_driven_wheelaxle_inertia = single(zeros(c,r));
dist_km = total_driven_wheelaxle_inertia;
%fuel_ice = total_driven_wheelaxle_inertia;
%fuel_motor = total_driven_wheelaxle_inertia;
%pack_size = total_driven_wheelaxle_inertia;
%med_eff = total_driven_wheelaxle_inertia;
max_motor_P = total_driven_wheelaxle_inertia;
max_ice_P = total_driven_wheelaxle_inertia;

ghg_per_km = total_driven_wheelaxle_inertia;
batt_cost = total_driven_wheelaxle_inertia;
%ice_cost = total_driven_wheelaxle_inertia;
motor_cost = total_driven_wheelaxle_inertia;
run_cost = total_driven_wheelaxle_inertia;
mj_per_km = total_driven_wheelaxle_inertia;
mj_wtw = total_driven_wheelaxle_inertia;
ghg_wtw = total_driven_wheelaxle_inertia;
med_ice_eff = total_driven_wheelaxle_inertia;
med_motor_eff = total_driven_wheelaxle_inertia;
med_fc_eff = total_driven_wheelaxle_inertia;
fuel_ice = total_driven_wheelaxle_inertia;
fuel_motor = total_driven_wheelaxle_inertia;
fuel_fc = total_driven_wheelaxle_inertia;
max_fc_P = total_driven_wheelaxle_inertia;
batt_cap = total_driven_wheelaxle_inertia;
new_ice_cost = total_driven_wheelaxle_inertia;
new_cap_cost = total_driven_wheelaxle_inertia;
gb_cost = total_driven_wheelaxle_inertia;
fc_cost = total_driven_wheelaxle_inertia;
final_veh_mass = total_driven_wheelaxle_inertia;

regen_var = 1;

%% OVEM

wait = waitbar(0,'Calculating. Please wait...');


for i=3:4%columns, SMMT
for j=1:r%rows, powertrain

%    mj_die_km(i) = 0.75; %need to fix this bit later
    
total_driven_wheelaxle_inertia(i,j)=wheel_axle_inertia(motor_in_or_out_of_wheel(i),...
    number_of_driven_wheels(i),tire_radius(i));

[dist_km(i,j),fuel_ice(i,j),fuel_motor(i,j),fuel_fc(i,j),med_ice_eff(i,j),med_motor_eff(i,j),med_fc_eff(i,j),...
    max_motor_P(i,j),max_ice_P(i,j),max_fc_P(i,j),batt_cap(i,j),final_veh_mass(i,j)] = level_3_ttw(v_req,t,timestep,drive_cycle_length,...
    slope,Cd(i),Af(i),rho_air,glider_mass(i),Crr(i),total_driven_wheelaxle_inertia(i,j),motor_in_or_out_of_wheel(i),...
    number_of_driven_wheels(i),tire_radius(i),elec_brake_state(i),gearbox_type(i),min_w(i),min_n_w(i),...
    max_n_w(i),top_gear_number(i),top_gear_ratio(i),gear_ratio_vector(i,:),final_drive_ratio(i),simulate(i),...
    peak_ice_T_2(i),peak_ice_w_2(i),w_at_peak_T(i),max_P(i),powertrain_type(j,i),number_of_motors(i),...
    front_or_rear_wheel_drive(i),dynamic_braking(i),wheelbase(i),distance_req,distance_req_alt,fuel_tank(i),...
    h(i),range_km(j,i),di_map,si_map,si_turbo_map,ele_map,overall_mass_fac,batt_V,range1(i),mj_die_km(i),fc_kw(i),...
    e_motor_peak_T(i),motor_selection,ESS1_selection,ESS2_selection,regen_var);

[ghg_per_km(i,j),batt_cost(i,j),new_ice_cost(i,j),motor_cost(i,j),fc_cost(i,j),run_cost(i,j),gb_cost(i,j),mj_per_km(i,j),...
    mj_wtw(i,j),ghg_wtw(i,j)] = level_2_outputs(dist_km(i,j),fuel_ice(i,j),fuel_motor(i,j),fuel_fc(i,j),...
    powertrain_type(j,i),max_P(i),range_km(j,i),max_motor_P(i,j),max_ice_P(i),max_fc_P(i),top_gear_number(i),...
    peak_ice_T_2(i),fuel_cost_petrol,fuel_cost_diesel,fuel_cost_kwh,batt_cap(i,j),batt_cost_kwh,elec_co2_per_kwh,...
    elec_mj_per_kwh);

new_cap_cost(i,j) = cap_cost(i) + batt_cost(i,j) + new_ice_cost(i,j) + motor_cost(i,j) + fc_cost(i,j) ...
    + gb_cost(i,j) - old_ice_cost(i);
    
end
waitbar(i/c)
end
 close(wait)
%% Outputs
%
%median(max_motor_P(3:4,:)) %max_ice_P batt_cap]

% [mj_per_km(1,1) mj_eff(1,1) abs((mj_eff(1,1)-mj_per_km(1,1))/mj_eff(1,1))]
%[ghg_per_km(1,1) ttw_ghg(1,1) abs((ttw_ghg(1,1)-ghg_per_km(1,1))/ttw_ghg(1,1))]
%med_ice_eff

%[mj_per_km(:,1) mj_eff' ((mj_eff'-mj_per_km(:,1))./mj_eff')]
%[ghg_per_km(:,1) ttw_ghg' abs((ttw_ghg'-ghg_per_km(:,1))./ttw_ghg')];
% [mj_per_km mj_wtw]
% [ghg_per_km ghg_wtw]
% 
 %  new_cap_cost
%   run_cost*100
    %ghg_per_km;
%    mj_wtw
%  ghg_wtw
  %   mj_per_km
   %batt_cap
%   new_cap_cost

%mj_ev_eff = mj_per_km(:,1)./mj_per_km(:,5)


%   mj_per_km
% for i=1:c
%    for j=1:r
%     %per_mj_inc(i,j) = (mj_per_km(i,j)-mj_per_km(i,1))./mj_per_km(i,1);
%     %per_cost_inc(i,j) = (new_cap_cost(i,j) - new_cap_cost(i,1))./new_cap_cost(i,1);
%     
%     per_mj_inc(i,j) = (mj_per_km(i,j)-mj_eff(i))./mj_eff(i);
%     per_cost_inc(i,j) = (new_cap_cost(i,j) - cap_cost(i))./cap_cost(i);
%     
%    end
% end
% 
% per_mj_inc;
% per_cost_inc;
% mj_inc_per_cost_inc = per_mj_inc./per_cost_inc;

%median(abs((mj_eff'-mj_per_km(:,1))./mj_eff'))

% [mj_per_km(1,:)' mj_eff']
% 
% [ghg_per_km(1,:)' ttw_ghg']

%New X vector: purchase price (pp), fuel consumption (fc), acceleration (per), range (fnc), carbon emissions (ce), refuelling availiability (ra)
%Use new X values indexed to petrol (see conversion tables)


%% Output for lower medium 
% pp = cap_cost(3)/cap_cost(1);
% fc = mj_per_km(3)/mj_per_km(1);
% per = 1;
% fnc = range_km(3)/range_km(1);
% ce = ghg_per_km(3)/ghg_per_km(1);
% ra = 1;


%Diesel
% perd = 1.5;
% fncd = 1.11;
% rad = 1;
% 
% %Hybrid
% perh = 1.5;
% fnch = 1.72;
% rah = 1;
% 
% %Plugin hybrid
% perph = 1.8;
% fncph = 1.13;
% raph = 0.01;
% 
% %EV
% pere = 1.5;
% fnce = 0.296;
% rae = 0.01;
% 
% %FC
% perfc = 2.0;
% fncfc = 0.715;
% rafc = 0.005;

%% All output (= median of lower medium and upper medium)


% capcost = cap_cost(3:4)
% battcost = batt_cost(3:4,:)
% newicecost = new_ice_cost(3:4,:)
% motorcost = motor_cost(3:4,:)
% fccost = fc_cost(3:4,:)
% gbcost = gb_cost(3:4,:)
% oldicecost = old_ice_cost(3:4)

pp = median(new_cap_cost(3:4,:));
fc = median(run_cost(3:4,:));
per = [1 1.5 1.5 1.8 1.5 2];
fnc = [1 1.11 1.72 1.13 .296 .715];%median(range_km(3:4,:));
ce = median(ghg_per_km(3:4,:));
ra = [1 1 1 0.01 0.01 0.005];
fc_wtw = median(mj_wtw(3:4,:));%wtw
ce_wtw = median(ghg_wtw(3:4,:));%wtw
med_batt_cap = median(batt_cap(3:4,:));
mj_km = median(mj_per_km(3:4,:));
vehmass = median(final_veh_mass(3:4,:));

