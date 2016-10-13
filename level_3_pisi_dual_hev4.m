function [max_ice_kw,max_motor_kw,fuel_ice,fuel_motor,motor_eff_f,fgb_to_ICE_b_eff,timestep,v_ach,...
    vgb_mass,batt_kwh,I_ESS1,DoD_ESS1,NoCells_ESS1_par,volume_of_fuel_used_by_ICE,final_veh_mass]=level_3_pisi_dual_hev4(powertrain_type,v_req,~,timestep,drive_cycle_length,slope,Cd,Af,rho_air,...
    veh_mass,Crr,total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,tire_radius,...
    ~,final_drive_ratio,~,front_or_rear_wheel_drive,dynamic_braking,wheelbase,L1,L2,h,~,distance_req_alt,batt_cap,overall_mass_fac,...
    batt_V,si_map,ele_map,max_P,peak_ice_T,~,simulate,top_gear_ratio,~,min_n_w,max_n_w,peak_ice_w,gear_ratio_vector,scaling_factor,...
motor_selection,ESS1_selection,ESS2_selection,regen_var)

wheelaxle_efficiency=1;
%Gearbox Parameters
k_seal=0.00103;
k_mesh=0.02;
k_bearing=0.005;

%% Obtain the specs for that particular ICE
apu_mass = 0;
ICE_selection = 1;
% % 
% [~,~,ICE_min_speed,ICE_max_speed,~,...
%     ICE_min_torque_T_profile,~,~,ICE_max_torque_T_profile,...
%     ~,ICE_fuel_heating_value,ICE_fuel_density,ICE_mass,T_max_ICE]=ICE_loader(ICE_selection);
% 
% %Set ICE specs for the control strategy
% cs_min_speed=(ICE_max_speed-ICE_min_speed)*.1+ICE_min_speed;
% cs_min_torque=(ICE_max_torque_T_profile-ICE_min_torque_T_profile)*.1+ICE_min_torque_T_profile;

%% Find most efficient engine point
si_map = single(si_map/100);
max_si_ice_2_eff= max(max(si_map));
[~,c] = find(si_map == max_si_ice_2_eff);
w_range = c/100*peak_ice_w;

%% Gearbox
top_gear_number = 100;%CVT
simulate = 1;
gears = find_gear_ratio(simulate,final_drive_ratio,top_gear_ratio,...
    top_gear_number,peak_ice_w,w_range);

%% Use variable ICE size

min_P = 0;
ice_sp = 590;%W/kg
ICE_mass = max_P*(1/ice_sp);

max_w = peak_ice_w;
min_w = 500*2*pi()/60;
min_T = 0;
max_T = peak_ice_T;
% ICE_mass = .0018*max_P * (1+overall_mass_fac);
%     
% %Set ICE specs for the control strategy
cs_min_speed=(max_w-min_w)*.1+min_w;
cs_min_torque=min_T*ones(1,100);
ICE_speed_vector = single(linspace(0,1,100) .* max_w);
ICE_torque_vector = single(linspace(0,1,100) .* max_T);
ICE_min_torque_w_profile = ICE_speed_vector;
ICE_min_torque_T_profile = ICE_torque_vector;
ICE_max_torque_w_profile = ICE_speed_vector;
ICE_max_torque_T_profile = ICE_torque_vector;

ICE_fuel_heating_value=38.4095e6; %J/kg
ICE_fuel_density= 0.74049; %kg/L

%% Motor Characterization
%motor_selection=7;% = UQM motor %input('Select the motor that you want to be used: ');
[total_motor_mass,number_of_motors]=motor_mass_calculator(motor_selection,motor_in_or_out_of_wheel,...
    number_of_driven_wheels,scaling_factor);

[w_max,rotor_inertia,speed_range,torque_range,eff_matrix,T_max_speed_vector,T_max_profile,T_max_motor]=...
    motor_loader(motor_selection,scaling_factor);

if motor_selection == 8
    eff_matrix = ele_map/100;
else
end

%% Make battery
[batt_kwh,NoCells_ESS1,NoCells_ESS2,NoCells_ESS1_par,NoCells_ESS1_ser] ...
    = make_batt(ESS1_selection,ESS2_selection,batt_V,batt_cap);

fgb_ICE_ratio = final_drive_ratio;
fgb_motor_ratio= final_drive_ratio;

