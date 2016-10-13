function [P_reqd_by_wheelaxle,T_reqd_by_wheelaxle,w_reqd_by_wheelaxle,vgb_f_eff,vgb_mass,vgb_cost,gear_number]=...
    gb_multispeed_forwards(~,P_reqd_by_gb,T_reqd_by_gb,w_reqd_by_gb,T_max_ice,k_seal,k_bearing,k_mesh,v0,v1,...
    tire_radius,timestep,~,~,~,~,top_gear_number,top_gear_ratio,~,final_drive_ratio,gears,w_range,...
    w_b_wheelaxle_to_gb)

%% Header
% This file receives torque and speed requests from the wheelaxle and
% adjusts the transmission accordingly to request the torque and speed from
% the motor/ICE which allows it to operate at its most efficient point.

%Created 29 March 2011 (Justin Bishop)

%Method: The most efficient torque and speed point of the motor is fixed
%and passed to this function.  

% Assumptions:  1) The gear_ratio_vector is the actual one corresponding to
% the vehicle and used to ensure engine operates at most efficient point.
%or
%2)The first gear is multiplied by the axle ratio of final_drive_ratio; the
% gearing is given a number of equal steps along the logarithmic curve
% joining the top and final gear ratios, transformed into a linear relation
% by log(y) = mx + c.

%% Function
%gears = gears/final_drive_ratio;

%differential_ratio = 1;%final_drive_ratio;
%gears = zeros(top_gear_number+1,1);
%w_segment = zeros(top_gear_number,1);
%w_range = w_segment;
%gear_ratio_range_reqd_by_wheelaxle = w_range;
%gear_ratio_error = w_segment;
vgb_ratio = top_gear_ratio/final_drive_ratio;

%Compute the maximum torque output of the gearbox
T_gb_max = T_max_ice*vgb_ratio;

%Limit the efficiency 1 and some specified minimum value
minimum_vgb_f_eff=.9;

if P_reqd_by_gb ~= 0;
vgb_f_eff=(T_reqd_by_gb*w_reqd_by_gb)/(T_reqd_by_gb*w_reqd_by_gb+k_seal*vgb_ratio*T_gb_max*w_reqd_by_gb+...
    (k_mesh+k_bearing)*T_reqd_by_gb*w_reqd_by_gb);
else 
    vgb_f_eff = minimum_vgb_f_eff;
end

if vgb_f_eff>1
    vgb_f_eff=1;
elseif vgb_f_eff<=minimum_vgb_f_eff
    vgb_f_eff=minimum_vgb_f_eff;
end
vgb_friction_losses = 1 - vgb_f_eff;

%Receive engine speed range which corresponds to most efficient point
%w_range = (min_n_w+max_n_w)/2;

%% Find gears nearest to ideal engine point
% if T_reqd_by_gb~=0;
%     gear_ratio_range_reqd_by_wheelaxle = w_range./w_reqd_by_gb;
%     gear_ratio_error= gears-gear_ratio_range_reqd_by_wheelaxle;
%     [min_gear_ratio_error,gear_number] = min(abs(gear_ratio_error));
% else
%     gear_number=1;
% end

%% Find gears nearest to target speed
%     if min_n_w == max_n_w;
%         w_range = max_n_w;
%     else
%         w_segment = (max_n_w-min_n_w)/top_gear_number;
%         w_range = min_n_w+w_segment;
%     end


    %compute the torque required to overcome gearbox inertia
   % steel_density=7861; %kg/m^3
   
  
   % w_range   
    vgb_radius=gears(top_gear_number)*.018; %where .018 is the radius of the motor's output shaft in meters
    %vgb_thickness=.0254; %thickness of the gear in meters
    %vgb_volume=vgb_radius^2*pi*vgb_thickness;
   % vgb_mass=vgb_volume*steel_density;
   
       vgb_mass = single(0.49 * T_max_ice^0.58 * top_gear_number^0.29);  %Taken from P 52, Automotive transmissions: 
   %fundamentals, selection, design and application; assuming cast iron gearbox
       vgb_cost= single(0.035 * T_max_ice^0.45 * top_gear_number^0.225);
  
   vgb_inertia=(vgb_mass*vgb_radius^2)/2; % N*m^2
   T_reqd_to_overcome_vgb_inertia=vgb_inertia*(v1-v0)/tire_radius/timestep;

   
   
%% Compute the torque 
% if w_reqd_by_gb >w_range ;
% 
%     gear_ratio_range_reqd_by_wheelaxle = w_reqd_by_gb/w_range;
% else
% end


%If w_range > w_reqd_by_wheelaxle, w_range/w_reqd_by_wheelaxle > 1 and
%vehicle needs to select lower gear

%If w_range < w_reqd_by_wheelaxle, w_range/w_reqd_by_wheelaxle < 1 and
%vehicle needs to select higher gear

%if T_reqd_by_gb>0 %&& T_reqd_by_gb>0;%&& 
%if (v1-v0)>0 || (v1-v0)<0 %vehicle is moving

