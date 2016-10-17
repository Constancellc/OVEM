function [dist_km,fuel_ice,fuel_motor,fuel_fc,med_ice_eff,med_motor_eff,med_fc_eff,max_motor_P,max_ice_P,...
    max_fc_P,batt_kwh,final_veh_mass] = level_3_ttw(v_req,t,timestep,drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,...
    total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    elec_brake_state,gearbox_type,min_w,min_n_w,max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,...
    final_drive_ratio,simulate,peak_ice_T,peak_ice_w,~,max_P,powertrain_type,number_of_motors,...
    front_or_rear_wheel_drive,dynamic_braking,wheelbase,distance_req,distance_req_alt,fuel_tank,...
    h,range_km,di_map,si_map,si_turbo_map,ele_map,overall_mass_fac,batt_V,~,mj_die_km,fc_kw,e_motor_peak_T,...
    motor_selection,ESS1_selection,ESS2_selection,regen_var)


%Title: level_3
%
%Author: Reed Doucette
%
%Created: May 18, 2009
%
%Purpose: To run the backwards/forwards vehicle simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all

%Obtain drive cycle information
% drive_cycle_selection=input('Enter the drive cycle selection: ');
% number_of_drive_cycles=input('Enter the number of drive cycles: ');
%[v_req,t,slope,distance_req,distance_req_alt,timestep,drive_cycle_name,drive_cycle_length]=drive_cycle_3(drive_cycle_selection,number_of_drive_cycles);

%Obtain vehicle parameters
%veh_parameters_3;

%Load component efficiencies and coefficients
component_efficiency_3;
longitdunal_COM_ratio=.5;

    if dynamic_braking==1
        %wheelbase=wheelbase;  %m
        %longitdunal_COM_ratio=.5;
        L1=wheelbase*longitdunal_COM_ratio;         %m (distance from COM to the front wheel)
        L2=wheelbase*(1-longitdunal_COM_ratio);         %m (distance from COM to the rear wheel)
        %h=h;          %m (height of the COM)
    else
        wheelbase=0;    %m
        L1=0;           %m (distance from COM to the front wheel)
        L2=0;           %m (distance from COM to the rear wheel)
        h=0;            %m (height of the COM)
        %longitdunal_COM_ratio=.5;
    end

   
% [max_ice_kw,total_fuel_energy,~,timestep,v_ach,~]=level_3_cv_di_ice(v_req,t,timestep,...
%    drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
%    number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,top_gear_number,top_gear_ratio,gear_ratio_vector,...
%    final_drive_ratio,simulate,peak_ice_T,peak_ice_w,min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,...
%    dynamic_braking,wheelbase,L1,L2,distance_req,distance_req_alt,fuel_tank,h,di_map,overall_mass_fac);
%     
% %batt_cap = total_fuel_energy;
% range = single(trapz(t,v_ach)/1000);
% mj_die_km = total_fuel_energy/range;
% fc_kw = max_ice_kw;
    
%% 
% ene = 0.5 * veh_mass * v_req.^2;
% tot_ene = sum(ene)/10^6; %MJ

% pow = ene(2:end) - ene(1:end-1);
% mj_die_km = tot_ene/(sum(distance_req)/1000);
% max_pow = max(pow)/1000;%kW
% batt_cap = tot_ene;
% fc_kw = max_pow;

scaling_factor = e_motor_peak_T/550;

%%%%%%%%%%%%%%%%%%%%%%%%
%% EV 
%%%%%%%%%%%%%%%%%%%%%%%%

if powertrain_type == 1
    
    batt_cap = mj_die_km * range_km;
    
    [max_ice_kw,fuel_motor,motor_f_eff,~,v_ach,~,batt_kwh,~,... 
        ~,~,~,final_veh_mass]=level_3_ev2(powertrain_type,v_req,t,timestep,...
       drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
       number_of_driven_wheels,final_drive_ratio,tire_radius,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
       wheelbase,L1,L2,h,distance_req,distance_req_alt,fuel_tank,batt_cap,overall_mass_fac,batt_V,scaling_factor,...
       motor_selection,ESS1_selection,ESS2_selection,ele_map,regen_var);

    max_ice_P = 0;
    fuel_ice = 0;
    med_ice_eff = 0;
    med_motor_eff = median(motor_f_eff);
    max_motor_P = max_ice_kw;
    %dist_km = range;
    fuel_fc = 0;
    med_fc_eff = 0;
    max_fc_P = 0;

%%%%%%%%%%%%%%%%%%
%% Series HEV
%%%%%%%%%%%%%%%%%%

