function [regen_status,EMS_selection,vehicle_mass_vector,DoD_initial_ESS1,DoD_initial_ESS2,CR_ESS1_initial,...
    CR_ESS2_initial,ESS1_charge_state_init,ESS2_charge_state_init,ESS1_charge_off_limit,ESS1_charge_on_limit...
    ESS2_charging_fraction,ESS2_charge_off_limit,ESS2_charge_on_limit,motorfw_selection_ESS1,...
    motorfw_selection_ESS2,v_max,gearbox_mass] = ev_parameters_3(powertrain_type,ESS1_selection,ESS2_selection,...
    glider_mass,fgb_motor_ratio,~,T_max_motor,total_motor_mass,ICE_mass,apu_mass,NoCells_ESS1,...
    ~,~,regen_var)
%Title: veh_parameter_3
%
%Author: Reed Doucette (modified by JDK Bishop)
%
%Created: May 12, 2009
%
%Purpose: To obtain and load the various parameters that will be
%charactertis to the vehicle throughout the drive cycle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Pure (battery) EV
if powertrain_type<30
     DoD_initial_ESS1=0;
   
     if ESS1_selection==0   
        NoCells_ESS1=0;
        motorfw_selection_ESS1=0;
        ESS1_mass=0;
        w_fw_initial_ESS1=0;
        CR_ESS1_initial=0;
        ESS1_energy=0;
        ESS1_power=0;
        DoD_fw_mech_initial=1;
    elseif ESS1_selection < 200    %If it is a battery of ultracapacitor
        [ESS1_mass,ESS1_Capacity,ESS1_energy,ESS1_power]=ESS_mass_calculator(ESS1_selection,NoCells_ESS1);
        CR_ESS1_initial=DoD_initial_ESS1*ESS1_Capacity;
        motorfw_selection_ESS1=0;
        w_fw_initial_ESS1=0;
        DoD_fw_mech_initial=1;
    elseif ESS1_selection > 200 && ESS1_selection<300    %If it is an electrically intergrated flywheel
        NoCells_ESS1=0;
        CR_ESS1_initial=0;
        motorfw_selection_ESS1=input('Enter the selection for the motorfw for ESS1: ');
        [motorfw_mass_ESS1]=motor_mass_calculator(motorfw_selection_ESS1,0,2);
        fw_specs_3_flybrid;
        mass_gbfw_ESS1=9; %kg
        fw_ancillary_mass=input('Enter fw ancillary mass (kg): '); %kg
        ESS1_mass=mass_fw+fw_ancillary_mass;
        w_fw_initial_ESS1=sqrt(2*(1-DoD_initial_ESS1)*E_max_fw/J_fw);
        ESS1_energy=E_max_fw; %J
        ESS1_power=120000; %W
        DoD_fw_mech_initial=1;
    elseif ESS1_selection > 300     %If it is a mechanically integrated flywheel
        NoCells_ESS1=0;
        DoD_fw_mech_initial=DoD_initial_ESS1;
        CR_ESS1_initial=0;
        motorfw_selection_ESS1=0;
        w_fw_initial_ESS1=0;
        ESS1_energy=540e3; %J
        ESS1_power=120000; %W
        fw_ancillary_mass=input('Enter fw ancillary mass (kg): '); %kg
        fw_specs_3_flybrid;
        ESS1_mass=mass_fw+fw_ancillary_mass;
        ESS1_energy=E_max_fw; %J
        ESS1_power=120000; %W
     end
          
%% Set charging thermostat parameters for ESS1

%if powertrain_type == 1 % EV
    

ESS1_charge_off_limit=.2;
ESS1_charge_on_limit=.8;
% 
% elseif powertrain_type == 3 || powertrain_type == 4 %HEV
%     ESS1_charge_off_limit=.6;
% ESS1_charge_on_limit=.8;
% else
% end

if ESS1_charge_on_limit<=ESS1_charge_off_limit
    error('ESS1_charge_on_limit needs to be greater than ESS1_charge_off_limit');
elseif ESS1_charge_on_limit>1
    error('ESS1_charge_on_limit needs to be less than or equal to 1');
