drive_cycle = 'US06';
vehicle_mass = ;
Crr = VP(6);                            % tyre rolling resistance
Cd = VP(1);                             % drag coefficient
Af = VP(2);                             % frontal area

tire_dia_in=VP(5);                      % tyre diameter inches
top_gear_number = ;                     % number of gears
final_drive_ratio = ; % One of these relates to the N/V ratio
top_gear_ratio = ;

number_of_driven_wheels = ;
front_or_rear_wheel_drive=

max_P =; %kW
peak_ice_T_2=;
peak_ice_w2=;
w_at_peak_T=;

% 4 electric
batt_V = 360;
e_motor_peak_P = MP(1); %EMP;%kW
e_motor_peak_T = MP(2);

% market variables
batt_cost_kwh=119;
fuel_cost_petrol=1.156;
fuel_cost_diesel=1.174;
fuel_cost_kwh=0.154;
elec_co2_per_kwh=497;           % What is this??
elec_mj_per_kwh=3.6;            % Why is this?!

% constants
rho_air=1.2;                            % air density

%?
motor_in_or_out_of_wheel =0;
elec_brake_state=0;
gearbox_type= 1;
dynamic_braking = 0;
number_of_motors = 1;
gear_ratio_vector = [1 1 1 1 1 1];
simulate = [1 1 1 1 1 1 1 1 1];
wheelbase =  2.38; 
h=0.3;
fuel_tank = [35 0 0 0 0 0 0 0 0];
OIC = [23 23 23 27 27 27 27 27 27];   %?????
motor_selection = 8;
ESS1_selection = 11;
ESS2_selection = 0;
regen_var = 1;

% These maps show efficiency vs torque and power (I think)
di_map = single(xlsread('die_map.xls'));            % direct inj map?
si_turbo_map = single(xlsread('si_turbo_map.xls')); % spark ignition turbo
si_map = single(xlsread('si_map.xls'));             % spark ignition map
ele_map = single(xlsread('ele_map.xls'));           % ev map

max_di_eff = max(max(di_map));
max_ele_eff = max(max(ele_map));

% Ok, i don't know what's going on here but pretty sure it has to do
% with the electric efficiency being greater than 1 at points
[r,c,~] = find(max_ele_eff>95);
max_ele_eff(r,c) = 95;


drive_cycles = {'NEDC','Artemis','FUDS','NYCC','US06','US HWFET','US EPA'};

for i = 1:length(drive_cycles)
    if drive_cycles(i) == cycle
        drive_cycle_selection = i;
    end
end

number_of_drive_cycles=1;

% Calls drive cycle 3
[v_req,t,slope,distance_req,distance_req_alt,timestep,~,drive_cycle_length]=...
   drive_cycle_3(drive_cycle_selection,number_of_drive_cycles);

glider_mass = 180+vehicle_mass;
tire_radius = tire_dia_in.*2.54/100/2;
min_n_w = w_at_peak_T;
max_n_w = w_at_peak_T(SPD(1)-1);
max_P = max_P*1000; %Kw to W

% If fuel = electric
    powertrain_type = 1;
      
% Elseif hybrid
    powertrain_type = 4;
    
% Elseif fuel = petrol (& Conventional?)
    powertrain_type = 5;
    
% Elseif fuel = diesel
    powertrain_type = 6;
    
% Something else for plugins


total_driven_wheelaxle_inertia=wheel_axle_inertia(motor_in_or_out_of_wheel,...
    number_of_driven_wheels,tire_radius);

[max_ice_kw,total_fuel_energy,~,timestep,v_ach,~]=level_3_cv_di_ice(v_req,t,...
    timestep,drive_cycle_length,slope,Cd,Af,rho_air,glider_mass,Crr,...
    total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,...
    tire_radius,elec_brake_state,gearbox_type,top_gear_number,top_gear_ratio,...
    gear_ratio_vector,final_drive_ratio,simulate,peak_ice_T_2,peak_ice_w_2,...
    min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,...
    dynamic_braking,wheelbase,0,0,distance_req,distance_req_alt,fuel_tank,h,...
    di_map,overall_mass_fac);

range1 = single(trapz(t,v_ach)/1000);
mj_die_km = total_fuel_energy/range1;
fc_kw = max_ice_kw;%*max_di_eff/max_ele_eff;
e_motor_peak_T = peak_ice_T_2;%*max_di_eff/max_ele_eff;


[dist_km,fuel_ice,fuel_motor,fuel_fc,med_ice_eff,med_motor_eff,med_fc_eff,...
    max_motor_P,max_ice_P,max_fc_P,batt_cap] = level_3_ttw(v_req,t,timestep,drive_cycle_length,slope,Cd,Af,...
    rho_air,glider_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
    number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,min_w,...
    min_n_w,max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,...
    final_drive_ratio,simulate,peak_ice_T_2,peak_ice_w_2,w_at_peak_T,max_P,...
    powertrain_type,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
    wheelbase,distance_req,distance_req_alt,fuel_tank,h,range_km,di_map,si_map,...
    si_turbo_map,ele_map,overall_mass_fac,batt_V,range1,mj_die_km,fc_kw,...
    e_motor_peak_T,motor_selection,ESS1_selection,ESS2_selection,regen_var);

[ghg_per_km,~,~,~,~,~,~,mj_per_km,mj_wtw,ghg_wtw] = level_2_outputs(...
    dist_km,fuel_ice,fuel_motor,fuel_fc,powertrain_type,max_P,range_km,...
    max_motor_P,max_ice_P,max_fc_P,top_gear_number,peak_ice_T_2,...
    fuel_cost_petrol,fuel_cost_diesel,fuel_cost_kwh,batt_cap,...
    batt_cost_kwh,elec_co2_per_kwh,elec_mj_per_kwh);

% ghg_per_km --> g C02 per km
% ghg_wtw --> "" WTW
% mj_per_km --> MJ per 100km
% mj_wtw --> "" WTW

%{
Thoughts:

To compare with the EPA data we want the energy consumption in MPGe 

The g CO2 should be directly comparable.

We need a way of flagging whether the test is for electric vehicles or not

Also the hybrids. I'm gonna have beef with the hybridz.


%}