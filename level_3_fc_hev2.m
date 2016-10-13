function [max_fc_kw,max_motor_kw,fuel_fc,fuel_motor,motor_eff_f,fc_eff,timestep,...
    v_ach,vgb_mass,batt_kwh]=level_3_fc_hev2(powertrain_type,v_req,~,timestep,...
    drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,final_drive_ratio,tire_radius,~,~,...
    front_or_rear_wheel_drive,dynamic_braking,wheelbase,L1,L2,h,~,distance_req_alt,...
    batt_cap,fc_kw,overall_mass_fac,batt_V,scaling_factor,motor_selection,...
    ESS1_selection,ESS2_selection,ele_map,regen_var,max_P,peak_ice_T)

wheelaxle_efficiency=1;
%Gearbox Parameters
k_seal=0.00103;
k_mesh=0.02;
k_bearing=0.005;

%% Motor Characterization
%motor_selection=7;% = UQM motor %input('Select the motor that you want to be used: ');
[total_motor_mass,number_of_motors]=motor_mass_calculator(motor_selection,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,scaling_factor);

[w_max,rotor_inertia,speed_range,torque_range,eff_matrix,T_max_speed_vector,...
    T_max_profile,T_max_motor]=motor_loader(motor_selection,scaling_factor);

if motor_selection == 8
    eff_matrix = ele_map/100;
else
end

    fgb_ICE_ratio=1;
    fgb_motor_ratio = 1;
    fgb_ratio = 1;
       
%% Obtain the specs for that particular ICE
apu_type = 1;
%fc_sim_type=1;%input('Enter the FC sim type: ');
%ICE_apu_step=0;
apu_selection=3;%input('Enter the selection for the APU: '); %Max power is  5000 W for this fuel cell
number_fc_modules = single(round(fc_kw/5000)+1);%single(round(max(T_max_speed_vector.*T_max_profile)/5000))+1;%input('Enter the number of fuel cell modules: ');

%APU characterization
[apu_mass,P_max_apu]=apu_mass_calculator(apu_selection,number_fc_modules);
apu_charging_fraction=.31;

apu_GR=1;
ICE_selection=0;
ICE_apu_step=0;
apu_minimum_power=0;
generator_selection=0;
ice_sp = 590;%W/kg
ICE_mass = max_P*(1/ice_sp);

    %Velocity Achieved Vector Generation
    v_ach=single(zeros(drive_cycle_length,1));
    v_ach(1)=v_req(1);

    %Distance Achieved Scalar Initialization
    distance_ach=0;

%% Make battery pack
[batt_kwh,NoCells_ESS1,NoCells_ESS2,NoCells_ESS1_par,ser_cells] ...
    = make_batt(ESS1_selection,ESS2_selection,batt_V,batt_cap);

[regen_status,EMS_selection,vehicle_mass_vector,DoD_initial_ESS1,DoD_initial_ESS2,CR_ESS1_initial,...
    CR_ESS2_initial,ESS1_charge_state_init,ESS2_charge_state_init,ESS1_charge_off_limit,...
    ESS1_charge_on_limit,ESS2_charging_fraction,ESS2_charge_off_limit,ESS2_charge_on_limit,...
    motorfw_selection_ESS1,motorfw_selection_ESS2,v_max,gearbox_mass] = ev_parameters_3(powertrain_type,...
    ESS1_selection,ESS2_selection,veh_mass,fgb_motor_ratio,fgb_ICE_ratio,T_max_motor,total_motor_mass,ICE_mass,...
    apu_mass,NoCells_ESS1,NoCells_ESS2,ICE_selection,regen_var);

new_mass = vehicle_mass_vector - veh_mass;
veh_mass = veh_mass + new_mass*(1+overall_mass_fac);
NoCells_ESS1 = ser_cells; %Ensures that bus V is around batt_V and not the product of all batt cells

