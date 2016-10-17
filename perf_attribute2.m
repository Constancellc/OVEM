function mj_per_km = perf_attribute2(dist_km,fuel_ice,fuel_motor,fuel_fc,...
    powertrain_type,batt_cap,phev_fuel_frac)

%This function takes the distance travelled over the drive cycle (km), the
%energy required to complete the cycle from the various fuel conversion
%components (MJ) and the power train type. 

%This function returns the fuel efficiency over a particular distance, defined below.

%Created 9 November 2009 (Justin Bishop)

%% Constants

fuel_ice;
fuel_motor;
% fuel_kwh = fuel_motor/3.6;
% 
% dist_mi = dist_km/1.609;
% fuel_l_petrol = (fuel_ice/32); %Using 32 MJ/l 87 octane petrol 
% fuel_l_diesel = (fuel_ice/38.6);
% fuel_gal_diesel = fuel_l_diesel/4.54609;
% fuel_gal_petrol = fuel_l_petrol/4.54609;

%% Function
if powertrain_type ==1  % EV - only electricity used, cost penalty from battery pack 

    fuel_mj = fuel_motor;

elseif  powertrain_type == 15;
    
    fuel_mj = fuel_fc;

elseif powertrain_type == 2 || powertrain_type ==3 || powertrain_type ==4 
    %Series, parallel or dual hybrid - both petrol used and cost penalty from battery pack
fuel_mj = fuel_ice;

elseif powertrain_type == 16
    
    fuel_mj = fuel_ice*phev_fuel_frac+fuel_motor*(1-phev_fuel_frac);
% 
% elseif powertrain_type == 3
%     fuel_mj = (fuel_ice + fuel_motor);
% 
% elseif powertrain_type == 4
% fuel_mj = (fuel_ice + fuel_motor);

else%if powertrain_type == 5;   %Pure ICE, petrol - no battery pack cost penalty;
   
fuel_mj = fuel_ice;

% elseif powertrain_type == 6; %%Pure ICE, diesel - no battery pack cost penalty;
% 
% fuel_mj = fuel_ice;
% 
% elseif powertrain_type == 7
% fuel_mj = fuel_ice;
% 
% elseif powertrain_type == 8
% fuel_mj = fuel_ice;

end

mj_per_km = fuel_mj*100/dist_km; %MJ/100 km

