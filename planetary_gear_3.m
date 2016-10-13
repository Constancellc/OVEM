function [T_f_pg_to_wheelaxle,w_f_pg_to_wheelaxle]=planetary_gear_3(T_f_gb_to_pg_from_ICE,...
    w_f_gb_to_pg_from_ICE,T_f_gb_to_pg_from_motor,w_f_gb_to_pg_from_motor,...
    pg_to_ICE_GR,pg_to_motor_GR,~,pg_eff)

%Title: planetary_gear_3
%
%Author: Reed Doucette
%
%Created: March 15, 2010
%
%Purpose: To combine the torque and speed coming from both the motor and
%ICE, apply the planetary gear's losses, and then output it to the driveaxle. 
%
%List of Inputs:
%   T_f_gb_to_pg_from_ICE           Torque coming from the ICE
%   w_f_gb_to_pg_from_ICE           Speed coming from the ICE
%   T_f_gb_to_pg_from_motor         Torque coming from the motor
%   w_f_gb_to_pg_from_motor         Speed coming from the motor
%   pg_to_ICE_GR                    Gear ratio between the the drive axle
%                                   and the ICE
%   pg_to_motor_GR                  Gear ratio between the drive axle and
%                                   the motor
%   ICE_to_motor_GR                 Gear ratio between the ICE and the
%                                   motor
%   pg_eff                          efficiency of the planetary gear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T_f_pg_to_wheelaxle=single((T_f_gb_to_pg_from_ICE*pg_to_ICE_GR+T_f_gb_to_pg_from_motor*pg_to_motor_GR)*pg_eff);
w_f_pg_to_wheelaxle=single(w_f_gb_to_pg_from_ICE/pg_to_ICE_GR+w_f_gb_to_pg_from_motor/pg_to_motor_GR);
