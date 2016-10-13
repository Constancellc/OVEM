function [F_f_wheelaxle_out,v_f_wheelaxle_out,P_f_mechbrake]=...
    wheelaxle_forwards_3(T_f_wheelaxle_in,w_f_wheelaxle_in,tire_radius,...
    wheelaxle_efficiency,v1_req,v0_ach,total_driven_wheelaxle_inertia,timestep,...
    F_b_wheelaxle_in,number_of_motors)

%Title: wheelaxle_forwards_3
%
%Author: Reed Doucette
%
%Created: May 15, 2009
%
%Purpose: To calculate the force and speed supplied by the vehicle in the
%forwards part of the vehicle simulation
%
%List of Inputs:
%       T_f_wheelaxle_in: 
%           The amount of torque supplied to the wheels and axle(s)
%       w_f_wheelaxle_in:
%           The speed supplied to the wheels and axle(s)
%       tire_radius::
%           The radius of the tire in meters
%       wheelaxle_efficiency:
%           The efficiency of the wheel and axle
%       v1_req:
%           The speed the vehicle is trying to attain at the end of the
%           timestep
%       v0_ach:
%           The speed the vehicle achieved at the end of the previous
%           timestep
%
%List of Outputs:
%       F_f_wheelaxle_out:
%           The force the wheel can supply to act on the road
%       v_f_wheelaxle_out
%           The linear spped the wheel can supply
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Compute the linear speed of the wheels
v_f_wheelaxle_out=w_f_wheelaxle_in*tire_radius;

%Compute the torque required to overcome inertia (Nm)
T_reqd_to_overcome_inertia=single(total_driven_wheelaxle_inertia*(v1_req-v0_ach)/timestep/tire_radius);

%Compute the torque outputted by the wheels
if T_f_wheelaxle_in >0
    T_f_wheelaxle_out_elec=(T_f_wheelaxle_in-T_reqd_to_overcome_inertia)*wheelaxle_efficiency;
elseif T_f_wheelaxle_in<0
    T_f_wheelaxle_out_elec=(T_f_wheelaxle_in-T_reqd_to_overcome_inertia)/wheelaxle_efficiency;
else
    T_f_wheelaxle_out_elec=0;
end

%Compute the force supplied by the wheels from the motor
if number_of_motors==1
    F_f_wheelaxle_out_elec=T_f_wheelaxle_out_elec/tire_radius;
elseif number_of_motors==2
    F_f_wheelaxle_out_elec=T_f_wheelaxle_out_elec/tire_radius*2;
elseif number_of_motors==4
    F_f_wheelaxle_out_elec=T_f_wheelaxle_out_elec/tire_radius*4;
end

%Compute the amount of force required from the mechanical brake
if F_f_wheelaxle_out_elec < 0 && abs(F_f_wheelaxle_out_elec) < abs(F_b_wheelaxle_in)
    F_f_mechbrake=F_b_wheelaxle_in-F_f_wheelaxle_out_elec;
    F_f_wheelaxle_out=F_f_mechbrake+F_f_wheelaxle_out_elec;
else
    F_f_mechbrake=0;
    F_f_wheelaxle_out=F_f_mechbrake+F_f_wheelaxle_out_elec;
end

P_f_mechbrake=single(F_f_mechbrake*w_f_wheelaxle_in*tire_radius);