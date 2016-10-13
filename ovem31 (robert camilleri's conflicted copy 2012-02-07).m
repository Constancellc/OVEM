

function [pp,fc,per,fnc,ce,ra,fc_wtw,ce_wtw,med_batt_cap,mj_km] = ...
    ovem31;%(batt_cost_kwh,fuel_cost_petrol,fuel_cost_diesel,fuel_cost_kwh)%,di_map,si_turbo_map,si_map)
 
batt_cost_kwh=1000;
fuel_cost_petrol=1.076;
fuel_cost_diesel=1.166;
fuel_cost_kwh=0.09;
elec_co2_per_kwh=497;
elec_mj_per_kwh=0.25;

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

% di_map = xlsread('/Users/robert_camilleri/Desktop/OVEM1+/die_map.xls');
% si_turbo_map = xlsread('/Users/robert_camilleri/Desktop/OVEM1+/si_turbo_map.xls');
% si_map = xlsread('/Users/robert_camilleri/Desktop/OVEM1+/si_map.xls');
% ele_map = single(xlsread('/Users/robert_camilleri/Desktop/OVEM1+/ele_map'));

 di_map = xlsread('/Users/robert_camilleri/Dropbox/OVEM plus/OVEM+ 2/die_map.xls');
 si_turbo_map = xlsread('/Users/robert_camilleri/Dropbox/OVEM plus/OVEM+ 2/si_turbo_map.xls');
 si_map = xlsread('/Users/robert_camilleri/Dropbox/OVEM plus/OVEM+ 2/si_map.xls');
 ele_map = single(xlsread('/Users/robert_camilleri/Dropbox/OVEM plus/OVEM+ 2/ele_map'));


%di_map = xlsread('C:\Users\Chris\Dropbox\OVEM plus\OVEM+ 2\die_map.xls');
%si_turbo_map = xlsread('C:\Users\Chris\Dropbox\OVEM plus\OVEM+ 2\si_turbo_map.xls');
%si_map = xlsread('C:\Users\Chris\Dropbox\OVEM plus\OVEM+ 2\si_map.xls');
%ele_map = single(xlsread('C:\Users\Chris\Dropbox\OVEM plus\OVEM+ 2\ele_map'));


max_di_eff = max(max(di_map));
max_ele_eff = max(max(ele_map));

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
SDC=(SPD(3)-1);
drive_cycle_selection=(SDC);%input('Enter the drive cycle selection: ');
number_of_drive_cycles=1;%input('Enter the number of drive cycles: ');
[v_req,t,slope,distance_req,distance_req_alt,timestep,~,drive_cycle_length]=...
   drive_cycle_3(drive_cycle_selection,number_of_drive_cycles);

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

test_mass = 180;%driver
%glider_mass = [925 966 1327 1515 1575 1970 1318 1647 1613];
glider_mass = [VP(3)];
glider_mass = glider_mass + test_mass;
%
rho_air=1.2;%Density of air
%
%Crr= [0.0085 0.0099 0.0106 .0096 .0096 .0096 .0096 .0096 .0096];
Crr = [VP(6)];
%
%Cd = [0.32 0.32 0.32 0.27 0.25 0.26 0.34 0.32 0.31];  
Cd = [VP(1)];
%
%Af = [1.97 2.04 2.05 2.17 2.05 2.21 2.14 2.44 2.45];
Af = [VP(2)]   ;
%
%tire_dia_in=[14 16 16 17 16 17 17 17 16]; %in
tire_dia_in=[VP(5)];
%
tire_radius = tire_dia_in.*2.54/100/2;
%
%top_gear_ratio = [.72 .76 .77 .84 .83 .73 .92 .64 .61];
top_gear_ratio = [T(3)];
%
%final_drive_ratio = [4.6 4.06 3.56 2.35 2.47 2.82 3.14 4.11 3.65];
final_drive_ratio = [T(4)];
%
%top_gear_number = [5 5 5 6 6 7 6 6 6];
top_gear_number = [T(2)];
%
%peak_ice_T_2 = [98 125 185 400 360 500 280 350 280];
peak_ice_T_2 = [EP(2)];
%
%peak_ice_w_2 = 9000*ones(1,9);
peak_ice_w_2 = [9000];
%
%max_P = [49 70.5 104.4 145 99.9 149.9 154.7 110 92];
max_P = [EP(3)];
%
%w_at_peak_T = [2800 4200 4250 2000 2100 1700 3450 2000 2300];
w=(max_P*1000)/peak_ice_T_2;
w_at_peak_T = [(w*60)/pi()]; %convert w rad/s to rpm
%
max_n_w = w_at_peak_T;
min_n_w = max_n_w;
%min_w = 1000*ones(1,9);%w_at_peak_T;
min_w = [1000];


%number_of_driven_wheels = [2 2 2 2 2 2 2 4 2];
number_of_driven_wheels = [VP(4)];

%motor_in_or_out_of_wheel = zeros(1,9);
motor_in_or_out_of_wheel =[0];
%
%elec_brake_state= zeros(1,9);
elec_brake_state=[0];
%
gearbox_type= 1;%ones(1,9);


