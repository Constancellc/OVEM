%Title: 
function [T_max_speed_vector,T_max_profile,T_max_motor,w_max,rotor_inertia,...
    speed_range,torque_range,eff_matrix,motor_mass] = ...
    motor_specs_3_uqm_power_phase_100_scaled_for_apu(scaling_factor)
%
%Author: Reed Doucette
%
%Purpose:Power Phase 100 characteristics
%
%Updated: May 1, 2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%scaling factor
%scaling_factor=.74;

%max torque traits
T_max_speed_vector=single([0 157.47 183.91 208.59 235.62 247.37 262.65 289.09 314.36 345.50 387.21 471.24]); %rad/s
T_max_profile=single(scaling_factor*[550 550 518.546 479.003 425.082 404.412 381.046 345.997 319.036 289.379 257.925 212.092]); %Nm

%maximum torque
T_max_motor=scaling_factor*max(T_max_profile);

%max speed
w_max=max(T_max_speed_vector);  %rad/s

%rotor inertia
rotor_inertia=0;

%speed range
speed_range=0:50:450; %rpm/10
speed_range=single(10*speed_range*2*pi/60);  %rad/s

%Torque Range
torque_range=scaling_factor*(0:50:550); %Nm

%Effiency Matrix
eff_matrix=single([0.65	0.65	0.65	0.65	0.65	0.65	0.65	0.65	0.65	0.65
                0.71	0.751	0.773	0.79	0.79	0.787	0.784	0.772	0.76	0.75
                0.7     0.81	0.85	0.8625	0.875	0.878	0.875	0.875	0.872	0.868
                0.7     0.82	0.872	0.8875	0.902	0.902	0.91	0.9125	0.91	0.903
                0.7     0.82	0.876	0.9     0.9125	0.923	0.927	0.928	0.927	0.923
                0.68	0.81	0.876	0.902	0.916	0.924	0.9375	0.9375	0.9375	0.9375
                0.67	0.805	0.87	0.904	0.92	0.9375	0.95	0.94	0.94	0.94
                0.66	0.8     0.874	0.905	0.924	0.9375	0.95	0.95	0.95	0.95
                0.65	0.78	0.867	0.901	0.925	0.925	0.925	0.925	0.925	0.925
                0.65	0.76	0.861	0.895	0.928	0.928	0.928	0.928	0.928	0.928
                0.65	0.755	0.853	0.897	0.897	0.897	0.897	0.897	0.897	0.897
                0.65	0.749	0.849	0.897	0.925	0.925	0.925	0.925	0.925	0.925]);

%Mass (kg)
motor_mass=scaling_factor*101.9;