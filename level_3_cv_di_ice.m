function [max_ice_kw,total_fuel_mj,di_ice_2_eff,timestep,v_ach,vgb_mass,final_veh_mass]=level_3_cv_di_ice(v_req,~,timestep,...
   drive_cycle_length,slope,Cd,Af,rho_air,veh_mass,Crr,total_driven_wheelaxle_inertia,~,number_of_driven_wheels,...
   tire_radius,~,~,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,simulate,...
   peak_ice_T,peak_ice_w,min_w,min_n_w,max_n_w,max_P,number_of_motors,front_or_rear_wheel_drive,dynamic_braking,wheelbase,L1,L2,...
   ~,distance_req_alt,~,h,di_map,overall_mass_fac)

%% Add engine and gearbox mass
ice_sp = 590;%W/kg
gb_mass = 0.49 * peak_ice_T^0.58 * top_gear_number^0.29;  %Taken from P 52, Automotive transmissions: 
veh_mass = veh_mass + (gb_mass + max_P*(1/ice_sp))*(1+overall_mass_fac);
final_veh_mass = veh_mass;

%% Find most efficient engine point
max_di_ice_2_eff = max(max(di_map));
min_di_ice_2_eff = single(min(min(di_map))/100);

[r,c,~] = find(di_map == max_di_ice_2_eff);
w_range = (c/100*peak_ice_w)*.7;
t_range = r/100*peak_ice_T;

%%
component_efficiency_3;
if simulate ==1;
gears = find_gear_ratio(simulate,final_drive_ratio,top_gear_ratio,...
    top_gear_number,peak_ice_w,w_range);
else
    gears = gear_ratio_vector;
end
    %% Velocity Achieved Vector Generation
    v_ach=single(zeros(drive_cycle_length,1));
    v_ach(1)=v_req(1);

    %Distance Achieved Scalar Initialization
    distance_ach=0;

    %Backwards vehicle vector generation
    F_b_vehicle_to_wheelaxle=zeros(drive_cycle_length-1,1);
    v_b_vehicle_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    percent_of_weight_on_rear_axle = v_b_vehicle_to_wheelaxle;
    percent_of_weight_on_front_axle = v_b_vehicle_to_wheelaxle;

    %Backwards wheelaxle vector generation
    T_b_wheelaxle_to_gb=zeros(drive_cycle_length-1,1);
    w_b_wheelaxle_to_gb=zeros(drive_cycle_length-1,1);
    P_b_wheelaxle_to_gb=zeros(drive_cycle_length-1,1);

    %Backwards gear box vector generation
    T_b_gb=zeros(drive_cycle_length-1,1);
    w_b_gb=zeros(drive_cycle_length-1,1);
    P_b_gb=zeros(drive_cycle_length-1,1);
    vgb_b_eff=zeros(drive_cycle_length-1,1);
    vgb_b_mass_int = vgb_b_eff;
    vgb_b_cost_int = vgb_b_eff;

    %Backwards ICE vector generation
    ice_b_eff=zeros(drive_cycle_length-1,1);
    %fuel_energy_demand = zeros(drive_cycle_length,1);
    %P_reqd_by_ice = ice_b_eff;
    %T_reqd_by_ice = ice_b_eff;
    %w_reqd_by_ice = ice_b_eff;
    P_f_reqd_by_ice = ice_b_eff;
    di_used_by_ice = ice_b_eff;
  %  T_f_reqd_by_ice = ice_b_eff;
   % w_f_reqd_by_ice = ice_b_eff;
    gear_number = ice_b_eff;
    gear_number_f = gear_number;

    
    %Forwards Motor vector generation
    T_f_reqd_by_gb=zeros(drive_cycle_length-1,1);
    w_f_reqd_by_gb=zeros(drive_cycle_length-1,1);
    %P_f_reqd_by_gb = w_f_reqd_by_gb;
    ice_f_eff=zeros(drive_cycle_length-1,1);
    di_ice_2_eff=ice_f_eff;

    %Forwards gear box vector generation
    T_f_gb_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    w_f_gb_to_wheelaxle=single(zeros(drive_cycle_length-1,1));
    
    %T_f_reqd_by_wheelaxle=zeros(drive_cycle_length-1,1);
    %w_f_reqd_by_wheelaxle=zeros(drive_cycle_length-1,1);
    P_f_reqd_by_wheelaxle=zeros(drive_cycle_length-1,1);
    vgb_f_eff=zeros(drive_cycle_length-1,1);
    vgb_f_mass_int = vgb_b_eff;
    vgb_f_cost_int = vgb_b_eff;
    %mj_in_tank = vgb_b_eff;

    %Forwards wheel/axle vector generation
    F_f_wheelaxle_to_vehicle=zeros(drive_cycle_length-1,1);
    v_f_wheelaxle_to_vehicle=zeros(drive_cycle_length-1,1);
    P_f_mechbrake=zeros(drive_cycle_length-1,1);
    
