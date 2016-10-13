function [P_supp,I_supp,H2_used,fc_eff,speed_out_of_generator,torque_out_of_generator,generator_eff_used,...
    gb_eff_used,ICE_eff_used,volume_of_ICE_fuel_used,c]=series_hev_apu_3(apu_selection,P_reqd,number_fc_modules,...
    P_max_apu,timestep,apu_GR,ICE_selection,generator_selection,ICE_apu_step)

%Title: series_hev_apu_3
%
%Author: Reed Doucette
%
%Created: November 9, 2009
%
%Purpose: To load the correct apu parameters and them and the power
%requests from the bus to the correct apu models.
%
%List of Inputs:
%
%List of Outputs:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if apu_selection == 1
    fc_specs_3_schunk_fc_42;
 
%     %% Interpolate power for lowest current
% I_vector = single([0
%     0.0354417
% 1.20502
% 2.37459
% 3.43784
% 5.10360
% 6.73391
% 8.29335
% 9.92366
% 11.5540
% 13.5033
% 15.6298
% 17.5791
% 19.7410
% 21.3004
% 22.6118
% % 23.9940%
% % 25.4471
% % 26.7230
% % 27.7154
% % 28.5660
% % 29.4520
% % 30.1609
% % 30.8342
% % 31.3304
% % 31.8621
% % 32.2165
% % 32.4291
% ]);
% 
% P_vector = single([0
%     1.54976
% 41.8434
% 79.8124
% 115.457
% 165.049
% 209.992
% 248.736
% 289.804
% 326.998
% 367.292
% 404.486
% 433.931
% 457.953
% 469.576
% 471.126
% % 465.701%
% % 448.654
% % 424.633
% % 388.989
% % 352.569
% % 306.077
% % 258.034
% % 206.892
% % 149.551
% % 92.2104
% % 40.2936
% % 24.0212
% ]);
% 
% P_fc_module_max = max(P_vector)-.01;
% 
% cells_per_module = single(42);
% 
% fc_module_mass = single(2.1); %kg
    
    [P_supp,I_supp,H2_used,c]=fc_model_3(P_reqd,P_vector,I_vector,P_fc_module_max,...
        number_fc_modules,cells_per_module);
    
    fc_eff=0;
    speed_out_of_generator=0;
    torque_out_of_generator=0;
    generator_eff_used=0;
    gb_eff_used=0;
    ICE_eff_used=0;
    volume_of_ICE_fuel_used=0;
    
elseif apu_selection==2
    fc_specs_3_horizon_h_4000;
    [P_supp,I_supp,H2_used,c]=fc_model_3(P_reqd,P_vector,I_vector,P_fc_module_max,number_fc_modules,cells_per_module);
    fc_eff=0;
    speed_out_of_generator=0;
    torque_out_of_generator=0;
    generator_eff_used=0;
    gb_eff_used=0;
    ICE_eff_used=0;
    volume_of_ICE_fuel_used=0;  
    %%
elseif apu_selection==3
    fc_specs_3_horizon_h_5000;
    [P_supp,I_supp,H2_used,c]=fc_model_3(P_reqd,P_vector,I_vector,P_fc_module_max,...
        number_fc_modules,cells_per_module);
    fc_eff=0;
    speed_out_of_generator=0;
    torque_out_of_generator=0;
    generator_eff_used=0;
    gb_eff_used=0;
    ICE_eff_used=0;
    volume_of_ICE_fuel_used=0;  
    
elseif apu_selection==101
    fc_specs_scaled_data;
    [P_supp,fc_eff,H2_used,c]=fc_scaled_model_3(P_reqd,p_pmax_scaled_vector,eff_scaled_vector,P_max_apu,H2_energy_density,timestep);
    I_supp=0; %not enough Imax data to determine at the moment, but its not important in terms of finding H2 consumption so its ignored at the moment
    speed_out_of_generator=0;
    torque_out_of_generator=0;
    generator_eff_used=0;
    gb_eff_used=0;
    ICE_eff_used=0;
    volume_of_ICE_fuel_used=0;
elseif apu_selection==201
    if generator_selection==1 %UQM Powerphase 100 with scaling capability
        motor_specs_3_uqm_power_phase_100_scaled_for_scooter;
    end
    if ICE_selection==1         %E30 1.9L TDI (VW) engine
        ICE_specs_3_E30;
    elseif ICE_selection==2
        ICE_specs_3_1L_41kW_GEO;
    end
    %Invoke the ICE APU function
    previous_ICE_speed=0;
    previous_generator_speed=0;
    
    [P_supp,speed_out_of_generator,torque_out_of_generator,generator_eff_used,gb_eff_used,ICE_eff_used,...
        volume_of_ICE_fuel_used]=sHEV_ICE_based_apu_model_3(P_reqd,ICE_apu_step,ICE_speed_vector,ICE_torque_vector,...
        ICE_eff_map,ICE_max_torque_w_profile,ICE_max_torque_T_profile,speed_range,torque_range,eff_matrix,...
        T_max_speed_vector,T_max_profile,ICE_slew_rate,previous_ICE_speed,previous_generator_speed,apu_GR,...
        T_max_motor,ICE_max_speed,ICE_min_speed,ICE_fuel_heating_value,timestep,ICE_fuel_density,P_max_apu);
    
    I_supp=0;
    H2_used=0;
    fc_eff=0;
end