[regen_status,EMS_selection,vehicle_mass_vector,DoD_initial_ESS1,DoD_initial_ESS2,...
    CR_ESS1_initial,CR_ESS2_initial,ESS1_charge_state_init,~,ESS1_charge_off_limit,...
    ESS1_charge_on_limit,ESS2_charging_fraction,~,ESS2_charge_on_limit,...
    motorfw_selection_ESS1,motorfw_selection_ESS2,v_max,gearbox_mass] = ...
    ev_parameters_3(powertrain_type,ESS1_selection,ESS2_selection,veh_mass,...
    fgb_motor_ratio,fgb_ICE_ratio,T_max_motor,total_motor_mass,ICE_mass,apu_mass,...
    NoCells_ESS1,NoCells_ESS2,ICE_selection,regen_var);

   new_mass = vehicle_mass_vector(1) - veh_mass;
   veh_mass = veh_mass + new_mass*(1+overall_mass_fac);
   final_veh_mass = veh_mass;
   NoCells_ESS1 = NoCells_ESS1_ser; %Ensures that bus V is around batt_V and not the product of all batt cells

%% Determine the planetary gear's specs

%Planetary Gear Specifications
    
    %Planetary Gear torque's (x-axis)
    pg_eff_profile_index=single(0.02:.02:1);
    %Planetary gear efficiencies at those torques (y-axis)
    pg_eff_profile=single([0.909356514 0.909338908 0.909321303 0.909303697 0.909286092 0.909268486 ...
        0.90925088 0.909233275 0.909215669 0.909198063 0.909180458 0.909162852 0.909145246 ...
        0.909127641 0.909110035 0.909551782 0.910602439 0.911653096 0.912703752 0.913754409 ...
        0.914788971 0.915678684 0.916568397 0.917458109 0.918347822 0.919237535 0.920127247 ...
        0.92101696 0.921906673 0.922796386 0.923686098 0.924575811 0.925465524 0.926355236 ...
        0.927244949 0.928134662 0.929024374 0.929914087 0.9308038 0.931693513 0.932583225 ...
        0.933472938 0.934362651 0.935252363 0.936142076 0.937031789 0.937921501 0.938811214 ...
        0.939700927 0.940590639]);
    
    %Gear ratio between PG and ICE
    pg_to_ICE_GR=1;
    %Gear ratio between PG and motor
    pg_to_motor_GR=1;
    %Gear ratio between ICE and motor
    ICE_to_motor_GR=1;
  
powerplants_max_torque=T_max_motor*fgb_motor_ratio*pg_to_motor_GR+max(ICE_max_torque_T_profile)...
    *fgb_ICE_ratio*pg_to_ICE_GR;