%%
  %   component_efficiency_3;


    %Backwards vehicle vector generation
    F_b_vehicle_to_wheelaxle=zeros(drive_cycle_length-1,1);
    v_b_vehicle_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    percent_of_weight_on_front_axle = zeros(drive_cycle_length-1,1);
    percent_of_weight_on_rear_axle = zeros(drive_cycle_length-1,1);

    %Backwards wheelaxle vector generation
    T_b_wheelaxle_to_gb=zeros(drive_cycle_length-1,1);
    w_b_wheelaxle_to_gb=zeros(drive_cycle_length-1,1);
    P_b_wheelaxle_to_gb=zeros(drive_cycle_length-1,1);

    %Backwards gear box vector generation
    T_b_gb_to_motor=zeros(drive_cycle_length-1,1);
    w_b_gb_to_motor=zeros(drive_cycle_length-1,1);
    P_b_gb_to_motor=zeros(drive_cycle_length-1,1);
    fgb_b_eff=zeros(drive_cycle_length-1,1);

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
    ESS2_charge_state_vector=zeros(drive_cycle_length-1,1);
    H2_used_by_apu=zeros(drive_cycle_length-1,1);
    volume_of_ICE_fuel_used=zeros(drive_cycle_length-1,1);
    P_supp_by_apu = zeros(drive_cycle_length-1,1);
    fc_eff = zeros(drive_cycle_length-1,1);
    
    %Forwards Motor vector generation
    T_f_motor_to_gb=zeros(drive_cycle_length-1,1);
    w_f_motor_to_gb=zeros(drive_cycle_length-1,1);
    motor_eff_f=zeros(drive_cycle_length-1,1);

    %Forwards gear box vector generation
    T_f_gb_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    w_f_gb_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    P_f_gb_to_wheelaxle=zeros(drive_cycle_length-1,1);
    fgb_f_eff=zeros(drive_cycle_length-1,1);

    %Forwards wheel/axle vector generation
    F_f_wheelaxle_to_vehicle=zeros(drive_cycle_length-1,1);
    v_f_wheelaxle_to_vehicle=zeros(drive_cycle_length-1,1);
    P_f_mechbrake=zeros(drive_cycle_length-1,1);
    %ESS2_charge_state=zeros(drive_cycle_length-1,1);
    
    %Mechanical Flywheel integration
%     DoD_fw_mech=zeros(drive_cycle_length,1);
%         DoD_fw_mech(1)=DoD_fw_mech_initial;
%     P_b_mech_fw=zeros(drive_cycle_length-1,1);

for i=1:drive_cycle_length-1

%Vehicle backwards
[F_b_vehicle_to_wheelaxle(i),v_b_vehicle_to_wheelaxle(i),slope_for_this_step,...
    percent_of_weight_on_front_axle(i),percent_of_weight_on_rear_axle(i)]=...
    vehicle_backwards_3(v_ach(i),v_req(i+1),timestep,Cd,Af,rho_air,veh_mass,...
    Crr,distance_ach,distance_req_alt,slope,wheelbase,L1,L2,h,DoD_ESS1(i),DoD_ESS2(i));

%Wheel/axle backwards
[T_b_wheelaxle_to_gb(i),w_b_wheelaxle_to_gb(i),P_b_wheelaxle_to_gb(i)]=...
    wheelaxle_backwards_3(F_b_vehicle_to_wheelaxle(i),v_b_vehicle_to_wheelaxle(i),...
    v_ach(i),v_req(i+1),tire_radius,timestep,total_driven_wheelaxle_inertia,...
    motor_in_or_out_of_wheel,number_of_driven_wheels,wheelaxle_efficiency,regen_status,...
    percent_of_weight_on_front_axle(i),percent_of_weight_on_rear_axle(i),...
    front_or_rear_wheel_drive,dynamic_braking);    

% %in the case of a mechanically integrated flywheel
%         if ESS1_selection>300 || ESS2_selection>300
%             [P_b_mech_fw(i),DoD_fw_mech(i+1)]=fw_mech_system_model_3(T_b_wheelaxle_to_gb(i),w_b_wheelaxle_to_gb(i),DoD_fw_mech(i),i,timestep);
%             if w_b_wheelaxle_to_gb(i)==0
%                 T_b_wheelaxle_to_gb(i)=0;
%             else
%                 T_b_wheelaxle_to_gb(i)=(P_b_wheelaxle_to_gb(i)-P_b_mech_fw(i))/w_b_wheelaxle_to_gb(i);
%         
%             end
%         end
        
