function [fc,per,fnc,ce,ra,fc_wtw,ce_wtw,mj_km] = ovem31_cc

% THIS IS MY VERSION WHICH ONLY CARES ABOUT FUEL CONSUMPTION AD CARBON
% EMISSIONS

c

% THESE NUMBERS MIGHT NEED UPDATING!

batt_cost_kwh=119;
fuel_cost_petrol=1.156;
fuel_cost_diesel=1.174;
fuel_cost_kwh=0.154;
elec_co2_per_kwh=497;           % What is this??
%elec_mj_per_kwh=0.25*.36;       % Why is this?!
elec_mj_per_kwh=3.6;       % Why is this?!

global SPD
%SPD=[S P D] 
% S=SMMT Category   2=m, 3=sm, 4=lm, 5=um, 6=e, 7=ls, 8=ss, 9=dp, 10=mpv
% P=powertrain      2=ice, 3=hybrid, 4=ev
% D=drivecycle      2=NEDC, 3=Artemis, 4=FUDS, 5=NYCC, 6=US06, 7=US HWFET, 8=US EPA 
global VP
% VP=[dc fa kw wd td tr]
% dc=drag
% fa=frontal area
% kw=weight
% wd=wheel drive
% td=tyre diameter
% tr=tyre rolling resistance
global PS
% PS=[ht et ft tc]
% ht=hybrid type, 1=series, 2=dual, 3=plugin
% et=engine type (fuel cell or IC), in IC set to 3, in EV set to 2
% ft=fuel type, 1=petrol, 0=diesel, 2=EV
% tc=turbocharged, 1=tc, 0=not tc, 2=EV
global EP
% EP=[es et ep]
% es=engine size, in EV set to 2
% et=engien torque, in EV set to 2
% ep=engine power, in EV set to 2
global MP
% MP=[mp mt me]
% mp=motor power, in IC set to 3
% mt=motor torque, in IC set to 3
% me=motor efficiency, in IC set to 3
global T
% T=[gbt gbs tgr fgr gbe axe]
% gbt=gearbox type
% gbs=gearbox speed
% tgr=top gear ratio
% fgr=final gear ratio
% gbe=gearbox efficiency
% axe=axle efficiency
global VR
% VR=[rng reg ref]
% rng=user desired range
% reg=makes use of regeneration or not
% ref=regeneration efficiency

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

%% Header

% This function takes pre-loaded vehicle parameters for the unique vehicle
% types under study and passes them through the OVEM Level 2 model.

%The outputs are:  median conversion efficiency, fuel consumed, TTW and WTW
%fuel and carbon efficiency and running costs per 12000 mi.

% Created 11 November 2009 (Justin Bishop)

%% Load vehicle parameters

%Load drive cycle information
drive_cycle_selection=(SPD(3)-1);
number_of_drive_cycles=1;

% Calls drive cycle 3
[v_req,t,slope,distance_req,distance_req_alt,timestep,~,drive_cycle_length]=...
   drive_cycle_3(drive_cycle_selection,number_of_drive_cycles);

% WARNING: THESE ARE NOT CONSISTENT WITH THE SPD(2) NUMBERS
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

test_mass = 180;                        % driver mass
glider_mass = VP(3);                    % vehicle mass
glider_mass = glider_mass + test_mass;  % total mass

rho_air=1.2;                            % air density
Crr = VP(6);                            % tyre rolling resistance
Cd = VP(1);                             % drag coefficient
Af = VP(2);                             % frontal area
tire_dia_in=VP(5);                      % tyre diameter

tire_radius = tire_dia_in.*2.54/100/2;
top_gear_ratio = T(3);                  
final_drive_ratio = T(4);
top_gear_number = T(2);
peak_ice_T_2 = EP(2);                   % engine torque
peak_ice_w_2 = 9000;                    % engine angular speed
max_P = EP(3);                          % engine power

w_at_peak_T = single([2800 4200 4250 2000 2100 1700 3450 2000 2300]);

%w=(max_P*1000)/peak_ice_T_2;
%w_at_peak_T = (w*60)/(2*pi()); %convert w rad/s to rpm

% Ok, I have no idea what's going on
max_n_w = w_at_peak_T(SPD(1)-1);
min_n_w = max_n_w;
min_w = 1000;

number_of_driven_wheels = VP(4);        % ie. 2 or 4 wheel drive
motor_in_or_out_of_wheel =0;
elec_brake_state=0;
gearbox_type= 1;

% Actual performance
CC = [8340 11995 17795 25920 25770 58440 23615 22880 21465];
cap_cost = CC(SPD(1)-1);

% OK I should be able to input front or rear wheel drive
FORWD = [1 1 1 0 0 0 1 0 1];             % 1 --> front wheel drive
front_or_rear_wheel_drive = FORWD(SPD(1)-1);

dynamic_braking = 0;
number_of_motors = 1;