%%
    %Velocity Achieved Vector Generation
    v_ach=single(zeros(drive_cycle_length,1));
    v_ach(1)=v_req(1);

    %Distance Achieved Scalar Initialization
    distance_ach=0;

    %Backwards vehicle vector generation
    F_b_vehicle_to_wheelaxle=zeros(drive_cycle_length-1,1);
    v_b_vehicle_to_wheelaxle=single(zeros(drive_cycle_length-1,1));

    %Backwards wheelaxle vector generation
    T_b_wheelaxle_to_pg=zeros(drive_cycle_length-1,1);
    w_b_wheelaxle_to_pg=zeros(drive_cycle_length-1,1);
    P_b_wheelaxle_to_pg=zeros(drive_cycle_length-1,1);
    
    %Planetary gear vector generation
    pg_eff=zeros(drive_cycle_length-1,1);
    T_b_pg1_out=zeros(drive_cycle_length-1,1);
    w_b_pg1_out=zeros(drive_cycle_length-1,1);
    T_b_pg2_out=zeros(drive_cycle_length-1,1);
    w_b_pg2_out=zeros(drive_cycle_length-1,1);
    T_f_pg_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    w_f_pg_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    
    %Backwards ICE gear box vector generation
    T_b_gb_to_ICE=zeros(drive_cycle_length-1,1);
    w_b_gb_to_ICE=zeros(drive_cycle_length-1,1);
    P_b_gb_to_ICE=zeros(drive_cycle_length-1,1);
    fgb_to_ICE_b_eff=zeros(drive_cycle_length-1,1);    
    
    %ICE vector generation
    w_f_ICE_to_gb=zeros(drive_cycle_length-1,1);
    T_f_ICE_to_gb=zeros(drive_cycle_length-1,1);
    ICE_eff=zeros(drive_cycle_length-1,1);
    volume_of_fuel_used_by_ICE=zeros(drive_cycle_length-1,1);
    
    %Forwards ICE gear box vector generation
    T_f_gb_to_pg_from_ICE=zeros(drive_cycle_length-1,1);
    w_f_gb_to_pg_from_ICE=zeros(drive_cycle_length-1,1);
    %P_f_gb_to_pg=zeros(drive_cycle_length-1,1);
    %fgb_to_pg_from_ICE_f_eff=zeros(drive_cycle_length-1,1);
    
    %Backwards motor gear box vector generation
    T_b_gb_to_motor=zeros(drive_cycle_length-1,1);
    w_b_gb_to_motor=zeros(drive_cycle_length-1,1);
    P_b_gb_to_motor=zeros(drive_cycle_length-1,1);
    fgb_to_motor_b_eff=zeros(drive_cycle_length-1,1);
    
    %Backwards motor vector generation
    P_b_motor_to_elecbus=zeros(drive_cycle_length-1,1);
    w_b_motor_to_elecbus=zeros(drive_cycle_length-1,1);
    T_b_motor_to_elecbus=zeros(drive_cycle_length-1,1);
    motor_eff_b=zeros(drive_cycle_length-1,1);

    %Bus vector generation
    DoD_ESS1=zeros(drive_cycle_length-1,1);
    DoD_ESS1(1)=DoD_initial_ESS1;
    DoD_ESS2=zeros(drive_cycle_length-1,1);
    DoD_ESS2(1)=DoD_initial_ESS2;
    P_supp_ESS1=zeros(drive_cycle_length-1,1);
    P_supp_ESS2=zeros(drive_cycle_length-1,1);
    CR_ESS1=zeros(drive_cycle_length-1,1);
    CR_ESS1(1)=CR_ESS1_initial;
    CR_ESS2=zeros(drive_cycle_length-1,1);
    CR_ESS2(1)=CR_ESS2_initial;
    I_ESS1=zeros(drive_cycle_length-1,1);
    I_ESS2=zeros(drive_cycle_length-1,1);
    V_ESS1=zeros(drive_cycle_length-1,1);
    V_ESS2=zeros(drive_cycle_length-1,1);
    Pmax_ESS1=zeros(drive_cycle_length-1,1);
    Pmax_ESS2=zeros(drive_cycle_length-1,1);
    P_f_bus_to_motor=zeros(drive_cycle_length-1,1);
    P_reqd_from_ESS2=zeros(drive_cycle_length-1,1);
    ESS1_charge_state_vector=zeros(drive_cycle_length-1,1);
    %ESS2_charge_state_vector=zeros(drive_cycle_length-1,1);
    %H2_used_by_apu=zeros(drive_cycle_length-1,1);
    
    %Forwards Motor vector generation
    T_f_motor_to_gb=zeros(drive_cycle_length-1,1);
    w_f_motor_to_gb=zeros(drive_cycle_length-1,1);
    motor_eff_f=zeros(drive_cycle_length-1,1);

    %Forwards motor gear box vector generation
    T_f_gb_to_pg_from_motor=zeros(drive_cycle_length-1,1);
    w_f_gb_to_pg_from_motor=zeros(drive_cycle_length-1,1);
    P_f_gb_to_pg_from_motor=zeros(drive_cycle_length-1,1);
    fgb_to_motor_f_eff=zeros(drive_cycle_length-1,1);
    percent_of_weight_on_front_axle = fgb_to_motor_f_eff;
    percent_of_weight_on_rear_axle = fgb_to_motor_f_eff;
    
    %Forwards wheel/axle vector generation
    F_f_wheelaxle_to_vehicle=zeros(drive_cycle_length-1,1);
    v_f_wheelaxle_to_vehicle=zeros(drive_cycle_length-1,1);
    P_f_mechbrake=zeros(drive_cycle_length-1,1);
    
    
    %ESS2_charge_state=zeros(drive_cycle_length-1,1);
    
    %Mechanical Flywheel integration
    %DoD_fw_mech=zeros(drive_cycle_length,1);
    %DoD_fw_mech(1)=DoD_fw_mech_initial;
    %P_b_mech_fw=zeros(drive_cycle_length-1,1);
    
    %Backwards ICE vector generation
    ice_b_eff=zeros(drive_cycle_length-1,1);
    %fuel_energy_demand = zeros(drive_cycle_length,1);
    %P_reqd_by_ice = ice_b_eff;
    %T_reqd_by_ice = ice_b_eff;
    %w_reqd_by_ice = ice_b_eff;
    %P_f_reqd_by_ice = ice_b_eff;
  %  T_f_reqd_by_ice = ice_b_eff;
   % w_f_reqd_by_ice = ice_b_eff;
    gear_number = ice_b_eff;
    gear_number_f = gear_number;
    

    for i=1:drive_cycle_length-1