%Gb backwards
[T_b_gb_to_motor(i),w_b_gb_to_motor(i),P_b_gb_to_motor(i),fgb_b_eff(i)]=...
    fgb_backwards_3(T_b_wheelaxle_to_gb(i),w_b_wheelaxle_to_gb(i),fgb_ratio,...
    v_ach(i),v_req(i+1),tire_radius,timestep,motor_in_or_out_of_wheel,...
    T_max_motor,k_seal,k_bearing,k_mesh,front_or_rear_wheel_drive);

%Motor backwards
[P_b_motor_to_elecbus(i),w_b_motor_to_elecbus(i),T_b_motor_to_elecbus(i),...
    TperP,motor_eff_b(i)] = motor_backwards_3(T_b_gb_to_motor(i),w_b_gb_to_motor(i),...
    tire_radius*v_ach(i)*fgb_ratio,tire_radius*v_req(i)*fgb_ratio,w_max,...
    rotor_inertia,speed_range,torque_range,eff_matrix,timestep,T_max_speed_vector,...
    T_max_profile,number_of_motors);

%Series HEV electric bus
        if i==1 % account for zero cha  rge being removed prior to the first time step
            CR_prev_ESS1=CR_ESS1_initial;
            CR_prev_ESS2=CR_ESS2_initial;
            DoD_prev_ESS1=DoD_initial_ESS1;
            DoD_prev_ESS2=DoD_initial_ESS2;
            Pmax_prev_ESS2=inf;
            ESS1_charge_state=ESS1_charge_state_init;
            ESS2_charge_state=ESS2_charge_state_init;

        else
            CR_prev_ESS1=CR_ESS1(i);
            CR_prev_ESS2=CR_ESS2(i);
            DoD_prev_ESS1=DoD_ESS1(i);
            DoD_prev_ESS2=DoD_ESS2(i);
            Pmax_prev_ESS2=Pmax_ESS2(i-1);
            ESS1_charge_state=ESS1_charge_state_vector(i-1);
            ESS2_charge_state=ESS2_charge_state_vector(i-1);
    
        end
       
        
[DoD_ESS1(i+1),DoD_ESS2(i+1),P_supp_ESS1(i),P_supp_ESS2(i),CR_ESS1(i+1),...
    CR_ESS2(i+1),I_ESS1(i),I_ESS2(i),V_ESS1(i),V_ESS2(i),Pmax_ESS1(i),...
    Pmax_ESS2(i),P_f_bus_to_motor(i),ESS1_charge_state_vector(i),...
    ESS2_charge_state_vector(i),P_reqd_from_ESS2(i),~,~,~,~,~,~,~,~,...
    H2_used_by_apu(i),P_supp_by_apu(i),~,fc_eff(i),~,~,~,~,~,volume_of_ICE_fuel_used(i)]...
    =series_hev_bus_3(P_b_motor_to_elecbus(i),i,CR_prev_ESS1,CR_prev_ESS2,...
    DoD_prev_ESS1,DoD_prev_ESS2,DoD_initial_ESS1,DoD_initial_ESS2,NoCells_ESS1,...
    NoCells_ESS2,timestep,ESS1_selection,ESS2_selection,apu_selection,...
    ESS1_charge_off_limit,ESS1_charge_on_limit,ESS2_charge_off_limit,...
    ESS2_charge_on_limit,Pmax_prev_ESS2,ESS2_charging_fraction,ESS1_charge_state,...
    ESS2_charge_state,motorfw_selection_ESS1,motorfw_selection_ESS2,P_max_apu,...
    apu_charging_fraction,number_fc_modules,EMS_selection,v_b_vehicle_to_wheelaxle(i),...
    v_max,apu_GR,ICE_selection,generator_selection,ICE_apu_step,apu_minimum_power,...
    apu_type,NoCells_ESS1_par);

%Motor forwards
[T_f_motor_to_gb(i),w_f_motor_to_gb(i),motor_eff_f(i)]=motor_forwards_3(P_f_bus_to_motor(i),...
    w_b_motor_to_elecbus(i),speed_range,torque_range,eff_matrix,TperP,T_b_gb_to_motor(i),...
    T_max_speed_vector,T_max_profile,number_of_motors);
        
