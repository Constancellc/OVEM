function [T_reqd_by_gb,w_reqd_by_gb,P_reqd_by_gb,vgb_b_eff,vgb_mass,vgb_cost,...
    gear_number]=gb_multispeed_backwards(~,P_reqd_by_wheelaxle,T_reqd_by_wheelaxle,...
    w_reqd_by_wheelaxle,T_max_ice,k_seal,k_bearing,k_mesh,v0,v1,tire_radius,...
    timestep,~,~,~,~,top_gear_number,top_gear_ratio,~,final_drive_ratio,gears,w_range)

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

%vgb_friction_losses = 0.075;
%differential_ratio = final_drive_ratio;
%gears = zeros(top_gear_number+1,1);
%w_segment = zeros(top_gear_number,1);
%w_range = w_segment;
% gear_ratio_range_reqd_by_gb = w_range;
% gear_ratio_error = w_segment;
T_b_gb_in = T_reqd_by_wheelaxle;
w_b_gb_in = w_reqd_by_wheelaxle; 
vgb_ratio = top_gear_ratio*final_drive_ratio;

%Compute the maximum torque output of the gearbox
T_gb_max=T_max_ice*vgb_ratio;

%Limit the efficiency 1 and some specified minimum value
minimum_vgb_b_eff=.9;

if T_b_gb_in ~= 0
    vgb_b_eff=(T_b_gb_in*w_b_gb_in)/(T_b_gb_in*w_b_gb_in+k_seal*vgb_ratio*T_gb_max*w_b_gb_in+(k_mesh+k_bearing)...
        *T_b_gb_in*w_b_gb_in);
else 
    vgb_b_eff = minimum_vgb_b_eff;
end

if vgb_b_eff>1
    vgb_b_eff=1;
elseif vgb_b_eff<=minimum_vgb_b_eff
    vgb_b_eff=minimum_vgb_b_eff;
end
vgb_friction_losses = 1 - vgb_b_eff;

%% Find ideal gear number
%Receive engine speed range which corresponds to most efficient point
%     min_n_w = min_n_w*2*pi()/60;
%     max_n_w = max_n_w*2*pi()/60;
      
%w_range = (min_n_w+max_n_w)/2;

% if T_reqd_by_wheelaxle~=0;
%     gear_ratio_range_reqd_by_gb = w_range./w_reqd_by_wheelaxle;
%     gear_ratio_error = gears-gear_ratio_range_reqd_by_gb;
%     [min_gear_ratio_error,gear_number] = min(abs(gear_ratio_error));
% else
%     gear_number=1;
% end

%% Find gear number which meets target speed and most efficient point
%     
%     if min_n_w == max_n_w;
%         w_range = max_n_w;
%     else
%         w_segment = (max_n_w-min_n_w)/top_gear_number;
%         w_range = .5*(max_n_w+min_n_w);
%     end

%If w_range > w_reqd_by_wheelaxle, w_range/w_reqd_by_wheelaxle > 1 and
%vehicle needs to select lower gear

%If w_range < w_reqd_by_wheelaxle, w_range/w_reqd_by_wheelaxle < 1 and
%vehicle needs to select higher gear

%w_reqd_by_wheelaxle = w_reqd_by_wheelaxle*final_drive_ratio;
%T_reqd_by_wheelaxle = T_reqd_by_wheelaxle/final_drive_ratio;

% if T_reqd_by_wheelaxle>0% && T_reqd_by_wheelaxle>0%> 0 && 
% %if ((v1-v0)>0 || (v1-v0)<0);   
% if w_reqd_by_wheelaxle == w_range;
%     gear_ratio_range_reqd_by_gb = ones(length(top_gear_number));
% 
% elseif w_reqd_by_wheelaxle > w_range; %Vehicle travelling at high speed - select high gear = ratio < 1
%     gear_ratio_range_reqd_by_gb = w_range/w_reqd_by_wheelaxle;
%     gear_ratio_error = gears-gear_ratio_range_reqd_by_gb;
%     [~,gear_number] = min(abs(gear_ratio_error));
%     w_reqd_by_gb = w_reqd_by_wheelaxle*gears(gear_number);
%     
% else w_reqd_by_wheelaxle < w_range; %Vehicle travelling at low speed - select low gear = ratio > 1
%     gear_ratio_range_reqd_by_gb = w_range/w_reqd_by_wheelaxle;
%     gear_ratio_error = gears-gear_ratio_range_reqd_by_gb;
%     [~,gear_number] = min(abs(gear_ratio_error));
%     w_reqd_by_gb = w_reqd_by_wheelaxle*gears(gear_number);
% 
% end
%% Works
%     gear_ratio_range_reqd_by_gb = w_range/w_reqd_by_wheelaxle;    
%     gear_ratio_error = gears-gear_ratio_range_reqd_by_gb;
%     [~,gear_number] = min(abs(gear_ratio_error));
%     w_reqd_by_gb = single(w_reqd_by_wheelaxle*gears(gear_number));

    %% Test     