%Vehicle backwards
[F_b_vehicle_to_wheelaxle(i),v_b_vehicle_to_wheelaxle(i),slope_for_this_step,...
    percent_of_weight_on_front_axle(i),percent_of_weight_on_rear_axle(i)]=vehicle_backwards_3(v_ach(i),...
    v_req(i+1),timestep,Cd,Af,rho_air,veh_mass,Crr,distance_ach,distance_req_alt,...
    slope,wheelbase,L1,L2,h,DoD_ESS1(i),DoD_ESS2(i));

%Wheel/axle backwards

[T_b_wheelaxle_to_pg(i),w_b_wheelaxle_to_pg(i),P_b_wheelaxle_to_pg(i)]=wheelaxle_backwards_3(F_b_vehicle_to_wheelaxle(i),...
    v_b_vehicle_to_wheelaxle(i),v_ach(i),v_req(i+1),tire_radius,timestep,...
    total_driven_wheelaxle_inertia,motor_in_or_out_of_wheel,number_of_driven_wheels,...
    wheelaxle_efficiency,regen_status,percent_of_weight_on_front_axle(i),...
    percent_of_weight_on_rear_axle(i),front_or_rear_wheel_drive,dynamic_braking);        

% %in the case of a mechanically integrated flywheel
%         if ESS1_selection>300 || ESS2_selection>300
%             [P_b_mech_fw(i),DoD_fw_mech(i+1)]=fw_mech_system_model_3(T_b_wheelaxle_to_pg(i),w_b_wheelaxle_to_pg(i),DoD_fw_mech(i),i,timestep);
%             if w_b_wheelaxle_to_pg(i)==0
%                 T_b_wheelaxle_to_pg(i)=0;
%             else
%                 T_b_wheelaxle_to_pg(i)=(P_b_wheelaxle_to_pg(i)-P_b_mech_fw(i))/w_b_wheelaxle_to_pg(i);
%         
%             end
%         end

%Planetary gear 1
[pg_eff(i),T_b_pg1_out(i),w_b_pg1_out(i)]=planetary_gear_1(powerplants_max_torque,...
    T_b_wheelaxle_to_pg(i),w_b_wheelaxle_to_pg(i),pg_eff_profile,...
    pg_eff_profile_index,pg_to_ICE_GR,pg_to_motor_GR);
        
%Route to ICE if its a positive torque request (motoring), route to motor it is a negative torque request (braking)
        
%if T_b_wheelaxle_to_pg(i)>=0;
    %Apply ICE to pg/driveshaft GR
    T_b_pg1_out(i)=T_b_pg1_out(i)/pg_to_ICE_GR;
    w_b_pg1_out(i)=w_b_pg1_out(i)/pg_to_ICE_GR;
