function [DoD_ESS1,CR_ESS1,Pmax_ESS1,I_ESS1,V_ESS1,P_supp_ESS1,T_b_motorfw_to_gbfw,w_b_motorfw_to_gbfw,...
    T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw,T_b_motorfw_in,...
    w_b_motorfw_in,motorfw_eff_b,motorfw_eff_f]=ESS1_3(ESS1_selection,P_reqd_ESS1,i,CR_prev_ESS1,...
    DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,motorfw_selection_ESS1,NoCells_ESS1_par)

%Title: ESS1_3
%
%Author: Reed Doucette
%
%Created: May 10, 2009
%
%Purpose: To pass the information from the pass to the ESS1 and to load the
%correct characteristics parameters and model for that ESS
%
%List of Inputs
%
%
%List of Outputs
%
%
%Record of Revisions
%   October 6, 2009: Change made by Reed Doucette.  Flywheel was added to
%   the ESS.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ESS1_selection==0
    DoD_ESS1=0;
    P_supp_ESS1=0;
    CR_ESS1=0;
    I_ESS1=0;
    V_ESS1=0;
    Pmax_ESS1=0;
    w_fw_at_end_of_step_ESS1_new=0;
    T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==1      %AltairNano, 50 Ah
    batt_specs_3_altairnano_50_Ah;
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==2  %PowerGenix PGX 2000 sub C
    batt_specs_3_powergenix_2000_subC;
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==3  %A123 ANR26650
    batt_specs_3_a123_ANR26650;
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==4 %PowerGenix PGX 2000 aa
    batt_specs_3_powergenix_1500_aa;
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==5
    batt_specs_3_altairnano_11_Ah; %AltairNano, 11 Ah
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==6
    batt_specs_3_exide_5epzb325; %Exide 5EPzB325
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==7
    batt_specs_3_saft_NHE_NiMH; %SAFT NHE NiMH
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
        
elseif ESS1_selection==8
    batt_specs_3_exide_9epzb585; %Exide 9EPzB585
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==9
    batt_specs_3_LiFeBATT_40166; %LiFEBATT X-2E 15 Ah 40166 
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,Imax,Eo,K,Q,A,B,Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;

elseif ESS1_selection==10
    batt_specs_3_greensaver_sp_36_12;
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3(P_reqd_ESS1,...
        i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Rint,...
        Imax,Eo,K,Q,A,B,Capacity);
    
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;

    %%    
elseif ESS1_selection==11
    
  batt_specs_3_bostonpower_swing4400;
  total_cells = NoCells_ESS1*NoCells_ESS1_par;
  Capacity = total_cells*Capacity;
  Imax = Imax*NoCells_ESS1_par;%where the max discharge current = 12

    
    %Battery Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=battery_model_3...
        (P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,...
        dT,Rint,Imax,Eo,K,Q,A,B,Capacity,total_cells,NoCells_ESS1_par);
    
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;...
        T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;...
        w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;...
        motorfw_eff_f=0;
%%
elseif ESS1_selection==101
    ucap_specs_3_maxwell_350F; %Maxwell BCAP 0350
    %Ultracap Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=ucap_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Imax,Rs,Rp,Ucap_poly_fit,Max_Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
        
elseif ESS1_selection==102
    ucap_specs_3_maxwell_650F; %Maxwell BCAP 0650
    %Ultracap Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=ucap_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Imax,Rs,Rp,Ucap_poly_fit,Max_Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
        
elseif ESS1_selection==103
    ucap_specs_3_maxwell_2000F; %Maxwell BCAP 2000
    %Ultracap Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=ucap_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Imax,Rs,Rp,Ucap_poly_fit,Max_Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
elseif ESS1_selection==104
    ucap_specs_3_maxwell_3000F; %Maxwell BCAP 3000
    %Ultrcap Model
    [DoD_ESS1,P_supp_ESS1,CR_ESS1,I_ESS1,V_ESS1,Pmax_ESS1]=ucap_model_3(P_reqd_ESS1,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,dT,Imax,Rs,Rp,Ucap_poly_fit,Max_Capacity);
    w_fw_at_end_of_step_ESS1_new=0;T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
    
    
elseif ESS1_selection==201
    fw_specs_3_flybrid;         %Flybrid flywheel (electrically integrated)
    %Determine the fw motor specs
    [w_max_motorfw,rotor_inertia_motorfw,speed_range_motorfw,torque_range_motorfw,eff_matrix_motorfw,T_max_speed_vector_motorfw,T_max_profile_motorfw,T_max_motorfw]=motor_loader(motorfw_selection_ESS1);
    %Determine the gbfw_ratio
    [gbfw_ratio]=gbfw_ratio_calculator(w_max_motorfw,E_max_fw,J_fw);
    %Load gbfw parameters
    gbfw_parameters
    %Flywheel System Model
    [P_supp_ESS1,DoD_ESS1,T_b_motorfw_to_gbfw,w_b_motorfw_to_gbfw,T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw,T_b_motorfw_in,w_b_motorfw_in,motorfw_eff_b,motorfw_eff_f]=fw_system_model_3(P_reqd_ESS1,i,E_max_fw,J_fw,6,dT,T_max_motorfw,k_seal_gbfw,k_bearing_gbfw,k_mesh_gbfw,fw_speed_loss_polyfit,DoD_prev_ESS1,T_max_speed_vector_motorfw,T_max_profile_motorfw,speed_range_motorfw,torque_range_motorfw,eff_matrix_motorfw,w_max_motorfw);
    CR_ESS1=0;I_ESS1=0;V_ESS1=0;Pmax_ESS1=0;

elseif ESS1_selection==301      %Flybrid flywheel (mechanically integrated)
    DoD_ESS1=0;
    P_supp_ESS1=0;
    CR_ESS1=0;
    I_ESS1=0;
    V_ESS1=0;
    Pmax_ESS1=0;
    w_fw_at_end_of_step_ESS1_new=0;
    T_b_motorfw_to_gbfw=0;w_b_motorfw_to_gbfw=0;T_b_gbfw_to_fw=0;w_b_gbfw_to_fw=0;P_f_fw_to_gbfw=0;T_f_gbfw_to_motorfw=0;w_f_gbfw_to_motorfw=0;T_b_motorfw_in=0;w_b_motorfw_in=0;motorfw_eff_b=0;motorfw_eff_f=0;
end