% Actual performance
SCC=(SPD(1)-1);
%fuel_eff = [5 5.7 7.1 6.1 6.1 8 7.5 6.5 6];l/100km
MJE = [174 198 247 235 235 309 261 251 232];%MJ/100km
mj_eff = [MJE(SCC)];
%mpg = [57 50 40 46 46 34 38 44 47];
TTW = [119 133 169 160 160 221.5 174 173 159];
ttw_ghg = [TTW(SCC)];
%op_cost 
CC = [8340 11995 17795 25920 25770 58440 23615 22880 21465];
cap_cost = [CC(SCC)];

FORWD = [1 1 1 0 0 0 1 0 1];
front_or_rear_wheel_drive = [FORWD(SCC)];
%
%dynamic_braking = zeros(1,9);
dynamic_braking = [0];
%
%number_of_motors = ones(1,9);
number_of_motors = [1];
%
%gear_ratio_vector = [3.545 1.894 1.192 .853 .719 1;
%                    3.58 1.93 1.28 0.95 0.76 1;
%                    1 1 1 1 1 1;
%                    5.08 2.804 1.783 1.26 1 .835 ;
%                    1 1 1 1 1 1;
%                    1 1 1 1 1 1;
%                    1 1 1 1 1 1;
%                    3.9333 2.037 1.189 .928 .777 .653;
%                    1 1 1 1 1 1 ];
gear_ratio_vector = [1 1 1 1 1 1];%[3.545 1.894 1.192 .853 .719 1 ];
simulate = [1 1 1 1 1 1 1 1 1];
wheelbase =  2.38; %[2.38 0 0 0 0 0 0 0 0];
%h = 0.3*ones(1,9); %height of the vehicle centre of mass
h=0.3;
fuel_tank = [35 0 0 0 0 0 0 0 0];


%5 5 5 6 6 6 7 6 6
OIC = [23 23 23 27 27 27 27 27 27];
old_ice_cost = max_P.*[OIC(SCC)]*.596; %Assume turbo pisi = turbo dici

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
%powertrain_type = [5 5 5 6 6 6 7 6 6;
%    6 6 6 6 6 6 6 6 6;
%    4 4 4 4 4 4 4 4 4;
%    16 16 16 16 16 16 16 16 16 ;
%    1 1 1 1 1 1 1 1 1;
%    15 15 15 15 15 15 15 15 15];
    %2 2 2 2 2 2 2 2 2];
%

pt=SPD(2); %powertrain, 2=ice, %3=hyb, 4=ev
ft=PS(3); %fueltype, 1=petrol, 0=diesel
ht=PS(1); %hybrid type, 1=series, 2=dual, 3=plugin 
eb=PS(2); %hybrid engine type, 1=ice, 0=fuelcell
if pt==4;
   powertrain_type = [1];
elseif pt==2;
    if ft==1;
        powertrain_type = [5];
    elseif ft==0;
        powertrain_type = [6];
    end
elseif pt==3;
    if ht==3;
        powertrain_type = [16];
    elseif (ht==1||ht==2)&&(eb==0);
            powertrain_type = [15];
    elseif (ht==1)&&(eb==1);
            powertrain_type = [4]
    elseif (ht==2)&&(eb==1);
            powertrain_type = [4];
        end
end
        
    
%    
%cv_range = VR(1)
%ev_range = VR(1)
%phev_aer = 50;
%hev_aer = 0.00399*cv_range;
%range_km = [cv_range*ones(1,9); 
%cv_range*ones(1,9); 
%hev_aer*ones(1,9); 
%phev_aer*ones(1,9);
%ev_range*ones(1,9);
%hev_aer*ones(1,9)];
%hev_aer*ones(1,9)];
range_km = VR(1);
%
[r,c] = size(powertrain_type);
total_driven_wheelaxle_inertia = 0;
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

%% Remove mass associated with engines and gearboxes
%ice_mass_factor = .211;
ice_sp = .0018;%kg/W from FIAT worksheet
%gb_mass_factor = .1;
overall_mass_fac = 1.036; %kg secondary mass per kg primary mass
gb_mass = 0.49.*peak_ice_T_2.^0.58.*top_gear_number.^0.29;  %Taken from P 52, Automotive transmissions: 
   %fundamentals, selection, design and application; assuming cast iron gearbox
pri_mass = gb_mass + max_P.*ice_sp;
glider_mass = glider_mass - pri_mass*(1+overall_mass_fac);

%% Electric powertrains
batt_V = 500;

%global MP;
e_motor_peak_P = MP(1); %EMP;%kW
e_motor_peak_T = e_motor_peak_P*1000/(471);

motor_selection = 8;
ESS1_selection = 11;
ESS2_selection = 0;
% [v_req,t,slope,distance_req,distance_req_alt,timestep,drive_cycle_name,drive_cycle_length]=...
%     test_cycle(powertrain_type);

%% OVEM