elseif ESS1_charge_off_limit<0
    error('ESS1_charge_off_limit needs to be greater than or equal to zero');
end

%% Set ESS1 initial charge state (0 unless it needs to be turned on
%initially)
ESS1_charge_state_init=0;
if DoD_initial_ESS1>=ESS1_charge_on_limit
    ESS1_charge_state_init=1;
end

    DoD_initial_ESS2=0;
    
    if ESS2_selection==0   
        NoCells_ESS2=0;
        motorfw_selection_ESS2=0;
        ESS2_mass=0;
        w_fw_initial_ESS2=0;
        CR_ESS2_initial=0;
        ESS2_energy=0;
        ESS2_power=0;
    elseif ESS2_selection < 200 %If it is a battery or ultracapacitor
        NoCells_ESS2=input('Enter the number of cells of ESS2: ');
        [ESS2_mass,ESS2_Capacity,ESS2_energy,ESS2_power]=ESS_mass_calculator(ESS2_selection,NoCells_ESS2);
        CR_ESS2_initial=DoD_initial_ESS2*ESS2_Capacity;
        motorfw_selection_ESS2=0;
        w_fw_initial_ESS2=0;
    elseif ESS2_selection > 200 %If it is a flywheel
        NoCells_ESS2=0;
        CR_ESS1_initia2=0;
        motorfw_selection_ESS2=input('Enter the selection for the motorfw for ESS2: ');
        [motorfw_mass_ESS2]=motor_mass_calculator(motorfw_selection_ESS2,0,2);
        fw_specs_3_flybrid;
        mass_gbfw_ESS2=9; %kg
        %fw_ancillary_mass=mass_gbfw_ESS1+motorfw_mass_ESS1; %kg
        fw_ancillary_mass=input('Enter fw ancillary mass (kg): '); %kg
        ESS2_mass=mass_fw+fw_ancillary_mass;
        w_fw_initial_ESS2=sqrt(2*(1-DoD_initial_ESS2)*E_max_fw/J_fw);
        ESS2_energy=E_max_fw; %J
        ESS2_power=120000; %W
    end
 ESS2_charging_fraction=.5;  

%% Set charging thermostat parameters for ESS2
ESS2_charge_off_limit=.98;
ESS2_charge_on_limit=.99;
if ESS2_charge_on_limit<=ESS2_charge_off_limit
    error('ESS2_charge_on_limit needs to be greater than ESS1_charge_off_limit');
elseif ESS2_charge_on_limit>1
    error('ESS2_charge_on_limit needs to be less than or equal to 1');
elseif ESS2_charge_off_limit<0
    error('ESS2_charge_off_limit needs to be greater than or equal to zero');
end

%% Set ESS2 initial charge state (0 unless it needs to be turned on
%initially)
ESS2_charge_state_init=0;
if DoD_initial_ESS2>=ESS2_charge_on_limit
    ESS2_charge_state_init=1;
end

%Determine Regenerative Braking Status
regen_status=regen_var;%input('Enter 1 if regen is used, enter 0 if it is not used: ');

%Determine EMS
EMS_selection=1;%input('Enter EMS, 1 for thermostat, 2 for speed-based: ');
    %For speed-based EMS a maximum v must be entered
    v_max=50; %mph
    v_max=v_max*0.44704; %m/s
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EV Specific Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if powertrain_type == 1