% if w_reqd_by_gb == w_range;
%     gear_ratio_range_reqd_by_wheelaxle = ones(length(top_gear_number));
% 
% elseif w_reqd_by_gb < w_range; %Vehicle moving slowly - gear ratio > 1
%     gear_ratio_range_reqd_by_wheelaxle = w_range/w_reqd_by_gb;
%     gear_ratio_error= gears-gear_ratio_range_reqd_by_wheelaxle;
%     [~,gear_number] = min(abs(gear_ratio_error));
%     w_reqd_by_wheelaxle = w_reqd_by_gb/gears(gear_number);
%     
% else w_reqd_by_gb > w_range; %Vehicle moving quickly - gear ratio <1
%     gear_ratio_range_reqd_by_wheelaxle = w_range/w_reqd_by_gb;
%     gear_ratio_error= gears-gear_ratio_range_reqd_by_wheelaxle;
%     [~,gear_number] = min(abs(gear_ratio_error));
%     w_reqd_by_wheelaxle = w_reqd_by_gb/gears(gear_number);
% end
 %% Works
 
%    gear_ratio_range_reqd_by_wheelaxle = w_range*w_reqd_by_gb;
%     [~,gear_number] = min(abs(gears-gear_ratio_range_reqd_by_wheelaxle));
%      w_reqd_by_wheelaxle = w_reqd_by_gb/gears(gear_number);

%% Test
%    gear_ratio_range_reqd_by_wheelaxle = w_reqd_by_gb/w_range; %w_reqd_by_gb.*gears/final_drive_ratio;%w_range*w_reqd_by_gb 
   % w_reqd_by_gb
   % w_range.*gears/final_drive_ratio
   % w_reqd_by_gb/w_range.*gears/final_drive_ratio-1

%      gear_ratio_error= w_reqd_by_gb-w_range.*gears/final_drive_ratio;%(w_reqd_by_gb/w_range).*gears/final_drive_ratio-1;%gear_ratio_range_reqd_by_wheelaxle/w_range-1;%-gear_ratio_range_reqd_by_wheelaxle;
%      [~,gear_number] = min(abs(gear_ratio_error));
%      w_reqd_by_wheelaxle = w_reqd_by_gb/gears(gear_number);

   %gear_ratio_range_reqd_by_wheelaxle = w_range*w_reqd_by_gb;
%   w_range/w_reqd_by_gb
%  gears/final_drive_ratio
%   1-w_range/w_reqd_by_gb./(gears/final_drive_ratio)
%    w_reqd_by_gb./gears/final_drive_ratio
%  w_range

%     [~,gear_number] = min(abs(w_range/w_reqd_by_gb./(gears/final_drive_ratio)-1));%min(abs(gears-gear_ratio_range_reqd_by_wheelaxle));
%      w_reqd_by_wheelaxle = w_reqd_by_gb/gears(gear_number);

%% Test 2

%     [~,gear_number] = min(abs(1-(w_reqd_by_gb.*gears*final_drive_ratio/w_range)));%min(abs(gears-gear_ratio_range_reqd_by_wheelaxle));
 %    w_reqd_by_wheelaxle = w_b_wheelaxle_to_gb/gears(gear_number)/final_drive_ratio;

     %% Test 3
     
% [~,gear_number] = min(abs(w_reqd_by_gb/final_drive_ratio-w_b_wheelaxle_to_gb.*gears));
%w_reqd_by_wheelaxle = w_b_wheelaxle_to_gb/gears(gear_number);

%% Test 4

[~,gear_number] = min(abs(w_reqd_by_gb-w_b_wheelaxle_to_gb*final_drive_ratio.*gears));
w_reqd_by_wheelaxle = w_b_wheelaxle_to_gb/gears(gear_number);

     
%% Find torque requested
% if v1 == v0;%T_reqd_by_wheelaxle == 0
%     T_reqd_by_wheelaxle=0;
% 
if(v1-v0) > 0 % Accelerating
    T_reqd_by_wheelaxle=(T_reqd_by_gb+T_reqd_to_overcome_vgb_inertia)*...
        (gears(gear_number))/(1-vgb_friction_losses)*final_drive_ratio;
        
elseif (v1-v0) < 0; %Decelerating - assume mechanical brakes to be used
    T_reqd_by_wheelaxle=(T_reqd_by_gb+T_reqd_to_overcome_vgb_inertia)*...
    (gears(gear_number))*(1-vgb_friction_losses)*final_drive_ratio;
else 
    T_reqd_by_wheelaxle = 0;
    
end

%T_reqd_by_wheelaxle = (P_reqd_by_gb./w_reqd_by_wheelaxle+T_reqd_to_overcome_vgb_inertia)...
 %   /(1-vgb_friction_losses);


%T_reqd_by_wheelaxle = T_reqd_by_wheelaxle*final_drive_ratio;
%% Compute angular speed and power
% 
% if w_reqd_by_gb>0;
%      w_reqd_by_wheelaxle = w_reqd_by_gb/gears(gear_number);
% else
%     w_reqd_by_wheelaxle = 0;
% end
%w_reqd_by_wheelaxle = (w_reqd_by_wheelaxle*final_drive_ratio);
%T_reqd_by_wheelaxle = (T_reqd_by_wheelaxle*final_drive_ratio);
P_reqd_by_wheelaxle = (T_reqd_by_wheelaxle * w_reqd_by_wheelaxle);

