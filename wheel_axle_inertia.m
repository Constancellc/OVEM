function [total_driven_wheelaxle_inertia]=wheel_axle_inertia(in_out_of_wheel,number_of_driven_wheels,tire_radius)

%Title: wheel_axle_inertia
%
%Author: Reed Doucette
%
%Created: May 12, 2009
% 
%Purpose: To calculate the total inertia of the driven wheels for given
%motor layouts.
%
%List of Inputs:
%   in_out_of_wheel: 
%           1 is the motor is in the wheel, 0 if the motor is out
%           of the wheel
%   number_of_driven_wheels:
%           specifies the number of driven wheels, either 2 or 4
%
%List of Outputs:
%   total_driven_wheel_inertia:
%           the total inertia of the driven wheel and axle for the given
%           motor layout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Wheel Inertia specifications (assumes wheel is made of five
%aluminum spokes and fits a standard 2008 Toyota Carolla tire
steel_density=7861; %kg/m^3
sidewall_height=.12; %m
wheel_outer_radius=tire_radius-sidewall_height; %m
wheel_inner_radius=wheel_outer_radius-.02; %m
wheel_disc_width=.185; %m
wheel_disc_inertia=.5*pi*steel_density*wheel_disc_width*(wheel_outer_radius^4-wheel_inner_radius^4); %kg*m^2
spoke_length=wheel_inner_radius; %m
spoke_radius=.015; %m
spoke_volume=pi*spoke_radius^2*spoke_length; %m^3
spoke_mass=spoke_volume*steel_density; %kg
number_of_spokes=5; 
spoke_inertia=number_of_spokes*spoke_mass*((spoke_length^2)/3+(spoke_radius^2)/4); %kg*m^2
wheel_inertia=(spoke_inertia+wheel_disc_inertia); %kg*m^2

%Tire Inertia
rubber_density=1522; %kg/m^3
tire_thickness=.02;
tire_inertia=(.5*pi*rubber_density*wheel_disc_width*(tire_radius^4-(tire_radius-tire_thickness)^4))+(.5*pi*rubber_density*tire_thickness*(tire_radius^4-wheel_outer_radius^4)); %m^3

%Axle Inertia
axle_radius=.03; %m
steel_density=7861; %kg/m^3
axle_length=1.5; %m
axle_volume=axle_radius^2*pi*axle_length; %m^3
axle_mass=steel_density*axle_volume;
axle_inertia=.5*axle_mass*axle_radius^2;

%Calculate Wheel and Axle Inertia for 2WD out of wheel
if in_out_of_wheel == 0 && number_of_driven_wheels == 2
    total_driven_wheelaxle_inertia=2*tire_inertia+2*wheel_inertia+axle_inertia;
%Calculate wheel and axle inertia for 4WD out of wheel
elseif in_out_of_wheel == 0 && number_of_driven_wheels == 4
    total_driven_wheelaxle_inertia=4*tire_inertia+4*wheel_inertia+2*axle_inertia;
%Calculate wheel and axle inertia for 2WD in wheel 
elseif in_out_of_wheel == 1 && number_of_driven_wheels == 2
    total_driven_wheelaxle_inertia=2*tire_inertia+2*wheel_inertia;
%Calculate wheel and axle inertia for 4WD in wheel
elseif in_out_of_wheel == 1 && number_of_driven_wheels == 4
    total_driven_wheelaxle_inertia=4*tire_inertia+4*wheel_inertia;
end