%     v1_ach_from_T_available=zeros(drive_cycle_length-1,1);
%     v1_ach_from_speed_available=zeros(drive_cycle_length-1,1);

    in_out_of_wheel = 0;
    regen_status = 0;
    ice_status = 1;
    
for i=1:drive_cycle_length-1

%Vehicle backwards
[F_b_vehicle_to_wheelaxle(i),v_b_vehicle_to_wheelaxle(i),slope_for_this_step,...
    percent_of_weight_on_front_axle(i),percent_of_weight_on_rear_axle(i)] = ...
    vehicle_backwards_3(v_ach(i),v_req(i+1),timestep,Cd,Af,rho_air,veh_mass,...
    Crr,distance_ach,distance_req_alt,slope,wheelbase,L1,L2,h,1,1);

%Force in N, velocity in m/s => power in Watts, torque in Nm, w in rad/s.

%Wheel/axle backwards
[T_b_wheelaxle_to_gb(i),w_b_wheelaxle_to_gb(i),P_b_wheelaxle_to_gb(i)] = ...
    wheelaxle_backwards_3(F_b_vehicle_to_wheelaxle(i),v_b_vehicle_to_wheelaxle(i),...
    v_ach(i),v_req(i+1),tire_radius,timestep,total_driven_wheelaxle_inertia,...
    in_out_of_wheel,number_of_driven_wheels,wheelaxle_efficiency,regen_status,...
    percent_of_weight_on_front_axle(i),percent_of_weight_on_rear_axle(i),...
    front_or_rear_wheel_drive,dynamic_braking);               

%Gb backwards
[T_b_gb(i),w_b_gb(i),P_b_gb(i),vgb_b_eff(i),vgb_b_mass_int(i),vgb_b_cost_int(i),...
    gear_number(i)]=gb_multispeed_backwards(max_P,P_b_wheelaxle_to_gb(i),...
    T_b_wheelaxle_to_gb(i),w_b_wheelaxle_to_gb(i),peak_ice_T,k_seal,k_bearing,...
    k_mesh,v_ach(i),v_req(i+1),tire_radius,timestep,min_w,peak_ice_w,min_n_w,...
    max_n_w,top_gear_number,top_gear_ratio,gear_ratio_vector,final_drive_ratio,...
    gears,w_range); 

% % Engine backwards
% [P_reqd_by_ice(i),ice_b_eff(i)]=si_ice_backwards(P_b_gb(i),T_b_gb(i),w_b_gb(i),max_P,...
%     peak_ice_T,peak_ice_w,min_w,ice_status);
% 
% %Fuel tank
%         if i==1 % account for zero fuel being removed prior to the first time step
%             fuel_energy_demand(i) = 0;
%               mj_in_tank(i) = fuel_mj;
%         else
%               fuel_energy_demand(i) = (T_reqd_by_ice(i)*w_reqd_by_ice(i)/1000*timestep/3600)/3.6;
%               mj_in_tank(i) = fuel_mj - fuel_energy_demand(i);
%         end
% 
% %Engine forwards
% [P_f_reqd_by_gb(i),T_f_reqd_by_gb(i),w_f_reqd_by_gb(i),ice_f_eff(i)]=si_ice_forwards(P_reqd_by_ice(i),T_b_gb(i),w_b_gb(i),...
%     max_P,peak_ice_T,peak_ice_w,min_w);

%Engine
[P_f_reqd_by_ice(i),T_f_reqd_by_gb(i),w_f_reqd_by_gb(i),di_ice_2_eff(i),di_used_by_ice(i)]=...
    level_3_di_ice(P_b_gb(i),T_b_gb(i),w_b_gb(i),max_P,peak_ice_T,peak_ice_w,...
    min_w,ice_status,di_map,min_di_ice_2_eff);

%GB forwards
[P_f_reqd_by_wheelaxle(i),T_f_gb_to_wheelaxle(i),w_f_gb_to_wheelaxle(i),...
    vgb_f_eff(i),vgb_f_mass_int(i),vgb_f_cost_int(i),gear_number_f(i)]=...
    gb_multispeed_forwards(max_P,P_f_reqd_by_ice(i),T_f_reqd_by_gb(i),...
    w_f_reqd_by_gb(i),peak_ice_T,k_seal,k_bearing,k_mesh,v_ach(i),v_req(i+1),...
    tire_radius,timestep,min_w,peak_ice_w,min_n_w,max_n_w,top_gear_number,...
    top_gear_ratio,gear_ratio_vector,final_drive_ratio,gears,w_range,...
    w_b_wheelaxle_to_gb(i));

