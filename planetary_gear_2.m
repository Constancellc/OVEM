function [T_b_pg2_to_gb_to_motor,w_b_pg2_to_gb_to_motor]=planetary_gear_2...
    (T_f_gb_to_pg_from_ICE,w_f_gb_to_pg_from_ICE,pg_eff,T_requested_from_ICE_branch,...
    w_requested_from_ICE_branch,ICE_to_motor_GR,pg_to_motor_GR,~,...
    w_b_wheelaxle_to_pg)

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

%Calculate the power supplied by the ICE
P_supplied_by_the_ICE=single(T_f_gb_to_pg_from_ICE*w_f_gb_to_pg_from_ICE);

%Calculate the power requested by the ICE
P_requested_from_ICE_branch=single(T_requested_from_ICE_branch*w_requested_from_ICE_branch);

%Take the power supplied by the ICE and compare it to what it
%was asked to produce
net_power=P_requested_from_ICE_branch-P_supplied_by_the_ICE;

%If the ICE produced enough power to meet the backwards request but didn't
%exactly sync up because of rounding
if net_power <.01 && net_power> -.01
    net_power=0;
end 

%% Determine how the power flows through the pg
%For the case when the ICE did not meet the backwards power request from
%the ICE and has no excess power to charge the ESS
if net_power > 0
    T_b_pg2_to_gb_to_motor=(T_requested_from_ICE_branch-T_f_gb_to_pg_from_ICE)/pg_to_motor_GR;
    w_b_pg2_to_gb_to_motor=single(w_b_wheelaxle_to_pg*pg_to_motor_GR);
%For the case when the ICE exactly met the power request and no power
%requests pass to the motor
elseif net_power == 0
    T_b_pg2_to_gb_to_motor=0;
    w_b_pg2_to_gb_to_motor=0;
%For the case when the ICE supplied excess power to recharge the ESS
elseif net_power < 0
    T_b_pg2_to_gb_to_motor=(T_requested_from_ICE_branch-T_f_gb_to_pg_from_ICE)*pg_eff/ICE_to_motor_GR;
    w_b_pg2_to_gb_to_motor=single(w_f_gb_to_pg_from_ICE*ICE_to_motor_GR);
end 