gear_ratio_vector = [1 1 1 1 1 1];
simulate = [1 1 1 1 1 1 1 1 1];
% I probably want to input this as well
wheelbase =  2.38; 
h=0.3;
fuel_tank = [35 0 0 0 0 0 0 0 0];
OIC = [23 23 23 27 27 27 27 27 27];   %?????
old_ice_cost = max_P.*OIC(SPD(1)-1)*.596; %Assume turbo pisi = turbo dici

%% Unit conversion

%RPM to rad/s
max_n_w = max_n_w*2*pi()/60;
min_n_w = min_n_w*2*pi()/60;
min_w = min_w*2*pi()/60;
peak_ice_w_2 = peak_ice_w_2*2*pi()/60;

%kW to W
max_P = max_P*1000;
peak_ice_T = [98 125 185 400 360 500 280 350 280];

max_P1 = [49 70.5 104.4 145 99.9 149.9 154.7 110 92];

%% Pre-allocate matrices
pt=SPD(2); %powertrain, 2=ice, %3=hyb, 4=ev
ft=PS(3); %fueltype, 1=petrol, 0=diesel
ht=PS(1); %hybrid type, 1=series, 2=dual, 3=plugin 
eb=PS(2); %hybrid engine type, 1=ice, 0=fuelcell

if pt==4;
   powertrain_type = 1;
            peak_ice_T_2 = peak_ice_T(SPD(1)-1);
            min_n_w = w_at_peak_T(SPD(1)-1);
            max_n_w = w_at_peak_T(SPD(1)-1);
            max_P = max_P1(SPD(1)-1)*1000;
   
   
elseif pt==2;
    if ft==1;
        powertrain_type = 5;
    elseif ft==0;
        powertrain_type = 6;
    end
    
elseif pt==3;
    if ht==3;
        powertrain_type = 16;
        
    elseif (ht==1||ht==2)&&(eb==0);
            powertrain_type = 15;
            peak_ice_T_2 = peak_ice_T(SPD(1)-1);
            min_n_w = w_at_peak_T(SPD(1)-1);
            max_n_w = w_at_peak_T(SPD(1)-1);
            max_P = max_P1(SPD(1)-1)*1000;
%             
    elseif (ht==1)&&(eb==1);
            powertrain_type = 4;
    elseif (ht==2)&&(eb==1);
            powertrain_type = 4;    
    end
end

range_km = VR(1);

%% Remove mass associated with engines and gearboxes
ice_sp = .0018;                                             %kg/W from FIAT worksheet
overall_mass_fac = 1.036;                                   %kg secondary mass per kg primary mass
gb_mass = 0.49.*peak_ice_T_2.^0.58.*top_gear_number.^0.29;  %Taken from P 52, Automotive transmissions: 
                                                            %fundamentals, selection, design and application; assuming cast iron gearbox
pri_mass = gb_mass + max_P.*ice_sp;
glider_mass = glider_mass - pri_mass*(1+overall_mass_fac);

%% Electric powertrains
batt_V = 360;
e_motor_peak_P = MP(1); %EMP;%kW
e_motor_peak_T = MP(2);
%e_motor_peak_T = e_motor_peak_P*1000/(471);

motor_selection = 8;
ESS1_selection = 11;
ESS2_selection = 0;
regen_var = 1;

%% OVEM

% S=SMMT Category   2=m, 3=sm, 4=lm, 5=um, 6=e, 7=ls, 8=ss, 9=dp, 10=mpv
% P=powertrain      2=ice, 3=hybrid, 4=ev

%S=SPD(1)
%P=SPD(2)
%for i=S%columns
 %   for j=1:r %P%rows

%removed ij from left hand, removed i from right
~

%new_cap_cost = cap_cost + batt_cost + new_ice_cost + motor_cost + fc_cost ...
%    + gb_cost - old_ice_cost;

%% Outputs

% P=powertrain      2=ice, 3=hybrid, 4=ev
global OVEM31
global OUT

%pp = new_cap_cost;%(SPD(1),SPD(2));
fc = run_cost;%(SPD(1),SPD(2));

if SPD(2)==2
    per = 1;
    fnc = 1;
    ra = 1;
elseif SPD(2)==3
    per = 1.5;
    fnc = 1.72;
    ra = 1;
else SPD(2)=4;
    per = 1.5;
    fnc = .296;
    ra = .01; 
end

ce = ghg_per_km;%(SPD(1),SPD(2));
fc_wtw = mj_wtw;%(SPD(1),SPD(2));%wtw
ce_wtw = ghg_wtw;%(SPD(1),SPD(2)); %wtw
med_batt_cap = batt_cap;%(SPD(1),SPD(2));
mj_km = mj_per_km;%(SPD(1),SPD(2));

%OVEM31=1; % to tell vmod1 that it has been worked!
%OUT=round(1000*[pp fc ce fc_wtw ce_wtw mj_km med_batt_cap])/1000;