%Wheel/axle forwards
[F_f_wheelaxle_to_vehicle(i),v_f_wheelaxle_to_vehicle(i),P_f_mechbrake(i)] = ...
    wheelaxle_forwards_3(T_f_gb_to_wheelaxle(i),w_f_gb_to_wheelaxle(i),...
    tire_radius,wheelaxle_efficiency,v_req(i+1),v_ach(i),...
    total_driven_wheelaxle_inertia,timestep,F_b_vehicle_to_wheelaxle(i),number_of_motors);

[v_ach(i+1)]=vehicle_fowards_3(F_f_wheelaxle_to_vehicle(i),v_f_wheelaxle_to_vehicle(i),...
    rho_air,Cd,Af,v_ach(i),veh_mass,timestep,Crr,slope_for_this_step);
    
%Compute the distance achieved
%distance_ach=single(trapz(t,v_ach)/1000);

end

%% Outputs

% figure(1)
% % plot(v_ach*3600/1000,'r')
% % hold on
% plot(gear_number,'g')
% hold on
% plot(gear_number_f,'r')
% legend('Backwards','Forwards')
% hold off
% 
% figure(3)
% plot(T_b_wheelaxle_to_gb)
% hold on
% plot(T_b_gb,'g')
% hold on
% plot(T_f_reqd_by_gb,'k')
% hold on
%  plot(T_f_gb_to_wheelaxle,'r')
% ylabel('Torque (Nm)')
% title('Wheelaxle torque')
%  legend('Backwards from wheelaxle to gearbox','Backwards from gearbox',...
%      'Forwards from ICE to gearbox','Forwards from gearbox to wheelaxle')
% hold off
% 
% figure(5)
% plot(w_b_wheelaxle_to_gb)
% hold on
% plot(w_b_gb,'g')
% hold on
% plot(w_f_reqd_by_gb,'k')
% hold on
% plot(w_f_gb_to_wheelaxle,'r')
% ylabel('Speed (rad/s)')
% legend('Backwards from wheelaxle to gearbox','Backwards from gearbox to ICE',...
%     'Forwards from ICE to gearbox','Forwards from gearbox to wheelaxle')
% hold off
% % % figure(2)
% % % plot((w_f_reqd_by_gb*180/pi()),'r')
% % % hold on
% % % plot((w_b_gb*180/pi()),'g')
% % % hold off
% % % 
% figure(4)
% plot(v_req*3600/1000,'g')
% hold on
% plot(v_ach*3600/1000,'r')
% ylabel('Velocity (km/h)')
% % hold on
% % plot(P_f_reqd_by_ice/1000,'b')
% % plot(di_ice_2_eff,'b');
% hold off
% % 
% figure(6)
% plot(P_b_wheelaxle_to_gb)
% hold on
% plot(P_b_gb,'g')
% hold on
% plot(P_f_reqd_by_ice,'r')
% hold on
% plot(P_f_reqd_by_wheelaxle,'k')
% ylabel('Power (W)')
% legend('Back from wheelaxle to gearbox','Back from gearbox to ICE',...
%     'Forward from ICE to gearbox','Forward from gearbox to wheelaxle')
% hold off
% 
% figure(10)
% scatter(w_f_reqd_by_gb*60/(2*pi()),T_f_reqd_by_gb,'x')
% hold on
% plot(w_range*60/(2*pi()),t_range,'rx')
% xlim([0 peak_ice_w*60/(2*pi())])
% ylim([0 peak_ice_T])
% xlabel('Speed (RPM)')
% ylabel('Torque (Nm)')
% hold off

max_ice_kw = max(w_f_reqd_by_gb.*T_f_reqd_by_gb)/1000;
total_fuel_mj = sum(di_used_by_ice);%sum(P_f_reqd_by_ice*timestep)/3600/1000*3.6;
vgb_mass = max(vgb_f_mass_int);

%vgb_cost = max(vgb_f_cost_int)*(0.035 * (3.85* 200) ^0.45 * 5^0.225);%euros
%range = distance_ach;

% 
%     figure(2)
%     plot(t,v_req*2.23693629,t,v_ach*2.23693629);
%     xlabel('Time (sec)');
%     ylabel('Velocity (mph)');