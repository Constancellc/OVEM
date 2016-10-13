function [T_b_pg2_to_gb_to_ICE,w_b_pg2_to_gb_to_ICE]=planetary_gear_2_2...
    (T_f_gb_to_pg_from_motor,w_f_gb_to_pg_from_motor,pg_eff,T_b_from_pg1,...
    w_b_from_pg1,ICE_to_motor_GR,pg_to_motor_GR,pg_to_ICE_GR,w_b_wheelaxle_to_pg)

%Title:  planetary_gear_2
%
%Author: Reed Doucette
% 
%Created: March 11, 2010
%
%Purpose: This block takes the torque and speed supplied by the ICE and
%comapares them to what it asked for. If the ICE supplied more than asked
%for it sends to excess over to recharge the ESS.  It is supplies less than
%what was asked for, the motor is asked to make up the difference.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Take input torques from motor
T_b_pg2_to_gb_to_ICE = (T_b_from_pg1 - T_f_gb_to_pg_from_motor)/pg_to_ICE_GR;

%Split speed according to ratio of torques
w_b_pg2_to_gb_to_ICE = (w_b_from_pg1 - w_f_gb_to_pg_from_motor*pg_to_ICE_GR);
