function [batt_cost,ice_cost,motor_cost,fc_cost,run_cost,gb_cost] = ...
    econ_attribute2(dist_km,fuel_ice,fuel_motor,~,powertrain_type,max_motor_P,...
    max_ice_P,~,top_gear_number,max_T,fuel_cost_petrol,fuel_cost_diesel,...
    fuel_cost_kwh,batt_cap,batt_cost_kwh)


%This function takes the distance travelled over the drive cycle (km), the
%energy required to complete the cycle from the various fuel conversion
%components (MJ) and the power train type. 

%This function returns the capital cost premium and running costs (£) over
%a particular distance, defined below.  Default is 12 000 mi

%Created 5 November 2009 (Justin Bishop)

%% Constants
fuel_mj_pet = fuel_cost_petrol/34; %Cost/MJ
fuel_mj_die = fuel_cost_diesel/38.6;
fuel_mj_ele = fuel_cost_kwh*3.6;
fuel_mj_h2 = fuel_cost_petrol/5.6;

emotor_cost = 5;%USD/kW, from http://www.transportation.anl.gov/pdfs/HV/439.pdf using "Slow technology"
si_ice_cost = 23;
ci_ice_cost = 27;
fuel_cell_cost = 75;
gb_cost = 0.035 * (3.85* max_T) ^0.45 * top_gear_number^0.225;%euros

%% Function
if powertrain_type == 1 % EV - only electricity used, cost penalty from battery pack 

    cost_in_mj = fuel_mj_ele * fuel_motor;
    max_P_ice_cost = 0;   
    fc_cost = 0;
    pack_size = batt_cap;

elseif powertrain_type == 2 || powertrain_type == 3 || powertrain_type == 4 

    cost_in_mj = fuel_mj_pet*fuel_ice;
    max_P_ice_cost = max_ice_P * si_ice_cost;
    fc_cost = 0;
    pack_size = batt_cap;
    
elseif powertrain_type == 16;

    cost_in_mj = fuel_mj_pet*fuel_ice + fuel_mj_ele*batt_cap;
    max_P_ice_cost = max_ice_P * si_ice_cost;
    fc_cost = 0;
    pack_size = batt_cap;


elseif powertrain_type == 5 ;   %Pure ICE, petrol - no battery pack cost penalty;
   
    cost_in_mj = fuel_mj_pet * fuel_ice;
    max_motor_P = 0;
    max_P_ice_cost = max_ice_P * si_ice_cost;
    fc_cost = 0;
    pack_size = 0;
   

elseif powertrain_type == 6; %%Pure ICE, diesel - no battery pack cost penalty;
    
    cost_in_mj = fuel_mj_die * fuel_ice;
    max_motor_P = 0;
    max_P_ice_cost = max_ice_P * ci_ice_cost;
    fc_cost = 0;
    pack_size = 0;

elseif powertrain_type == 7;   %Pure ICE turbo, petrol - no battery pack cost penalty;
    
    cost_in_mj = fuel_mj_pet *fuel_ice;
    max_motor_P = 0;
    max_P_ice_cost = max_ice_P * si_ice_cost;
    fc_cost = 0;
    pack_size = 0;


elseif powertrain_type == 8;   %Pure ICE super, petrol - no battery pack cost penalty;
    
    cost_in_mj = fuel_mj_pet * fuel_ice;
    max_motor_P = 0;
    max_P_ice_cost = max_ice_P * si_ice_cost;
    fc_cost = 0;
    pack_size = 0;

elseif powertrain_type == 15;   %FC EV - motor cost, FC cost and battery cost penalties;
    
    cost_in_mj = fuel_mj_h2 * fuel_motor;
    max_P_ice_cost = 0;
    pack_size = batt_cap;
    fc_cost = max_motor_P * fuel_cell_cost *.596;
    
else

end

[cap_cost_hi,~] = ess_cost2(pack_size,batt_cost_kwh);

batt_cost = cap_cost_hi*0.79635;%convert EUR to GBP
ice_cost = max_P_ice_cost*.596;%/si_ice_cost_baseline)* .596;%Convert USD to GBP
motor_cost = max_motor_P * emotor_cost*.596;%)/si_ice_cost_baseline* .596;

run_cost = cost_in_mj / dist_km;