%%    
%    % GB backwards for the ICE
%     [T_b_gb_to_ICE(i),w_b_gb_to_ICE(i),P_b_gb_to_ICE(i),fgb_to_ICE_b_eff(i)]=...
%         fgb_backwards_3(T_b_pg1_out(i),w_b_pg1_out(i),fgb_ICE_ratio,0,0,...
%         tire_radius,timestep,motor_in_or_out_of_wheel,peak_ice_T,k_seal,k_bearing,...
%         k_mesh,front_or_rear_wheel_drive);
%             
% %     %ICE
% %     [w_f_ICE_to_gb(i),T_f_ICE_to_gb(i),ICE_eff(i),volume_of_fuel_used_by_ICE(i)]=ICE_parallel_dual_model...
% %         (T_b_gb_to_ICE(i),w_b_gb_to_ICE(i),DoD_ESS1(i),DoD_ESS2(i),ESS1_charge_on_limit,ESS2_charge_on_limit,...
% %         cs_min_speed,cs_min_torque,ICE_speed_vector,ICE_torque_vector,ICE_min_speed,ICE_max_speed,...
% %         ICE_min_torque_w_profile,ICE_min_torque_T_profile,ICE_min_power,ICE_max_torque_w_profile,...
% %         ICE_max_torque_T_profile,ICE_eff_map,ICE_fuel_heating_value,ICE_fuel_density,timestep,powertrain_type);
%             
%         %ICE
%     [w_f_ICE_to_gb(i),T_f_ICE_to_gb(i),ICE_eff(i),volume_of_fuel_used_by_ICE(i)]...
%         =ICE_parallel_dual_model(T_b_gb_to_ICE(i),w_b_gb_to_ICE(i),DoD_ESS1(i),...
%         DoD_ESS2(i),ESS1_charge_on_limit,ESS2_charge_on_limit,...
%         cs_min_speed,cs_min_torque,ICE_speed_vector,ICE_torque_vector,min_w,max_w,...
%         ICE_min_torque_w_profile,ICE_min_torque_T_profile,min_P,ICE_max_torque_w_profile,...
%         ICE_max_torque_T_profile,si_map,ICE_fuel_heating_value,ICE_fuel_density,timestep,powertrain_type);
%     
%     %GB forwards for the ICE
%     [T_f_gb_to_pg_from_ICE(i),w_f_gb_to_pg_from_ICE(i),P_f_gb_to_pg(i),...
%         fgb_to_pg_from_ICE_f_eff(i)]=fgb_forwards_3(T_f_ICE_to_gb(i),...
%         w_f_ICE_to_gb(i),fgb_ICE_ratio,0,0,tire_radius,timestep,motor_in_or_out_of_wheel,...
%         peak_ice_T,k_seal,k_bearing,k_mesh);

%Planetary gear 2
[T_b_pg2_out,w_b_pg2_out]=planetary_gear_2_2(T_f_gb_to_pg_from_motor,...
    w_f_gb_to_pg_from_motor,pg_eff,T_b_pg1_out,w_b_pg1_out,ICE_to_motor_GR,...
    pg_to_motor_GR,pg_to_ICE_GR,w_b_wheelaxle_to_pg);

%% Priority to motor, ICE to supplement
%GB backwards to the motor
[T_b_gb_to_motor(i),w_b_gb_to_motor(i),P_b_gb_to_motor(i),fgb_to_motor_b_eff(i)] ...
    = fgb_backwards_3(T_b_pg1_out(i),w_b_pg1_out(i),fgb_motor_ratio,0,0,tire_radius,...
    timestep,motor_in_or_out_of_wheel,T_max_motor,k_seal,k_bearing,k_mesh,front_or_rear_wheel_drive); 
        
%Motor backwards
[P_b_motor_to_elecbus(i),w_b_motor_to_elecbus(i),T_b_motor_to_elecbus(i),TperP,motor_eff_b(i)] ...
    =motor_backwards_3(T_b_gb_to_motor(i),w_b_gb_to_motor(i),0,0,w_max,rotor_inertia,...
    speed_range,torque_range,eff_matrix,timestep,T_max_speed_vector,T_max_profile,number_of_motors);
        
%EV electric bus
if i==1 % account for zero charge being removed prior to the first time step
            CR_prev_ESS1=CR_ESS1_initial;
            CR_prev_ESS2=CR_ESS2_initial;
            DoD_prev_ESS1=DoD_initial_ESS1;
            DoD_prev_ESS2=DoD_initial_ESS2;
            Pmax_prev_ESS2=inf;
            ESS1_charge_state=ESS1_charge_state_init;
        
else
            CR_prev_ESS1=CR_ESS1(i);
            CR_prev_ESS2=CR_ESS2(i);
            DoD_prev_ESS1=DoD_ESS1(i);
            DoD_prev_ESS2=DoD_ESS2(i);
            Pmax_prev_ESS2=Pmax_ESS2(i-1);
            ESS1_charge_state=ESS1_charge_state_vector(i);   
        
end