%GB forwards
[T_f_gb_to_wheelaxle(i),w_f_gb_to_wheelaxle(i),P_f_gb_to_wheelaxle(i),fgb_f_eff(i)]=fgb_forwards_3...
    (T_f_motor_to_gb(i),w_f_motor_to_gb(i),fgb_ratio,v_ach(i),v_req(i+1),tire_radius,timestep,...
    motor_in_or_out_of_wheel,T_max_motor,k_seal,k_bearing,k_mesh);

%Wheel/axle forwards
[F_f_wheelaxle_to_vehicle(i),v_f_wheelaxle_to_vehicle(i),P_f_mechbrake(i)]=...
    wheelaxle_forwards_3(T_f_gb_to_wheelaxle(i),w_f_gb_to_wheelaxle(i),...
    tire_radius,wheelaxle_efficiency,v_req(i+1),v_ach(i),total_driven_wheelaxle_inertia,...
    timestep,F_b_vehicle_to_wheelaxle(i),number_of_motors);

%Vehicle forwards
[v_ach(i+1)]=vehicle_fowards_3(F_f_wheelaxle_to_vehicle(i),v_f_wheelaxle_to_vehicle(i),...
    rho_air,Cd,Af,v_ach(i),veh_mass,timestep,Crr,slope_for_this_step);

%Compute the distance achieved
%distance_ach=single(trapz(t,v_ach)/1000);
end

% figure(6)
%     plot(t,v_req*2.23693629,t,v_ach*2.23693629);
%     xlabel('Time (sec)');
%     ylabel('Velocity (mph)');
%     hold on
%     
% 
%max(I_ESS1)
% 
% figure(1)
% plot(I_ESS1)
% hold on


% figure(6)
% plot(H2_used_by_apu)
% hold on
% % % % % 
% figure(7)
% plot(P_supp_by_apu)
% hold on
% plot(P_supp_ESS1,'r')
% hold on
% plot(P_f_bus_to_motor,'g')
% legend('APU','ESS','Motor')

% 
% figure(1)
% plot(V_ESS1)
% ylabel('V')
% hold on
% 
% figure(2)
% plot(DoD_ESS1)
% ylabel('DOD')
% hold on
% 
% % 
% [min(motor_eff_b) median(motor_eff_b) max(motor_eff_b);
%[min(motor_eff_f) median(motor_eff_f) max(motor_eff_f);]
% 
% [min(T_f_motor_to_gb) median(T_f_motor_to_gb) max(T_f_motor_to_gb);
% min(w_f_motor_to_gb) median(w_f_motor_to_gb) max(w_f_motor_to_gb);]

% figure(1)
% plot(w_search)
% hold on
% plot(w_search1,'r')
% ylabel('Speed index')

% figure(2)
% plot(DoD_ESS1)
% hold on
% % plot(t_search1,'r')
%  ylabel('DOD, ESS1')
% 
% % figure(3)
% % plot(T_b_motor_to_elecbus,'r')
% % hold on
% % plot(T_f_motor_to_gb)
% % ylabel('Nm')
% 
% figure(4)
% plot(P_b_motor_to_elecbus/1000)
% ylabel('Power to elecbus, kW')
% hold on
% 
% figure(5)
% plot(c)
% hold on
% ylabel('Current vector index')
%[number_fc_modules*360/1000 max(P_f_bus_to_motor)/1000 (max(P_f_bus_to_motor)/1000)/number_fc_modules*360/1000 T_max_motor*max(speed_range)/1000]
%[min(c) median(c) max(c)];

max_fc_kw = max(P_supp_by_apu)/1000;
max_motor_kw = max(P_f_bus_to_motor)/1000;
fuel_motor = sum(P_f_bus_to_motor*timestep/1000*timestep/3600)*3.6;%MJ
fuel_fc = sum(H2_used_by_apu)*123;%convert kg H2 to MJ
%fuel_fc = sum(P_supp_by_apu*timestep/1000*timestep/3600)*3.6;%MJ
vgb_mass = gearbox_mass;

