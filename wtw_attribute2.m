function [mj_wtw,ghg_wtw] = wtw_attribute2(mj_per_km,ghg_per_km,~,powertrain_type,...
    elec_co2_per_kwh,elec_mj_per_kwh,phev_fuel_frac)

%This function takes the distance travelled over the drive cycle (km), the
%energy required to complete the cycle from the various fuel conversion
%components (MJ) and the power train type. 

%This function returns the WTW MJ/km and GHG/km for the particular vehicle
%and powertrain under study

%Created 11 November 2009 (Justin Bishop)

%% Constants

wtt_properties = [
    .39 15.49;%petrol
    .18 14.58; %diesel
    .16 10.63; %naphtha
    .19 16.11; %natural gas
    .12 7.49; %LPG
    .97 36.37; %bio ethanol
    .69 36.62; %biodiesel
    .76 27.58; %synthetic diesel
    .59 19.34; %DME
    .65 21.98; %methanol
    1.09 92.97; %hydrogen
    elec_mj_per_kwh/3.6 elec_co2_per_kwh/3.6]; %electricity, UK avg 2008


%% Function
if powertrain_type == 1 % EV - only electricity used, cost penalty from battery pack 

mj_wtt = wtt_properties(12,1);
ghg_wtt = wtt_properties(12,2); 
    
elseif powertrain_type==2 || powertrain_type==3 || powertrain_type==4 ;  %Series, parallel or dual hybrid - both petrol
    %used and cost penalty from battery pack
    mj_wtt = wtt_properties(1,1);
    ghg_wtt = wtt_properties(1,2); 
    
elseif powertrain_type == 16;
    
    mj_wtt = phev_fuel_frac*wtt_properties(1,1) + wtt_properties(12,1)*(1-phev_fuel_frac);
    ghg_wtt = phev_fuel_frac*wtt_properties(1,2) + wtt_properties(12,2)*(1-phev_fuel_frac); 

elseif powertrain_type==5 || powertrain_type==7 || powertrain_type==8;   %Pure ICE, petrol - no battery pack cost penalty;
    
mj_wtt = wtt_properties(1,1);
ghg_wtt = wtt_properties(1,2);

elseif powertrain_type==6; %%Pure ICE, diesel - no battery pack cost penalty;
    
mj_wtt = wtt_properties(2,1);
ghg_wtt = wtt_properties(2,2);

elseif powertrain_type==15; %%Pure FC
    
mj_wtt = wtt_properties(11,1);
ghg_wtt = wtt_properties(11,2);

end
%Concawe formulae, p19 of WTW report 2007
mj_wtw = mj_per_km * (1+mj_wtt); %Add WTT penalty to total MJ used for drive cycle and convert back to MJ/km
ghg_wtw = single(ghg_per_km + mj_per_km/100 * ghg_wtt)  ; % Find total GHG for drive cycle and add to total GHG emitted in the WTT energy used, then convert back to /km;