elseif powertrain_type == 2
        
    batt_cap = mj_die_km * range_km;

    [max_ice_kw,max_motor_kw,fuel_ice,fuel_motor,motor_eff_f,ice_eff_f,~,v_ach,~,~,batt_kwh]=...
        level_3_s_hev(powertrain_type,v_req,t,timestep,drive_cycle_length,slope,Cd,Af,rho_air,...
        veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
        gearbox_type,final_drive_ratio,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
        wheelbase,L1,L2,h,distance_req,distance_req_alt,batt_cap,overall_mass_fac,batt_V,si_map,...
        ele_map,max_P,peak_ice_T,scaling_factor,motor_selection,ESS1_selection,ESS2_selection);

    max_ice_P = max_ice_kw;
    %fuel_ice = fuel_ice;
    med_ice_eff = median(ice_eff_f);
    med_motor_eff = median(motor_eff_f);
    max_motor_P = max_motor_kw;
    %fuel_motor = fuel_motor;
    %dist_km = range;

    fuel_fc = 0;
    med_fc_eff = 0;
    max_fc_P = 0;
    final_veh_mass= 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PISI Parallel & Dual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
elseif powertrain_type == 3 || powertrain_type == 4 || powertrain_type == 16;

    batt_cap = mj_die_km * range_km;
   
[max_ice_kw,max_motor_kw,fuel_ice,fuel_motor,motor_eff_f,ice_eff_f,~,v_ach,...
    ~,batt_kwh,I_ESS1,DoD_ESS1,NoCells_ESS1_par,volume_of_fuel_used_by_ICE] ...
    = level_3_pisi_dual_hev4(powertrain_type,v_req,t,timestep,drive_cycle_length,...
    slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,gearbox_type,...
    final_drive_ratio,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
    wheelbase,L1,L2,h,distance_req,distance_req_alt,batt_cap,overall_mass_fac,...
    batt_V,si_map,ele_map,fc_kw,peak_ice_T,top_gear_number,simulate,top_gear_ratio,...
    min_w,min_n_w,max_n_w,peak_ice_w,gear_ratio_vector,scaling_factor,motor_selection,...
    ESS1_selection,ESS2_selection,regen_var);

max_ice_P = max_ice_kw;
%fuel_ice = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = median(motor_eff_f);
max_motor_P = max_motor_kw;
%fuel_motor = fuel_motor;
%dist_km = range;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;
final_veh_mass = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DISI Parallel & Dual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
elseif powertrain_type == 31 || powertrain_type == 41 || powertrain_type == 161;
    batt_cap = mj_die_km * range_km;
    
    [max_ice_kw,max_motor_kw,fuel_ice,fuel_motor,motor_eff_f,ice_eff_f,~,~,~,~,batt_kwh]=...
    level_3_pisi_dual_hev2(powertrain_type,v_req,t,timestep,drive_cycle_length,slope,Cd,Af,rho_air,...
    veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    gearbox_type,final_drive_ratio,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
    wheelbase,L1,L2,h,distance_req,distance_req_alt,batt_cap,overall_mass_fac,batt_V,si_map,ele_map,max_P,peak_ice_T,...
    motor_selection,ESS1_selection,ESS2_selectionscaling_factor);

max_ice_P = max_ice_kw;
%fuel_ice = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = median(motor_eff_f);
max_motor_P = max_motor_kw;
%fuel_motor = fuel_motor;
%dist_km = range;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;
final_veh_mass = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PISI turbo Parallel & Dual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
elseif powertrain_type == 32 || powertrain_type == 42 || powertrain_type == 162;

    %if powertrain_type == 16; %Use PHEV AER
        batt_cap = mj_die_km * range_km;
    %else
       % batt_cap = 1.31*3.6;%MJ
    %end

[max_ice_kw,max_motor_kw,fuel_ice,fuel_motor,motor_eff_f,ice_eff_f,~,~,~,~,batt_kwh]=...
    level_3_pisi_dual_hev2(powertrain_type,v_req,t,timestep,drive_cycle_length,slope,Cd,Af,rho_air,...
    veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    gearbox_type,final_drive_ratio,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
    wheelbase,L1,L2,h,distance_req,distance_req_alt,batt_cap,overall_mass_fac,...
    batt_V,si_turbo_map,ele_map,max_P,peak_ice_T,scaling_factor,motor_selection,ESS1_selection,ESS2_selection);

max_ice_P = max_ice_kw;
%fuel_ice = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = median(motor_eff_f);
max_motor_P = max_motor_kw;
%fuel_motor = fuel_motor;
%dist_km = range;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;
final_veh_mass = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DICI Parallel & Dual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
elseif powertrain_type == 33 || powertrain_type == 43 || powertrain_type == 163;

    batt_cap = mj_die_km * range_km;
   
[max_ice_kw,max_motor_kw,fuel_ice,fuel_motor,motor_eff_f,ice_eff_f,~,v_ach,...
    ~,batt_kwh]= level_3_dici_dual_hev2(powertrain_type,v_req,t,timestep,drive_cycle_length,...
    slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,gearbox_type,...
    final_drive_ratio,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,...
    wheelbase,L1,L2,h,distance_req,distance_req_alt,batt_cap,overall_mass_fac,...
    batt_V,di_map,ele_map,fc_kw,peak_ice_T,top_gear_number,simulate,top_gear_ratio,...
    min_w,min_n_w,max_n_w,peak_ice_w,gear_ratio_vector,scaling_factor,motor_selection,...
    ESS1_selection,ESS2_selection,regen_var);