% w_reqd_by_wheelaxle*final_drive_ratio.*gears
% w_range
    
    
% gear_ratio_range_reqd_by_gb = w_range/w_reqd_by_wheelaxle;%w_reqd_by_wheelaxle./gears;
% gear_ratio_error = (w_reqd_by_wheelaxle.*gears/w_range)-1;%gear_ratio_range_reqd_by_gb./gears; 
% [~,gear_number] = min(abs(gear_ratio_error));
% w_reqd_by_gb = single(w_reqd_by_wheelaxle*gears(gear_number));
%% Test 2
% gear_ratio_range_reqd_by_gb = w_reqd_by_wheelaxle/w_range;%w_reqd_by_wheelaxle./gears;
% gear_ratio_error = (w_reqd_by_wheelaxle.*gears*final_drive_ratio/w_range)-1;%gear_ratio_range_reqd_by_gb./gears; 
% [~,gear_number] = min(abs(gear_ratio_error));
% w_reqd_by_gb = single(w_reqd_by_wheelaxle*gears(gear_number))*final_drive_ratio;

%% Test 3

if abs(w_reqd_by_wheelaxle)>0
   
% [w_reqd_by_wheelaxle*final_drive_ratio w_range]
% w_range/(w_reqd_by_wheelaxle*final_drive_ratio)
% gears
% w_range/(w_reqd_by_wheelaxle*final_drive_ratio)...
%     -gears*final_drive_ratio

[~,gear_number] = min(abs(w_range/(w_reqd_by_wheelaxle*final_drive_ratio)...
    -gears*final_drive_ratio));
w_reqd_by_gb = single(w_reqd_by_wheelaxle*gears(gear_number))*final_drive_ratio;


%[~,gear_number] = min(abs((w_range/final_drive_ratio)/w_reqd_by_wheelaxle-gears));
%w_reqd_by_gb = single(w_reqd_by_wheelaxle*gears(gear_number))*final_drive_ratio;


 else
    gear_number = 1;
    w_reqd_by_gb = 0;
end

%compute the torque required to overcome gearbox inertia
   % steel_density=7861; %kg/m^3
    
   %%
   vgb_radius=top_gear_ratio*0.018; %where .018 is the radius of the motor's output shaft in meters
   
   %vgb_radius=gears(top_gear_number)*0.018; %where .018 is the radius of the motor's output shaft in meters
   %%
   %vgb_thickness=.0254; %thickness of the gear in meters
    %vgb_volume=vgb_radius^2*pi*vgb_thickness;
   % vgb_mass=vgb_volume*steel_density;
   
       vgb_mass = single(0.49 * T_max_ice^0.58 * top_gear_number^0.29);  %Taken from P 52, Automotive transmissions: 
   %fundamentals, selection, design and application; assuming cast iron gearbox
       vgb_cost= single(0.035 * T_max_ice^0.45 * top_gear_number^0.225);
   
   vgb_inertia=(vgb_mass*vgb_radius^2)/2; % N*m^2
   T_reqd_to_overcome_vgb_inertia=vgb_inertia*(v1-v0)/tire_radius/timestep;
   
%Compute the torque and speed requested by the gearbox
 
%% Find torque requested
% if v1 == v0;%T_reqd_by_wheelaxle == 0
%     T_reqd_by_gb=0;

if(v1-v0) > 0 % Accelerating
    T_reqd_by_gb=single(T_reqd_by_wheelaxle+T_reqd_to_overcome_vgb_inertia)...
        /gears(gear_number)/(1-vgb_friction_losses)/final_drive_ratio;
        
elseif (v1-v0) < 0; %Decelerating - assume mechanical brakes to be used
    T_reqd_by_gb=single(T_reqd_by_wheelaxle+T_reqd_to_overcome_vgb_inertia)...
        /gears(gear_number)*(1-vgb_friction_losses)/final_drive_ratio;  
else 
    T_reqd_by_gb = 0;
end

%%
% if P_reqd_by_wheelaxle>0
% T_reqd_by_gb = (P_reqd_by_wheelaxle./w_reqd_by_gb+T_reqd_to_overcome_vgb_inertia)...
%         /(1-vgb_friction_losses);
% else
%     T_reqd_by_gb = 0;
% end
    

%% Compute angular speed and power
% 
% if w_reqd_by_wheelaxle>0;
%      w_reqd_by_gb = w_reqd_by_wheelaxle*gears(gear_number);
% else
%     w_reqd_by_gb = 0;
% end

P_reqd_by_gb = single(T_reqd_by_gb * w_reqd_by_gb);

    

