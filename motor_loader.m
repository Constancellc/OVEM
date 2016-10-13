function [w_max,rotor_inertia,speed_range,torque_range,eff_matrix,T_max_speed_vector,...
    T_max_profile,T_max_motor]=motor_loader(motor_selection,scaling_factor)

%Title: motor_loader
%
%Author: Reed Doucette
%
%Created: May 18, 2009
%
%Purpose: To load the selected motor parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Load selected motor

if motor_selection == 1                 %USM power phase 100
    motor_specs_3_uqm_power_phase_100;
elseif motor_selection ==2              %UQM power phase 150
    motor_specs_3_uqm_power_phase_150;
elseif motor_selection==3               %Estimate of Tesla Roadster motor     
    motor_tesla_estimate;
elseif motor_selection==4               %Estimate of Gnewt Scoot motor
    motor_gnewt_scoot_estimate;
elseif motor_selection==5               %Estimate for scooter in EV emissions paper
    motor_specs_3_uqm_power_phase_100_scaled_for_scooter;  
elseif motor_selection==6               %Brushed DC motor
    motor_specs_3_brushed_DC;
elseif motor_selection == 7
[T_max_speed_vector,T_max_profile,T_max_motor,w_max,rotor_inertia,...
    speed_range,torque_range,eff_matrix,~] = motor_specs_3_uqm_power_phase_100_scaled_for_apu(scaling_factor);  

elseif motor_selection == 8
[T_max_speed_vector,T_max_profile,T_max_motor,w_max,rotor_inertia,...
    speed_range,torque_range,~] = motor_specs_3_uqm_power_phase_150_scaled(scaling_factor); 
eff_matrix = [1 1];
end