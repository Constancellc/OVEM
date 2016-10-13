function [ghg_per_km,phev_fuel_frac] = ghg_attribute(dist_km,fuel_ice,fuel_motor,powertrain_type)

%This function takes the distance travelled over the drive cycle (km), the
%energy required to complete the cycle from the various fuel conversion
%components (MJ) and the power train type. 

%This function returns the GHG emitted (g/km) over
%a particular distance, defined below.

%Created 9 November 2009 (Justin Bishop)

%% Constants

%ghg_kwh = 466.35; %From Eurostat table nrg_105a, the UK generated 398 327 GWh, emitting
%185,76 MT CO2 eq in 2006.  This works out to 466,35 g CO2 eq/kWh 

%From DfT Transport Statistics GB 2008 p,47

petrol_density = 1361;% litres per tonne
diesel_density = 1199;% litres per tonne
petrol_energy = 47.1e3;% MJ/tonne
diesel_energy = 45.5e3;% MJ/tonne

petrol_mj_per_l = petrol_energy/petrol_density;
diesel_mj_per_l = diesel_energy/diesel_density;

fuel_kwh = fuel_motor/3.6;
fuel_l_petrol = (fuel_ice/petrol_mj_per_l) ;
fuel_l_diesel = (fuel_ice/diesel_mj_per_l) ;

% Use 2,3154 kg CO2/l petrol and 2,6304 kg CO2/l diesel from DEFRA
% conversion factors based on GCV

ghg_petrol = fuel_l_petrol * 2.3154 * 1000;
ghg_diesel = fuel_l_diesel * 2.6304 * 1000;
ghg_hydrogen = 0;
ghg_elec = 0;

%% Function
if powertrain_type == 1 % EV - only electricity used, cost penalty from battery pack 
    g_ghg = ghg_elec;
    phev_fuel_frac = 1;

elseif powertrain_type == 2 || powertrain_type == 3 || powertrain_type == 4  
    %Series, parallel or dual hybrid, petrol
    g_ghg = ghg_petrol;%fuel_kwh*ghg_elec + ghg_petrol);
    phev_fuel_frac = 1;
    
elseif powertrain_type == 16
    g_ghg = ghg_petrol + fuel_kwh*ghg_elec; 
    phev_fuel_frac = 1/(1+fuel_kwh);
    
% elseif powertrain_type ==  3
%     g_ghg = (fuel_kwh*ghg_elec + ghg_petrol);
%         
% elseif powertrain_type == 4
%     g_ghg = (fuel_kwh*ghg_elec + ghg_petrol);

elseif powertrain_type == 5  %SI ice normal, turbo or super
    g_ghg = ghg_petrol;
    phev_fuel_frac = 1;
    
elseif powertrain_type == 6; %%Pure ICE, diesel - no battery pack cost penalty;
    g_ghg = ghg_diesel;
    phev_fuel_frac = 1;
    
elseif powertrain_type == 7
    g_ghg = ghg_petrol;
    phev_fuel_frac = 1;
        
elseif powertrain_type == 8
    g_ghg = ghg_petrol;
    phev_fuel_frac = 1;

elseif powertrain_type == 15
    g_ghg = ghg_hydrogen;
    phev_fuel_frac = 1;
end

ghg_per_km = g_ghg/dist_km;
