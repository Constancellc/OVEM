function [motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    Cd,Af,rho_air,glider_mass,Crr,elec_brake_state,gearbox_type,min_w,min_n_w,...
    max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    simulate,peak_ice_T_2,peak_ice_w_2,w_at_peak_T,max_P,powertrain_type,...
    number_of_motors,front_or_rear_wheel_drive,dynamic_braking,wheelbase,...
    fuel_tank,h,range_km,overall_mass_fac,batt_V,old_ice_cost,cap_cost,mj_eff,...
    ttw_ghg,range1,mj_die_km,fc_kw,e_motor_peak_T,motor_selection,ESS1_selection,...
    ESS2_selection] = load_veh_para(v_req,t,timestep,drive_cycle_length,slope,...
    distance_req,distance_req_alt,di_map,max_di_eff,max_ele_eff)

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

%% 2010 Vehicle inputs: mini, smini, l med, u med, exec, lux, sports, suv, mpv

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
% mj_eff = [174 198 247 235 235 309 261 251 232];%MJ/100km
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
% old_ice_cost = max_P.*[23 23 23 27 27 27 27 27 27]*.596; %Assume turbo pisi = turbo dici

%% 2011 Vehicle inputs: mini, smini, l med, u med, exec, lux, sports, suv, mpv

test_mass = single(180);%driver
glider_mass = single([925 966 1190 1515 1575 1796 1318 1770 1613]);
glider_mass = glider_mass + test_mass;
rho_air=single(1.2);%Density of air
Crr= single([0.0085 0.0099 0.0106 .0096 .0096 .0096 .0096 .0096 .0096]);
Cd = single([0.32 0.33 0.32 0.27 0.25 0.29 0.34 0.39 0.31]);  
Af = single([1.97 2.04 2.05 2.17 2.05 2.19 2.14 2.66 2.45]);
    
tire_dia_in=[14 16 16 17 16 19 17 17 16]; %in
tire_radius = single(tire_dia_in.*2.54/100/2);

top_gear_ratio = [.72 .76 .77 .84 .83 .69 .92 .54 .61];
final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.73 3.14 4.53 3.65];
top_gear_number = [5 5 5 6 6 6 6 6 6];
peak_ice_T_2 = [98 125 185 300 360 600 280 400 280];
peak_ice_w_2 = single(9000*ones(1,9));
w_at_peak_T = single([2800 4200 4250 2000 2100 2000 3450 2000 2300]);

max_n_w = w_at_peak_T;
min_n_w = max_n_w;
min_w = 1000*ones(1,9);%w_at_peak_T;
max_P = [49 70.5 104.4 130 99.9 202.1 154.7 117.8 92];

number_of_driven_wheels = [2 2 2 2 2 2 2 4 2];
motor_in_or_out_of_wheel = zeros(1,9);
elec_brake_state= zeros(1,9);
gearbox_type= ones(1,9);


% Actual performance
mj_eff = [174 198 247 170 235 270 261 239 232];%MJ/100km
%mpg = [57 50 40 46 46 34 38 44 47];
ttw_ghg = [119 133 169 114 160 184 174 165 159];
%op_cost 
cap_cost = [8340 11995 17795 25920 25770 60060 23615 26510 21465];

front_or_rear_wheel_drive = [1 1 1 0 0 0 1 0 1];
dynamic_braking = zeros(1,9);
number_of_motors = ones(1,9);
gear_ratio_vector = [3.545 1.894 1.192 .853 .719 1;
                    3.58 1.93 1.28 0.95 0.76 1;
                    1 1 1 1 1 1;
                    5.08 2.804 1.783 1.26 1 .835 ;
                    1 1 1 1 1 1;
                    1 1 1 1 1 1;
                    1 1 1 1 1 1;
                    3.9333 2.037 1.189 .928 .777 .653;
                    1 1 1 1 1 1 ];
simulate = [0 0 1 0 1 1 1 0 1];%ones(1,9);%
wheelbase = [2.38 0 0 0 0 0 0 0 0];
h = 0.3*ones(1,9); %height of the vehicle centre of mass
fuel_tank = [35 0 0 0 0 0 0 0 0];


%5 5 5 6 6 6 7 6 6
old_ice_cost = max_P.*[23 23 23 27 27 27 27 27 27]*.596; 

%% Unit conversion

%RPM to rad/s
max_n_w = max_n_w*2*pi()/60;
min_n_w = min_n_w*2*pi()/60;
min_w = min_w*2*pi()/60;
peak_ice_w_2 = peak_ice_w_2*2*pi()/60;

%kW to W
max_P = max_P*1000;

%% Pre-allocate matrices

%pet, die, hyb, phyb, ev, fc = 5, 6, 4, 16, 1, 15
powertrain_type = [5 5 5 6 6 6 6 6 6;
    6 6 6 6 6 6 6 6 6;
    4 4 4 4 4 4 4 4 4;
    16 16 16 16 16 16 16 16 16 ;
    1 1 1 1 1 1 1 1 1;
    15 15 15 15 15 15 15 15 15];
    %2 2 2 2 2 2 2 2 2];