% S=SMMT Category   2=m, 3=sm, 4=lm, 5=um, 6=e, 7=ls, 8=ss, 9=dp, 10=mpv
% P=powertrain      2=ice, 3=hybrid, 4=ev

%S=SPD(1)
%P=SPD(2)
%for i=S%columns
 %   for j=1:r %P%rows

%removed ij from left hand, removed i from right
total_driven_wheelaxle_inertia=wheel_axle_inertia(motor_in_or_out_of_wheel,number_of_driven_wheels,...
    tire_radius);

[max_ice_kw,total_fuel_energy,~,timestep,v_ach,~]=level_3_cv_di_ice(v_req,t,timestep,...
   drive_cycle_length,slope,Cd,Af,rho_air,glider_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
   number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,top_gear_number,top_gear_ratio,gear_ratio_vector,...
   final_drive_ratio,simulate,peak_ice_T_2,peak_ice_w_2,min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,...
   dynamic_braking,wheelbase,0,0,distance_req,distance_req_alt,fuel_tank,h,di_map,overall_mass_fac);
    
range1=single(trapz(t,v_ach)/1000);
mj_die_km=total_fuel_energy/range1;
fc_kw=max_ice_kw*max_di_eff/max_ele_eff;
e_motor_peak_T=peak_ice_T_2*max_di_eff/max_ele_eff;


[dist_km,fuel_ice,fuel_motor,fuel_fc,med_ice_eff,med_motor_eff,med_fc_eff,...
    max_motor_P,max_ice_P,max_fc_P,batt_cap] = ...
    level_3_ttw(v_req,t,timestep,drive_cycle_length,slope,...
    Cd,Af,rho_air,glider_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,...
    number_of_driven_wheels,tire_radius,elec_brake_state,gearbox_type,min_w,min_n_w,...
    max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    simulate,peak_ice_T_2,peak_ice_w_2,w_at_peak_T,max_P,powertrain_type,...
    number_of_motors,front_or_rear_wheel_drive,dynamic_braking,wheelbase,distance_req,...
    distance_req_alt,fuel_tank,h,range_km,di_map,si_map,si_turbo_map,ele_map,overall_mass_fac,batt_V,range1,mj_die_km,fc_kw,e_motor_peak_T,...
    motor_selection,ESS1_selection,ESS2_selection);

[ghg_per_km,batt_cost,new_ice_cost,motor_cost,fc_cost,run_cost,gb_cost,mj_per_km,...
    mj_wtw,ghg_wtw] = level_2_outputs(dist_km,fuel_ice,fuel_motor,fuel_fc,...
    powertrain_type,max_P,range_km,max_motor_P,max_ice_P,max_fc_P,top_gear_number,...
    peak_ice_T_2,fuel_cost_petrol,fuel_cost_diesel,fuel_cost_kwh,batt_cap,batt_cost_kwh,elec_co2_per_kwh,elec_mj_per_kwh);

%[batt_cost(i,j) motor_cost(i,j) fc_cost(i,j)]


new_cap_cost = cap_cost + batt_cost + new_ice_cost + motor_cost + fc_cost ...
    + gb_cost - old_ice_cost;
% cap_cost(i)
% batt_cost(i,j)
% new_ice_cost(i,j)
% motor_cost(i,j)
% gb_cost(i,j)
% old_ice_cost(i)
 %   end
%end

%% Outputs

% [mj_per_km(1,1) mj_eff(1,1) abs((mj_eff(1,1)-mj_per_km(1,1))/mj_eff(1,1))]
% [ghg_per_km(1,1) ttw_ghg(1,1) abs((ttw_ghg(1,1)-ghg_per_km(1,1))/ttw_ghg(1,1))]
 %med_ice_eff;
%
% [mj_per_km(:,1) mj_eff' ((mj_eff'-mj_per_km(:,1))./mj_eff')];
% [ghg_per_km(:,1) ttw_ghg' abs((ttw_ghg'-ghg_per_km(:,1))./ttw_ghg')];
% % [mj_per_km mj_wtw]
% % [ghg_per_km ghg_wtw]
% mj_per_km;
% ghg_per_km
% new_cap_cost;

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
% P=powertrain      2=ice, 3=hybrid, 4=ev
global OVEM31
global OUT

pp = new_cap_cost;%(SPD(1),SPD(2));
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

%per = [1 1.5 1.5 1.8 1.5 2];
%fnc = [1 1.11 1.72 1.13 .296 .715];%median(range_km(3:4,:));
ce = ghg_per_km;%(SPD(1),SPD(2));
%ra = [1 1 1 0.01 0.01 0.005];
fc_wtw = mj_wtw;%(SPD(1),SPD(2));%wtw
ce_wtw = ghg_wtw;%(SPD(1),SPD(2)); %wtw
med_batt_cap = batt_cap;%(SPD(1),SPD(2));
mj_km = mj_per_km;%(SPD(1),SPD(2));

OVEM31=[1]; % to tell vmod1 that it has been worked!
OUT=round([pp fc*100 ce fc_wtw ce_wtw mj_km med_batt_cap]);