fgb_ratio = fgb_motor_ratio;

    %Gearbox_mass
    if fgb_ratio>1
        gearbox_mass=.017*fgb_ratio*T_max_motor;
    else
        gearbox_mass=0;
    end
    
    %Determine the total mass of the vehicle
    
    vehicle_mass_vector=glider_mass+ESS1_mass+ESS2_mass+total_motor_mass+gearbox_mass;
    
    %Ask if you want to manually override the mass
    override_mass=0;%input('Enter 1 to manually override the mass: ');
    if override_mass==1
        vehicle_mass_vector=input('Enter the new mass of the vehicle: ');
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Series HEV Specific Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if powertrain_type == 2 || powertrain_type == 15;

    %Determine the total mass of the vehicle
    vehicle_mass_vector=glider_mass+ESS1_mass+ESS2_mass+total_motor_mass+apu_mass;
    gearbox_mass = 0;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parallel/Dual Specific Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if powertrain_type==3 || powertrain_type==4 || powertrain_type == 16;
    
    %Determine the total mass of the vehicle 
    vehicle_mass_vector=glider_mass+ESS1_mass+ESS2_mass+total_motor_mass+ICE_mass;  
    gearbox_mass = 0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conventional ICE-based Vehicle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if powertrain_type == 5
    
    %Ask whether dynamic effects in braking should be accounted for
    dynamic_braking=0;
    if dynamic_braking==1
        wheelbase=2.8;  %m
        longitdunal_COM_ratio=.5;
        L1=wheelbase*longitdunal_COM_ratio;         %m (distance from COM to the front wheel)
        L2=wheelbase*(1-longitdunal_COM_ratio);         %m (distance from COM to the rear wheel)
        h=.3;          %m (height of the COM)
    else
        wheelbase=0;    %m
        L1=0;           %m (distance from COM to the front wheel)
        L2=0;           %m (distance from COM to the rear wheel)
        h=0;            %m (height of the COM)
        longitdunal_COM_ratio=.5;
    end
        
    %Ask user for number of driven wheels
    number_of_driven_wheels=2;
    %Check number_of_driven wheels input
    if number_of_driven_wheels == 4 
        number_of_driven_wheels=4;
        front_or_rear_wheel_drive=4;
    elseif number_of_driven_wheels == 2
        number_of_driven_wheels=2;
        if dynamic_braking==1
            front_or_rear_wheel_drive=input('Enter 1 for Front WD and 2 for Rear WD: ');
        else
            front_or_rear_wheel_drive=0;
        end
    else
        error('The vehicle must either be 2 or 4 wheel drive');
    end
    
    if front_or_rear_wheel_drive==1
        drive_type='FWD';
    elseif front_or_rear_wheel_drive==2
        drive_type='RWD';
    elseif front_or_rear_wheel_drive==4
        drive_type='4WD';
    elseif front_or_rear_wheel_drive==0
        drive_type='N/A';
    end
    
    %Ask user whether motors are located in or out of wheel
    in_out_of_wheel=0;
    %Check motor_in_or_out_of_wheel input
    if in_out_of_wheel == 1 
        in_out_of_wheel=1;
    elseif in_out_of_wheel == 0
        in_out_of_wheel=0;
    else
        error('Enter 1 for motors in the wheel, enter 0 for motors out of the wheel');
    end

    %Inertia Calculation
    [total_driven_wheelaxle_inertia]=0;

    %Motor Characterization
    ICE_selection=input('Select the ICE that you want to be used: ');
    [ICE_mass,ICE_speed_vector,ICE_torque_vector,ICE_min_speed,ICE_max_speed,ICE_min_torque_w_profile,...
        ICE_min_torque_T_profile,ICE_min_power,ICE_max_torque_w_profile,ICE_max_torque_T_profile,ICE_max_power,...
        T_max_ICE,ICE_eff_map,ICE_fuel_heating_value,ICE_fuel_density]=ICE_selector(ICE_selection);

    %Transmission specs
    gear_ratio_vector=[6,5,4,3,2,1]'; %list in descending order
    number_of_gears=length(gear_ratio_vector);
    gearbox_mass=0.49*(gear_ratio_vector(1)*T_max_ICE)^0.58*number_of_gears^0.29;
    drive_ratio=3;
    
    %Other parameters
    DoD_fw_mech_initial=1;
    DoD_ESS1=1;
    DoD_ESS2=1;
    regen_status=0;
    ESS1_selection=0;
    ESS2_selection=0;
    number_of_motors=1;
    
    %Determine the total mass of the vehicle
    vehicle_mass_vector=glider_mass+ICE_mass+gearbox_mass;
    
    %Ask if you want to manually override the mass
    override_mass=input('Enter 1 to manually override the mass: ');
    if override_mass==1
        vehicle_mass_vector=input('Enter the new mass of the vehicle: ');
    end

end
