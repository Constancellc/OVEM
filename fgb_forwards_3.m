function [T_f_gb_out,w_f_gb_out,P_f_gb_out,fgb_f_eff]=fgb_forwards_3(T_f_gb_in,...
    w_f_gb_in,fgb_ratio,v0_ach,v1_req,tire_radius,timestep,~,T_max_motor,...
    k_seal,k_bearing,k_mesh)

%Title: fgb_forwards_3
%
%Author: Reed Doucette
%
%Created: May 8, 2009
%
%Purpose: To calculate the torque and speed outputted by the fixed gearbox
%during the forward phase of the simulation.
%
%List of Inputs:
%   T_f_gb_in:
%               The torque supply coming to the gearbox from the motor
%               
%   w_b_gb_in:
%               The speed supply coming from the motor to the gearbox in
%               the forwards phase of the simulation.
%   fgb_ratio:
%               The gear ratio of the fixed gear box.
%   v0_ach: 
%               The linear vehicle speed achieved at the beginning of the timestep.
%   v1_req:         
%               The linear vehicle speed requested at the end of the timestep.
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
%   T_f_gb_out:
%               The torque supply sent from the gb to the wheels in the
%               forwards phase of the simulation
%   w_f_gb_out:
%               The speed supply sent from the gb to the wheels in the
%               forwards phase of the simulation
%   P_f_gb_out:
%               The power suuply sent from the gb to the wheels in the
%               forwards phase of the simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Compute the maximum torque output of the gearbox
T_gb_max=T_max_motor*fgb_ratio;

%Compute the efficiency of the gearbox and its moment of inertia
% if fgb_ratio==1 && in_out_of_wheel == 1
%     fgb_f_eff=1;
%     fgb_f_inertia=0;
% else
    fgb_f_eff=(T_f_gb_in*w_f_gb_in-k_seal*T_gb_max*w_f_gb_in*fgb_ratio)/((1+k_mesh+k_bearing)*T_f_gb_in*w_f_gb_in);
    % Inertia calculation
    %steel_density=7861; %kg/m^3
    %fgb_radius=fgb_ratio*.018; %where .018 is the radius of the motor's output shaft in meters
    %fgb_thickness=.0254; %thickness of the gear in meters
    %fgb_volume=fgb_radius^2*pi*fgb_thickness;
    %fgb_mass=fgb_volume*steel_density;
    %fgb_f_inertia=single((fgb_mass*fgb_radius^2)/2); % N*m^2
%end

%Override the fgb forwards inertia
fgb_f_inertia=0;

%Establish upper and lower limits to the efficiency
minimum_fgb_f_eff=.2;

if fgb_f_eff>1
    fgb_f_eff=1;
elseif fgb_f_eff<minimum_fgb_f_eff
    fgb_f_eff=minimum_fgb_f_eff;
end

%fgb_f_eff = min([fgb_f_eff 1])
%fgb_f_eff = max([min([fgb_f_eff 1]) minimum_fgb_f_eff]);


%Compute the torque required to overcome inertia
T_reqd_to_overcome_fgb_inertia=(fgb_f_inertia*(v1_req-v0_ach)/tire_radius/timestep);

%Compute the torque, speed, and power outputted by the gearbox in the
%forwards simulation
if T_f_gb_in >=0;
    T_f_gb_out=(T_f_gb_in-T_reqd_to_overcome_fgb_inertia)*fgb_ratio*fgb_f_eff;
%    w_f_gb_out=w_f_gb_in/fgb_ratio;
    %P_f_gb_out=single(T_f_gb_out*w_f_gb_out);
else T_f_gb_in<0;
    T_f_gb_out=(T_f_gb_in-T_reqd_to_overcome_fgb_inertia)/fgb_ratio/fgb_f_eff;
    %w_f_gb_out=w_f_gb_in/fgb_ratio;
    %P_f_gb_out=single(T_f_gb_out*w_f_gb_out);
% else
%     T_f_gb_out=0;
%     w_f_gb_out=w_f_gb_in/fgb_ratio;
%     P_f_gb_out=T_f_gb_out*w_f_gb_out;
end

    w_f_gb_out=w_f_gb_in/fgb_ratio;

    P_f_gb_out=single(T_f_gb_out*w_f_gb_out);
