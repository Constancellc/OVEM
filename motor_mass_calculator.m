function [total_motor_mass,number_of_motors]=motor_mass_calculator(motor_selection,...
    in_out_of_wheel,number_of_driven_wheels,scaling_factor)

%Title: motor_mass_calculator
%
%Author: Reed Doucette
%
%Created: May 18, 2009
%
%Purpose: To calculate the mass of total mass of the motor(s)
%
%List of Inputs:
%       motor_selection:
%           A positive integer that denotes the make and model of the motor
%           used
%       in_out_of_wheel:
%           1 for having a motor configuration where the motors are in the
%           wheel. 0 for having a motor configuration where the motors are
%           not in the wheel
%       number_of_drive_wheels:
%           Either 2 or 4 which denotes the number of driven wheels in the
%           vehicle
%
%List of Outputs:
%       total_motor_mass:
%           The total mass of the motor(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Obtain mass of the motor used
if motor_selection == 1                 %UQM power phase 100
    motor_specs_3_uqm_power_phase_100;  
elseif motor_selection ==2              %UQM power phase 150
    motor_specs_3_uqm_power_phase_150; 
elseif motor_selection==3               %Estimate of Tesla Roadster motor     
    motor_tesla_estimate;
elseif motor_selection==4               %Estimate of Gnewt Scoot Motor
    motor_gnewt_scoot_estimate;               
elseif motor_selection==5               %Estimate for scooter in EV emissions paper
    motor_specs_3_uqm_power_phase_100_scaled_for_scooter;   
elseif motor_selection==6               %Brushed DC motor
    motor_specs_3_brushed_DC;
elseif motor_selection == 7
    [~,~,~,~,~,~,~,~,motor_mass] = motor_specs_3_uqm_power_phase_100_scaled_for_apu(scaling_factor);
elseif motor_selection == 8
    [~,~,~,~,~,~,~,motor_mass] = motor_specs_3_uqm_power_phase_150_scaled(scaling_factor);
end

%Identify the number of motors used in the vehicle
if in_out_of_wheel==0
    number_of_motors=1;
elseif in_out_of_wheel==1
    if number_of_driven_wheels==2
        number_of_motors=2;
    elseif number_of_driven_wheels==4
        number_of_motors=4;
    end
end

total_motor_mass=motor_mass*number_of_motors;




    