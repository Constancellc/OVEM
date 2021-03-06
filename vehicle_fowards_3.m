function [v1_ach,v1_ach_from_T_available,v1_ach_from_speed_available]=...
    vehicle_fowards_3(F_f_vehicle_in,v_f_vehicle_in,rho_air,Cd,Af,v0_ach,...
    veh_mass,timestep,Crr,slope_for_this_step)

%Title: vehicle_forwards_3;
%
%Author: Reed Doucette
%
%Created: May 18, 2009
%
%Purpose: To take the force supplied by the wheels and compute the speed
%achieved at the end of the time step.
%
%List of Inputs:
%       F_f_vehicle_in:
%           The force supplied by the wheels
%       v_f_vehicle_in:
%           The speed capable of being supplied by the wheels (m/s)
%       rho_air:
%           The density of air (kg/m^3)
%       Cd:
%           The drag coefficient of the vehicle
%       Af:
%           The frontal area oof the vehicle (m^2)
%       v0_ach:
%           The speed achieved by the vehicle at the end of the previous
%           time step
%       veh_mass:
%           The mass of the vehicle (kkg)
%       timestep:
%           The length of the current time step (s)
%       Crr:
%           The coefficient of rolling resistance
%       slope_for_this_step:
%           This is the slope the vehicle is on at the current point
%
%List of Outputs:
%       v1_ach:
%           The speed achieved by the vehicle at the end of the time step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Acceleration due to gravity (m/s^2)
g=9.81; 

%Compute the quadratic equation that yields the v1_ach as limited by the
%available torque, c needs to be determined differently (with or without
%Crr) based on whether or not the vehicle was moving at the end of the last
%time step
a=1/8*rho_air*Cd*Af;
b=1/4*rho_air*Cd*Af*v0_ach+veh_mass/timestep;

if v0_ach>0
    c=1/8*rho_air*Cd*Af*v0_ach^2-veh_mass*v0_ach/timestep-F_f_vehicle_in+Crr...
        *veh_mass*g*cos(slope_for_this_step)+veh_mass*g*sin(slope_for_this_step);
else
    c=1/8*rho_air*Cd*Af*v0_ach^2-veh_mass*v0_ach/timestep-F_f_vehicle_in+...
        veh_mass*g*sin(slope_for_this_step);
    
end

%v1 computed via the quadratic eqn.  It is the speed at the end of the
%timestep that is limited by the available torque from the system
if (b^2-4*a*c)<=0 || isreal(b^2-4*a*c)==0
    v1_ach_from_T_available=0;
else
    v1_ach_from_T_available=single((-b+sqrt(b^2-4*a*c))/2/a);
end

%Compute the v1_ach as limited by the available speed
% imag(b^2-4*a*c)
% b
% b^2-4*a*c
% -b+sqrt(b^2-4*a*c)
% (-b+sqrt(b^2-4*a*c))/2/a
% v1_ach_from_T_available
v1_ach_from_speed_available=single(2*v_f_vehicle_in-v0_ach);

%Determine which speed will be used as the final speed achieved.  It is the
%lesser of the speeds calculated from the speed limited and torque limited
%methods
% if abs(v1_ach_from_speed_available) == 0 || abs(v1_ach_from_T_available)==0
%     v1_ach=v1_ach_from_speed_available + v1_ach_from_T_available;
%     
if abs(v1_ach_from_speed_available) <= abs(v1_ach_from_T_available)
%     v1_ach=max([v1_ach_from_speed_available 0]);
v1_ach = v1_ach_from_speed_available;
elseif abs(v1_ach_from_speed_available) >= abs(v1_ach_from_T_available)
%     v1_ach=max([v1_ach_from_T_available 0]);
v1_ach = v1_ach_from_T_available;
end


%By basing the aerodynamic force that must be overcome on the average
%velocity over the time step, it is possible to have force requests that
%are actually greater than the vehicle would see especially at when there
%is a big difference between the power requested to meet the drive cycle
%and the power the vehicle can supply (e.g. with a low SOC in the ESS), so
%we limit the velocity achieved to 0.

% if v1_ach<0
%     v1_ach=0;
% end

v1_ach = max([v1_ach 0]);
