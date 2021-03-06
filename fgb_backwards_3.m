function [T_b_gb_out,w_b_gb_out,P_b_gb_out,fgb_b_eff]=fgb_backwards_3(T_b_gb_in,...
    w_b_gb_in,fgb_ratio,v0_ach,v1_req,tire_radius,timestep,in_out_of_wheel,T_max_motor,...
    k_seal,k_bearing,k_mesh,front_or_rear_wheel_drive)

%Title: fgb_backwards_3
%
%Author: Reed Doucette
%
%Created: May 7, 2009
%
%Purpose: To calculate the torque and speed required by the gearbox during
%the backwards phase of the drive cycle simulation.
%
%List of Inputs:
%   T_b_gb_in:
%               The torque request coming from the wheels to the gearbox in
%               the backwards phase of the simulation.
%   w_b_gb_in:
%               The speed request coming from the wheels to the gearbox in
%               the backwards phase of the simulation.
%   fgb_ratio:
%               The gear ratio of the fixed gear box.
%   v0_ach: 
%               The linear vehicle speed at the beginning of the timestep.
%   v1_req:         
%               The linear vehicle speed at the end of the timestep.
%   tire_radius:
%               The radius of the tire.
%   timestep:
%               The length of the timestep of the drive cycle (usually 1
%               sec)
%   in_out_of_wheel:
%               Indicates motor placement whether its in or out of the
%               wheel, (1 for in-wheel, 0 for out of wheel)
%   T_max_motor:
%               The maximum torque the motor can supply.  It's used for
%               scaling the seal losses.
%   k_seal:     
%               The coefficient that scales the seal friction losses
%   k_bearing:  
%               The coefficient that scales the bearing friction losses
%   k_mesh:     
%               The coefficient that scales the meshing losses.
%List of Outputs:
%   T_b_gb_out:
%               The torque request sent from the gb to the motor in the
%               backwards phase of the simulation
%   w_b_gb_out:
%               The speed request sent from the gb to the motor in the
%               backwards phase of the simulation
%   P_b_gb_out:
%               The power request sent from the gb to the motor in the
%               backwards phase of the simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimum_fgb_b_eff=.2;

%Compute the maximum torque output of the gearbox
T_gb_max=T_max_motor*fgb_ratio;

%Compute the efficiency of the gearbox and its moment of inertia
if fgb_ratio == 1 && in_out_of_wheel==1 %the case for an in wheel motor with no gearbox
    fgb_b_eff=1;
    fgb_b_inertia=0;
elseif w_b_gb_in ==0
    fgb_b_eff = minimum_fgb_b_eff;
else
    fgb_b_eff=(T_b_gb_in*w_b_gb_in)/(T_b_gb_in*w_b_gb_in+k_seal*fgb_ratio*...
        T_gb_max*w_b_gb_in+(k_mesh+k_bearing)*T_b_gb_in*w_b_gb_in);
    
    % Inertia calculation
%     steel_density=7861; %kg/m^3
%     fgb_radius=fgb_ratio*.018; %where .018 is the radius of the motor's output shaft in meters
%     fgb_thickness=.0254; %thickness of the gear in meters
%     fgb_volume=fgb_radius^2*pi*fgb_thickness;
%     fgb_mass=fgb_volume*steel_density;
    %fgb_b_inertia=single(fgb_mass*fgb_radius^2)/2; % N*m^2
end

%Override the fgb inertia
fgb_b_inertia=0;

%Square the efficiency if it's a four wheel drive vehicle
if front_or_rear_wheel_drive==4
    fgb_b_eff=fgb_b_eff^2;
end

%Limit the efficiency 1 and some specified minimum value
minimum_fgb_b_eff=.2;

if fgb_b_eff>1
    fgb_b_eff=1;
elseif fgb_b_eff<=minimum_fgb_b_eff
    fgb_b_eff=minimum_fgb_b_eff;
end
%fgb_b_eff = max([min([fgb_b_eff 1]) minimum_fgb_b_eff]);


%Compute the torque required to overcome inertia
T_reqd_to_overcome_fgb_inertia=fgb_b_inertia*(v1_req-v0_ach)/tire_radius/timestep;

%Compute the torque request sent to the motor
% if  T_b_gb_in==0
%     T_b_gb_out=0;
if (v1_req-v0_ach)>=0;
    T_b_gb_out=(T_b_gb_in+T_reqd_to_overcome_fgb_inertia)/fgb_ratio/fgb_b_eff;
else (v1_req-v0_ach)<0;
    T_b_gb_out=(T_b_gb_in+T_reqd_to_overcome_fgb_inertia)/fgb_ratio*fgb_b_eff;
end

%Compute the speed request sent to the motor 
w_b_gb_out=w_b_gb_in*fgb_ratio;

%Compute the power request sent to the motor
P_b_gb_out=(T_b_gb_out*w_b_gb_out);

%[T_b_gb_in T_reqd_to_overcome_fgb_inertia T_b_gb_out]