cv_range = 950;
ev_range = 100;
phev_aer = 50;
hev_aer = 0.00399*cv_range;
range_km = [cv_range*ones(1,9); 
cv_range*ones(1,9); 
hev_aer*ones(1,9); 
phev_aer*ones(1,9);
ev_range*ones(1,9);
hev_aer*ones(1,9)];
%hev_aer*ones(1,9)];
    
[~,c] = size(powertrain_type);
total_driven_wheelaxle_inertia = single(zeros(c,1));
% dist_km = total_driven_wheelaxle_inertia;
% %fuel_ice = total_driven_wheelaxle_inertia;
% %fuel_motor = total_driven_wheelaxle_inertia;
% %pack_size = total_driven_wheelaxle_inertia;
% %med_eff = total_driven_wheelaxle_inertia;
% max_motor_P = total_driven_wheelaxle_inertia;
% max_ice_P = total_driven_wheelaxle_inertia;
% 
% ghg_per_km = total_driven_wheelaxle_inertia;
% batt_cost = total_driven_wheelaxle_inertia;
% %ice_cost = total_driven_wheelaxle_inertia;
% motor_cost = total_driven_wheelaxle_inertia;
% run_cost = total_driven_wheelaxle_inertia;
% mj_per_km = total_driven_wheelaxle_inertia;
% mj_wtw = total_driven_wheelaxle_inertia;
% ghg_wtw = total_driven_wheelaxle_inertia;
% med_ice_eff = total_driven_wheelaxle_inertia;
% med_motor_eff = total_driven_wheelaxle_inertia;
% med_fc_eff = total_driven_wheelaxle_inertia;
% fuel_ice = total_driven_wheelaxle_inertia;
% fuel_motor = total_driven_wheelaxle_inertia;
% fuel_fc = total_driven_wheelaxle_inertia;
% max_fc_P = total_driven_wheelaxle_inertia;
%batt_cap = total_driven_wheelaxle_inertia;
% new_ice_cost = total_driven_wheelaxle_inertia;
% new_cap_cost = total_driven_wheelaxle_inertia;
% gb_cost = total_driven_wheelaxle_inertia;
% fc_cost = total_driven_wheelaxle_inertia;

range1 = total_driven_wheelaxle_inertia;
mj_die_km = total_driven_wheelaxle_inertia;
fc_kw = total_driven_wheelaxle_inertia;
e_motor_peak_T = total_driven_wheelaxle_inertia;
max_ice_kw = total_driven_wheelaxle_inertia;
total_fuel_energy = total_driven_wheelaxle_inertia;

%% Remove mass associated with engines and gearboxes
%ice_mass_factor = .211;
ice_sp = .0018;%kg/W from FIAT worksheet
%gb_mass_factor = .1;
overall_mass_fac = 1.036; %kg secondary mass per kg primary mass
gb_mass = 0.49.*peak_ice_T_2.^0.58.*top_gear_number.^0.29;  %Taken from P 52, Automotive transmissions: 
   %fundamentals, selection, design and application; assuming cast iron gearbox
pri_mass = gb_mass + max_P.*ice_sp;
glider_mass = glider_mass - (pri_mass*(1+overall_mass_fac));

%% Electric powertrains
batt_V = 200;

%% Base vehicle efficiency


for i=1:c%columns

total_driven_wheelaxle_inertia(i)=wheel_axle_inertia(motor_in_or_out_of_wheel(i),...
    number_of_driven_wheels(i),tire_radius(i));

[max_ice_kw(i),total_fuel_energy(i),~,timestep,v_ach,~]=level_3_cv_di_ice(v_req,...
    t,timestep,drive_cycle_length,slope,Cd(i),Af(i),rho_air,glider_mass(i),...
    Crr(i),total_driven_wheelaxle_inertia(i),motor_in_or_out_of_wheel(i),...
    number_of_driven_wheels(i),tire_radius(i),elec_brake_state(i),...
    gearbox_type(i),top_gear_number(i),top_gear_ratio(i),gear_ratio_vector(i,:),...
    final_drive_ratio(i),simulate(i),peak_ice_T_2(i),peak_ice_w_2(i),...
    min_w(i),min_n_w(i),max_n_w(i),max_P(i),number_of_motors(i),...
    front_or_rear_wheel_drive(i),dynamic_braking(i),wheelbase(i),0,0,...
    distance_req(i),distance_req_alt,fuel_tank(i),h(i),di_map,overall_mass_fac);
    
range1(i) = single(trapz(t,v_ach)/1000);
mj_die_km(i) = total_fuel_energy(i)/range1(i)*max_di_eff/max_ele_eff;
fc_kw(i) = max_ice_kw(i)*max_di_eff/max_ele_eff;%max_ice_kw(i);%*
e_motor_peak_T(i) = peak_ice_T_2(i)*max_di_eff/max_ele_eff;%peak_ice_T_2(i);%*max_di_eff/max_ele_eff;%max_ice_kw(i)*1000/peak_ice_w_2(i);
%batt_cap(i) = mj_die_km(i) * range_km(i,1);

end


motor_selection = 8;
ESS1_selection = 11;
ESS2_selection = 0; 
