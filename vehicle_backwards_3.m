function [F_b_vehicle_out,v_b_vehicle_out,slope_for_this_step,...
    percent_of_weight_on_front_axle,percent_of_weight_on_rear_axle]=...
    vehicle_backwards_3(v0_ach,v1_req,timestep,Cd,Af,rho_air,veh_mass,Crr,...
    ~,~,~,wheelbase,L1,L2,h,DoD_ESS1,DoD_ESS2)

%Title: vehicle
%
%Author: Reed Doucette
%
%Created: May 17, 2009
%
%Purpose: To compute the forces acting on the vehicle during the backwards
%part of the simulation
%
%List of Inputs:
%
%List of Outputs:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Determine slope for this time step
%slope_for_this_step=interp1(distance_req_alt,slope,distance_ach);
slope_for_this_step=0;

%Check that the slope is in radians
% if slope_for_this_step > pi/2 || slope_for_this_step < -pi/2
%     error('the slope is either in degrees and needs to be converted to radians or it is in radians but is greater than or less than pi/2')
% end

%acceleration due to gravity (m/s^2)
g=9.81;

%compute the velocity requested by the vehicle (m/s)
v_b_vehicle_out=(v1_req+v0_ach)/2;

%compute the drag force (N)
Fd=.5*rho_air*Cd*Af*((v1_req+v0_ach)/2)^2;

%compute the gravitational force (N)
Fg=veh_mass*g*sin(slope_for_this_step);

%compute the force required to accelerate (N)
Fa=veh_mass*(v1_req-v0_ach)/timestep;


%compute the force required to overcome the rolling resistance (N), Frr is 0
%if the vehicle's linear velocity is 0

if v_b_vehicle_out > 0
    Frr=Crr*veh_mass*g*cos(slope_for_this_step);
else
   Frr=0;
end

%compute the total force required by the vehicle (N)
F_b_vehicle_out=Fd+Fg+Fa+Frr;
%% For forces on axles

 %compute the drag force (N)
 Fd=.5*rho_air*Cd*Af*(v_b_vehicle_out/2)^2;%((v1_req+v0_ach)/2)^2;
% 
% %compute the gravitational force (N)
% Fg=veh_mass*g*single(sin(slope_for_this_step));
% 
 %compute the force required to accelerate (N)
 Fa=veh_mass*v_b_vehicle_out/timestep;%(v1_req-v0_ach)/single(timestep);
% 
% %compute the force required to overcome the rolling resistance (N), Frr is 0
% %if the vehicle's linear velocity is 0
% % 
% if v_b_vehicle_out > 0
%     Frr=Crr*veh_mass*g*single(cos(slope_for_this_step));
% else
%    Frr=0;
% end
% 
% %compute the total force required by the vehicle (N)
% F_b_vehicle_out=Fd+Fg+Fa+Frr;


%compute the force acting normal to the front axle
W_f=(veh_mass*g*(L2*cos(slope_for_this_step)-h*sin(slope_for_this_step))-Fa*h-Fd*h)/wheelbase;

%Compute the force acting normal to the rear axle
W_r=(veh_mass*g*(L1*cos(slope_for_this_step)-h*sin(slope_for_this_step))+Fa*h+Fd*h)/wheelbase;

%Compute the fraction of the force acting on the front axle
if (DoD_ESS1>.98) || (DoD_ESS2>.98)
    percent_of_weight_on_front_axle=0.5;
else
    percent_of_weight_on_front_axle=W_f/(W_f+W_r);
end

%Compute the fraction of the force acting on the rear axle
if (DoD_ESS1>.98) || (DoD_ESS2>.98)
    percent_of_weight_on_rear_axle=0.5;
else
    percent_of_weight_on_rear_axle=W_r/(W_f+W_r);
end

%%
if v_b_vehicle_out<=0
    F_b_vehicle_out=0;
end