max_ice_P = max_ice_kw;
%fuel_ice = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = median(motor_eff_f);
max_motor_P = max_motor_kw;
%fuel_motor = fuel_motor;
%dist_km = range;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;final_veh_mass= 0;

%%%%%%%%%%%%%%%%%%%%%%%%
%% ICE, SI petrol 
%%%%%%%%%%%%%%%%%%%%%%%%
elseif powertrain_type == 5
    veh_mass;
[max_ice_kw,total_fuel_energy,ice_eff_f,~,v_ach,~,final_veh_mass]=level_3_cv_si_ice(v_req,t,timestep,...
   drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
   number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,top_gear_number,top_gear_ratio,gear_ratio_vector,...
   final_drive_ratio,simulate,peak_ice_T,peak_ice_w,min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,...
   dynamic_braking,wheelbase,L1,L2,distance_req,distance_req_alt,fuel_tank,h,si_map,overall_mass_fac);
    
max_ice_P = max_ice_kw;
fuel_ice = total_fuel_energy;
%pack_size = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = 0;
max_motor_P = 0;
fuel_motor = 0;
%dist_km = range;
%mj_per_100_km = fuel_ice*100/dist_km;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;
batt_kwh = 0;

%%%%
%% ICE diesel, turbo    
%%%%
elseif powertrain_type == 6
    
[max_ice_kw,total_fuel_energy,ice_eff_f,~,v_ach,~,final_veh_mass]=level_3_cv_di_ice(v_req,t,timestep,...
   drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
   number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,top_gear_number,top_gear_ratio,gear_ratio_vector,...
   final_drive_ratio,simulate,peak_ice_T,peak_ice_w,min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,...
   dynamic_braking,wheelbase,L1,L2,distance_req,distance_req_alt,fuel_tank,h,di_map,overall_mass_fac);
    
max_ice_P = max_ice_kw;
fuel_ice = total_fuel_energy;
%pack_size = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = 0;
max_motor_P = 0;
fuel_motor = 0;
%dist_km = range;
%mj_per_100_km = fuel_ice*100/dist_km;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;
batt_kwh = 0;
%%%%
%% SI ICE, turbo    
%%%%
elseif powertrain_type == 7
    
[max_ice_kw,total_fuel_energy,ice_eff_f,~,v_ach,~,~]=level_3_cv_si_ice_turbo(v_req,t,timestep,...
   drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
   number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,top_gear_number,top_gear_ratio,gear_ratio_vector,...
   final_drive_ratio,simulate,peak_ice_T,peak_ice_w,min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,...
   dynamic_braking,wheelbase,L1,L2,distance_req,distance_req_alt,fuel_tank,h,si_turbo_map,overall_mass_fac);
    
max_ice_P = max_ice_kw;
fuel_ice = total_fuel_energy;
%pack_size = fuel_ice;
med_ice_eff = median(ice_eff_f);
med_motor_eff = 0;
max_motor_P = 0;
fuel_motor = 0;
%dist_km = range;
%mj_per_100_km = fuel_ice*100/dist_km;
fuel_fc = 0;
med_fc_eff = 0;
max_fc_P = 0;
batt_kwh = 0;
final_veh_mass = 0;
%%%%
%% FC EV   
%%%%
elseif powertrain_type == 15 || powertrain_type == 151;

    batt_cap = mj_die_km * range_km;

    [max_fc_kw,max_motor_kw,fuel_fc,fuel_motor,motor_eff_f,fc_eff_f,~,...
        v_ach,~,batt_kwh]= level_3_fc_hev2(powertrain_type,v_req,t,...
        timestep,drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,...
        total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,...
        final_drive_ratio,tire_radius,gearbox_type,number_of_motors,front_or_rear_wheel_drive,...
        dynamic_braking,wheelbase,L1,L2,h,distance_req,distance_req_alt,...
        batt_cap,fc_kw,overall_mass_fac,batt_V,scaling_factor,motor_selection,...
        ESS1_selection,ESS2_selection,ele_map,regen_var,max_P,peak_ice_T);

max_fc_P = max_fc_kw;
%fuel_fc = fuel_fc;
med_fc_eff = median(fc_eff_f);
med_motor_eff = median(motor_eff_f);
max_motor_P = max_motor_kw;
%fuel_motor = fuel_motor;
%dist_km = range;
max_ice_P = 0;
fuel_ice = 0;
%pack_size = fuel_fc;
med_ice_eff = 0;
final_veh_mass = 0;
end

dist_km=single(trapz(t,v_ach)/1000);