[DoD_ESS1(i+1),DoD_ESS2(i+1),P_supp_ESS1(i),P_supp_ESS2(i),CR_ESS1(i+1),...
    CR_ESS2(i+1),I_ESS1(i),I_ESS2(i),V_ESS1(i),V_ESS2(i),Pmax_ESS1(i),...
    Pmax_ESS2(i),P_f_bus_to_motor(i),ESS1_charge_state_vector(i+1),P_reqd_from_ESS2(i),...
    ~,~,~,~,~,~,~,~,~,~,~]=ev_bus_3(P_b_motor_to_elecbus(i),i,CR_prev_ESS1,...
    CR_prev_ESS2,DoD_prev_ESS1,DoD_prev_ESS2,DoD_initial_ESS1,DoD_initial_ESS2,...
    NoCells_ESS1,NoCells_ESS2,timestep,ESS1_selection,ESS2_selection,...
    ESS1_charge_off_limit,ESS1_charge_on_limit,Pmax_prev_ESS2,ESS2_charging_fraction,...
    ESS1_charge_state,motorfw_selection_ESS1,motorfw_selection_ESS2,EMS_selection,...
    v_b_vehicle_to_wheelaxle(i),v_max,NoCells_ESS1_par);
        
%Motor forwards
[T_f_motor_to_gb(i),w_f_motor_to_gb(i),motor_eff_f(i)]=motor_forwards_3(P_f_bus_to_motor(i),...
    w_b_motor_to_elecbus(i),speed_range,torque_range,eff_matrix,TperP,T_b_gb_to_motor(i),...
    T_max_speed_vector,T_max_profile,number_of_motors);

%GB forwards
[T_f_gb_to_pg_from_motor(i),w_f_gb_to_pg_from_motor(i),P_f_gb_to_pg_from_motor(i),...
    fgb_to_motor_f_eff(i)]=fgb_forwards_3(T_f_motor_to_gb(i),w_f_motor_to_gb(i),fgb_motor_ratio,...
    0,0,tire_radius,timestep,motor_in_or_out_of_wheel,T_max_motor,k_seal,k_bearing,k_mesh);
       
%else %If the vehicle is braking
            
    %Apply motor to pg/driveshaft GR
%    T_b_pg1_out(i)=T_b_pg1_out(i)/pg_to_motor_GR;
 %   w_b_pg1_out(i)=w_b_pg1_out(i)/pg_to_motor_GR;
            
    %Take the pg1 output and apply it directly to the motor branch
  %  T_b_pg2_out(i)=T_b_pg1_out(i);
  %  w_b_pg2_out(i)=w_b_pg1_out(i);
        
%end
      
%% Gb backwards       
[T_b_gb_to_ICE(i),w_b_gb_to_ICE(i),P_b_gb_to_ICE(i),~,~,~,gear_number(i)]= gb_multispeed_backwards(max_P,...
    T_b_pg2_out(i)*w_b_pg2_out(i),T_b_pg2_out(i),w_b_pg2_out(i),peak_ice_T,k_seal,...
    k_bearing,k_mesh,v_ach(i),v_req(i+1),tire_radius,timestep,min_w,peak_ice_w,...
    min_n_w,max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    gears,w_range); 

%ICE
    [w_f_ICE_to_gb(i),T_f_ICE_to_gb(i),ICE_eff(i),volume_of_fuel_used_by_ICE(i)]=...
        ICE_parallel_dual_model(T_b_gb_to_ICE(i),w_b_gb_to_ICE(i),DoD_ESS1(i),...
        DoD_ESS2(i),ESS1_charge_on_limit,ESS2_charge_on_limit,cs_min_speed,...
        cs_min_torque,ICE_speed_vector,ICE_torque_vector,min_w,max_w,...
        ICE_min_torque_w_profile,ICE_min_torque_T_profile,min_P,...
        ICE_max_torque_w_profile,ICE_max_torque_T_profile,si_map,...
        ICE_fuel_heating_value,ICE_fuel_density,timestep,powertrain_type);

%GB forwards
[~,T_f_gb_to_pg_from_ICE(i),w_f_gb_to_pg_from_ICE(i),~,~,~,gear_number_f(i)]=gb_multispeed_forwards(max_P,...
    T_f_ICE_to_gb(i)*w_f_ICE_to_gb(i),T_f_ICE_to_gb(i),w_f_ICE_to_gb(i),peak_ice_T,k_seal,...
    k_bearing,k_mesh,v_ach(i),v_req(i+1),tire_radius,timestep,min_w,peak_ice_w,...
    min_n_w,max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,...
     final_drive_ratio,gears,w_range,w_b_pg2_out(i));
 
 %%

