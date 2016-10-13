function [ghg_per_km,batt_cost,ice_cost,motor_cost,fc_cost,run_cost,gb_cost,mj_per_km,mj_wtw,ghg_wtw] = ...
    level_2_outputs(dist_km,fuel_ice,fuel_motor,fuel_fc,powertrain_type,~,~,max_motor_P,max_ice_P,...
    max_fc_P,top_gear_number,max_T,pet,die,elec,batt_cap,batt_cost_kwh,elec_co2_per_kwh,elec_mj_per_kwh)

%% Header
% This function receives the energy required from system components and
% distance travelled, powertrain type and returns the economic, WTT energy and
% GHG performance and WTW energy and GHG performance of the vehicle

%Created 11 November 2009 (Justin Bishop)

%% Outputs

%Return CO2 output, assuming stoichiometric combustion in oxygen
[ghg_per_km,phev_fuel_frac] = ghg_attribute(dist_km,fuel_ice,fuel_motor,powertrain_type);

%Return capital and running costs per 12000 mi
% [batt_cost,ice_cost,motor_cost,run_cost,gb_cost] = econ_attribute(dist_km,fuel_ice,fuel_motor,fuel_fc,...
%     powertrain_type,max_P,range_km,max_motor_P,max_ice_P,max_fc_P,top_gear_number,max_T,pet,die,elec,...
%     batt_cap,batt_cost_kwh);

    
%% Return fuel efficiency figures
 mj_per_km = perf_attribute2(dist_km,fuel_ice,fuel_motor,fuel_fc,powertrain_type,...
     batt_cap,phev_fuel_frac);
  
 [batt_cost,ice_cost,motor_cost,fc_cost,run_cost,gb_cost] = econ_attribute2(dist_km,fuel_ice,fuel_motor,fuel_fc,...
     powertrain_type,max_motor_P,max_ice_P,max_fc_P,top_gear_number,max_T,pet,die,elec,...
     batt_cap,batt_cost_kwh);
  
%   if powertrain_type ==1
%   kwh_per_km;
%   else
%   end
  
  %Return WTW performance/km
  
[mj_wtw,ghg_wtw] = wtw_attribute2(mj_per_km,ghg_per_km,dist_km,powertrain_type,...
    elec_co2_per_kwh,elec_mj_per_kwh,phev_fuel_frac);