%Planetary Gear 3  
[T_f_pg_to_wheelaxle(i),w_f_pg_to_wheelaxle(i)]=planetary_gear_3(T_f_gb_to_pg_from_ICE(i),...
    w_f_gb_to_pg_from_ICE(i),T_f_gb_to_pg_from_motor(i),w_f_gb_to_pg_from_motor(i),...
    pg_to_ICE_GR,pg_to_motor_GR,ICE_to_motor_GR,pg_eff(i));
        
%Wheel/axle forwards
[F_f_wheelaxle_to_vehicle(i),v_f_wheelaxle_to_vehicle(i),P_f_mechbrake(i)]=wheelaxle_forwards_3...
    (T_f_pg_to_wheelaxle(i),w_f_pg_to_wheelaxle(i),tire_radius,wheelaxle_efficiency,v_req(i+1),...
    v_ach(i),total_driven_wheelaxle_inertia,timestep,F_b_vehicle_to_wheelaxle(i),number_of_motors);
        
%Vehicle forwards
[v_ach(i+1)]=vehicle_fowards_3(F_f_wheelaxle_to_vehicle(i),v_f_wheelaxle_to_vehicle(i),...
    rho_air,Cd,Af,v_ach(i),veh_mass,timestep,Crr,slope_for_this_step);
        
%Compute the distance achieved
%distance_ach=single(trapz(t,v_ach)/1000);
    
    end

%% Outputs
% for i=1:length(ICE_eff)
%     if w_f_ICE_to_gb(i) ==0 || T_f_ICE_to_gb(i) == 0;
%         P_from_ICE(i) = 0;
%     else P_from_ICE(i)= w_f_ICE_to_gb(i)*T_f_ICE_to_gb(i)/ICE_eff(i);
%     end
% end
% % 

% figure(7)
% % plot(P_supp_by_apu)
% % hold on
% plot(P_supp_ESS1,'r')
% hold on
% plot(P_b_motor_to_elecbus,'g')
% hold on
% plot(w_f_ICE_to_gb.*T_f_ICE_to_gb,'b')
% legend('Battery','Motor','ICE')
% hold off
  
% figure(6)
% plot(w_f_pg_to_wheelaxle.*T_f_pg_to_wheelaxle/1000,'g')
% hold on
% plot(P_b_wheelaxle_to_pg/1000,'g--')
% hold on
% plot(w_b_pg1_out.*T_b_pg1_out/1000)
% hold on
% plot(w_b_pg2_out.*T_b_pg2_out/1000,'r')
% hold on
% plot(w_f_ICE_to_gb.*T_f_ICE_to_gb/1000,'k')
% hold on
% plot(P_b_gb_to_ICE/1000,'k--')
% legend('PG -> wheelaxle','wheelaxle -> PG','PG -> GB','PG -> motor','ICE -> GB','GB -> ICE')
% ylabel('Power (kW)')
% hold off
% 
% figure(4)
% plot(w_f_pg_to_wheelaxle,'g')
% hold on
% plot(w_b_wheelaxle_to_pg,'g--')
% hold on
% plot(w_b_gb_to_ICE)
% hold on
% plot(w_f_gb_to_pg_from_ICE,'b--')
% hold on
% plot(w_b_gb_to_motor,'k')
% hold on
% plot(w_f_gb_to_pg_from_motor,'k--')
% hold on
% plot(w_b_pg2_out,'r')
% hold on
% plot(w_b_pg1_out,'r--')
% legend('PG -> wheelaxle','wheelaxle -> PG','GB -> ICE','ICE -> GB',...
%     'GB -> motor', 'motor -> GB')
% ylabel('Speed (rad/s)')
% hold off
% 
% figure(5)
% plot(T_f_pg_to_wheelaxle,'g')
% hold on
% plot(T_b_wheelaxle_to_pg,'g--')
% hold on
% plot(T_b_gb_to_ICE)
% hold on
% plot(T_f_gb_to_pg_from_ICE,'b--')
% hold on
% plot(T_b_gb_to_motor,'k--')
% hold on
% plot(T_f_gb_to_pg_from_motor,'k')
% 
% legend('PG -> wheelaxle','wheelaxle -> PG','GB -> ICE','ICE -> GB',...
%     'GB -> motor', 'motor -> GB')
% ylabel('Torque (Nm)')
% hold off
% 
% figure(11)
% plot(gear_number)
% hold on
% plot(gear_number_f,'r')
% ylabel('Gear number')
% legend('Backwards','Forwards')
% hold off
%     
% figure(5)
% %plot(T_f_motor_to_gb,'g')
% %hold on
% plot(T_f_ICE_to_gb,'b')
% hold on
% plot(T_b_wheelaxle_to_pg,'r')
% %legend('Motor','ICE','Backwards - PG')
% ylabel('Torque, Nm')
% hold off



% figure(1)
% %plot(volume_of_fuel_used_by_ICE)
%  plot(I_ESS1)
%  ylabel('Current (A)')
% %[[0;I_ESS1] DoD_ESS1 [0; T_b_wheelaxle_to_pg]]
 
% figure(12)
% plot(w_b_wheelaxle_to_pg,'c')
% hold on
% plot(w_b_gb_to_motor)
% hold on
% plot(w_f_gb_to_pg_from_motor,'b--')
% hold on
% plot(w_b_gb_to_ICE,'r')
% hold on
% plot(w_f_gb_to_pg_from_ICE,'r--')
% hold on
% plot(w_f_gb_to_pg_from_ICE+w_f_gb_to_pg_from_motor,'k')
% hold on
% plot(w_f_pg_to_wheelaxle,'k--')
% hold off
% 
% figure(13)
% plot(T_b_wheelaxle_to_pg,'c')
% hold on
% plot(T_b_gb_to_motor)
% hold on
% plot(T_f_gb_to_pg_from_motor,'b--')
% hold on
% plot(T_b_gb_to_ICE,'r')
% hold on
% plot(T_f_gb_to_pg_from_ICE,'r--')
% hold on
% plot(T_f_gb_to_pg_from_ICE+T_f_gb_to_pg_from_motor,'k')
% hold on
% plot(T_f_pg_to_wheelaxle,'k--')
% hold off
% 
% figure(14)
% scatter(w_f_gb_to_pg_from_ICE*60/(2*pi()),T_f_gb_to_pg_from_ICE,'x')
% xlim([0 peak_ice_w*60/(2*pi())])
% ylim([0 peak_ice_T])
% xlabel('Speed (RPM)')
% ylabel('Torque (Nm)')


% 
%     figure(5)
%     plot(1-DoD_ESS1)
%     xlabel('Time (sec)');
%     ylabel('DoD');
%     title('DoD for ESS1');
    
%     figure(2)
%     plot(v_req)
%     hold on
%     plot(v_ach,'r')
%     hold off
%     
%     figure(6)
%     plot(T_f_gb_to_pg_from_ICE.*w_f_gb_to_pg_from_ICE)
%     hold on
%     plot(T_f_gb_to_pg_from_motor.*w_f_gb_to_pg_from_motor,'r')
%     hold off
    
    
%     
%       figure(1)
%     plot(t(1)+timestep/2:timestep:t(end)-timestep/2,volume_of_fuel_used_by_ICE);
%     xlabel('Time (sec)');
%     ylabel('ICE Fuel Used (L)');
%     title('ICE Fuel used by APU');

% figure(7)
% plot(P_b_wheelaxle_to_pg)
% hold on
% plot(T_f_ICE_to_gb.*w_f_ICE_to_gb,'r')
% % hold on
% % plot(w_f_gb_to_pg_from_ICE,'r')%w_f_ICE_to_gb.*T_f_ICE_to_gb)
%  hold off

% plot(P_supp_ESS1,'r')
% hold on
% plot(P_f_bus_to_motor,'g')
% legend('APU','ESS','Motor')
% 
% figure(1)
% % plot(T_b_gb_to_motor)
% % hold on
% plot(T_b_wheelaxle_to_pg)
% hold on

max_motor_kw = max(P_f_bus_to_motor)/1000;
max_ice_kw = max(T_f_gb_to_pg_from_ICE.*w_f_gb_to_pg_from_ICE)/1000;
fuel_ice = sum(volume_of_fuel_used_by_ICE)*ICE_fuel_heating_value*ICE_fuel_density/10^6;%MJ
fuel_motor = sum(P_f_bus_to_motor)*timestep/1000*timestep/3600*3.6;%MJ
vgb_mass = gearbox_mass;