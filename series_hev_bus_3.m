function [DoD_ESS1,DoD_ESS2,P_supp_by_ESS1,P_supp_by_ESS2,CR_ESS1,CR_ESS2,I_ESS1,I_ESS2,V_ESS1,V_ESS2,...
    Pmax_ESS1,Pmax_ESS2,P_f_bus_out,ESS1_charge_state,ESS2_charge_state,P_reqd_from_ESS2,T_b_motorfw_to_gbfw,...
    w_b_motorfw_to_gbfw,T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw,...
    I_supp_by_apu,H2_used_by_apu,P_supp_by_apu,P_reqd_apu,fc_eff,speed_out_of_generator,torque_out_of_generator,...
    generator_eff_used,gb_eff_used,ICE_eff_used,volume_of_ICE_fuel_used]=...
    series_hev_bus_3(P_b_bus_in,i,...
    CR_prev_ESS1,CR_prev_ESS2,DoD_prev_ESS1,DoD_prev_ESS2,DoD_initial_ESS1,DoD_initial_ESS2,NoCells_ESS1,...
    NoCells_ESS2,timestep,ESS1_selection,ESS2_selection,apu_selection,ESS1_charge_off_limit,ESS1_charge_on_limit,...
    ESS2_charge_off_limit,ESS2_charge_on_limit,Pmax_prev_ESS2,ESS2_charging_fraction,ESS1_charge_state,...
    ESS2_charge_state,motorfw_selection_ESS1,motorfw_selection_ESS2,P_max_apu,apu_charging_fraction,...
    number_fc_modules,EMS_selection,v_req,v_max,apu_GR,ICE_selection,generator_selection,ICE_apu_step,...
    apu_minimum_power,apu_type,NoCells_ESS1_par)

%Title: series_hev_bus_3
%
%Author: Reed Doucette
%
%Created: November 6, 2009
%
%Purpose: To take the power request from the motor and output the power
%that can be supplied from the ESS's and APU.  The bus controls the state of
%charge of the ESS's via a thermostat control strategy where it charges
%ESS1 from ESS2 and the APU and ESS2 from the APU.  The ESS's are recharged
%when their SOC drops below the 'charge on limit' and their charging is 
%ended when their SOC rises above the 'charge off limit'.  It is assumed that 
%ESS1 will be the power source with a greater specific power (e.g. ultracaps)

%List of Inputs:


%List of Outputs:


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if EMS_selection==1;
    %Calculate the power supplied by ESS1
    [DoD_ESS1,CR_ESS1,Pmax_ESS1,I_ESS1,V_ESS1,P_supp_by_ESS1,T_b_motorfw_to_gbfw,...
        w_b_motorfw_to_gbfw,T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,...
        T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw]=ESS1_3(ESS1_selection,P_b_bus_in,...
        i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,...
        motorfw_selection_ESS1,NoCells_ESS1_par);

    %Determine whether ESS1 needs charging
    if DoD_ESS1>=ESS1_charge_on_limit
        ESS1_charge_state=1;
    elseif DoD_ESS1<=ESS1_charge_off_limit
        ESS1_charge_state=0;
    end

    %Determine the power output from ESS2
    if P_b_bus_in>=0
        if ESS1_charge_state==0 %the condition when ESS2 does not need to produce extra power to charge ESS1
            P_reqd_from_ESS2=P_b_bus_in-P_supp_by_ESS1;
            [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            P_f_bus_out=P_supp_by_ESS1+P_supp_by_ESS2;
        elseif ESS1_charge_state==1 %the condition when ESS2 does need to produce extra power to charge ESS1
            P_reqd_from_ESS2=(P_b_bus_in-P_supp_by_ESS1)+(Pmax_prev_ESS2*ESS2_charging_fraction); %the power requested from ESS2 is the remainder from the difference between that required by the motor and that supplied by ESS1 as well as the extra power at a fraction of ESS2's max power from the previous step that goes towards charging ESS2
            [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2); %power supplied by ESS2
            P_on_bus=P_supp_by_ESS1+P_supp_by_ESS2; %total power on bus
            P_excess_on_bus=P_on_bus-P_b_bus_in;    %excess power on bus
            
            if P_excess_on_bus>0                    %if the bus has excess power then it goes towards charging ESS1
%                 
%                 [DoD_ESS1,CR_ESS1]=ESS1_3(ESS1_selection,-P_excess_on_bus,i,...
%                     CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,...
%                     motorfw_selection_ESS1,NoCells_ESS1_par);
                
            [DoD_ESS1,CR_ESS1,~,~,~,~,~,~,~,~,~,~,~,~,~,~,~]=ESS1_3(ESS1_selection,...
                -P_excess_on_bus,i,CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,...
                timestep,motorfw_selection_ESS1,NoCells_ESS1_par);

                P_f_bus_out=P_on_bus-P_excess_on_bus;
            else                                    %if the bus has no excess power then its power is just outputted to the motor
                P_f_bus_out=P_on_bus;
            end
        end
    elseif P_b_bus_in<0 %in the case of braking, ESS1 will not receive any charge from ESS2 because it is receiving the power during the regenerative braking process
        P_reqd_from_ESS2=P_b_bus_in-P_supp_by_ESS1;
        [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
        P_f_bus_out=P_b_bus_in;                 %for a negative power case, the power into the bus always equals the power out, its just a matter of how much the ESS gets charged      
    end
    
    %Determine whether ESS1 needs charging again from the APU
    if DoD_ESS1>=ESS1_charge_on_limit
        ESS1_charge_state=1;
    elseif DoD_ESS1<=ESS1_charge_off_limit
        ESS1_charge_state=0;
    end
    
    %Determine whether ESS2 needs charging from the APU
    if DoD_ESS2>=ESS2_charge_on_limit
        ESS2_charge_state=1;
    elseif DoD_ESS2<=ESS2_charge_off_limit
        ESS2_charge_state=0;
    end

    %Determine the power output from the APU
    if P_b_bus_in>=0
        P_reqd_apu_from_bus=P_b_bus_in-(P_supp_by_ESS1+P_supp_by_ESS2);
        P_reqd_apu_from_ESS1=ESS1_charge_state*P_max_apu*apu_charging_fraction;
        P_reqd_apu_from_ESS2=ESS2_charge_state*P_max_apu*apu_charging_fraction;
        P_reqd_apu=P_reqd_apu_from_bus+P_reqd_apu_from_ESS1+P_reqd_apu_from_ESS2;
        
        if apu_type==1 %case of a fuel cell
        
            [P_supp_by_apu,I_supp_by_apu,H2_used_by_apu,fc_eff,...
                speed_out_of_generator,torque_out_of_generator,generator_eff_used,...
                gb_eff_used,ICE_eff_used,volume_of_ICE_fuel_used,c]=series_hev_apu_3...
                (apu_selection,P_reqd_apu,number_fc_modules,P_max_apu,timestep,...
                apu_GR,ICE_selection,generator_selection,ICE_apu_step);
            
        elseif apu_type==2 %case of an ICE based APU
            if P_reqd_apu < apu_minimum_power
                P_supp_by_apu=0;
                I_supp_by_apu=0;
                H2_used_by_apu=0;
                P_reqd_apu=0;
                fc_eff=0;
                speed_out_of_generator=0;
                torque_out_of_generator=0;
                generator_eff_used=0;
                gb_eff_used=0;
                ICE_eff_used=0;
                volume_of_ICE_fuel_used=0;
                %P_supp_by_apu_to_bus=0;
            else
                
                [P_supp_by_apu,I_supp_by_apu,H2_used_by_apu,fc_eff,speed_out_of_generator,torque_out_of_generator,...
                    generator_eff_used,gb_eff_used,ICE_eff_used,volume_of_ICE_fuel_used,c]=series_hev_apu_3...
                    (apu_selection,P_reqd_apu,number_fc_modules,P_max_apu,timestep,apu_GR,ICE_selection,...
                    generator_selection,ICE_apu_step);
            
            end
        end
        %Distributing the power generated by the APU
        if P_supp_by_apu>=P_reqd_apu_from_bus
            P_supp_by_apu_to_bus=P_reqd_apu_from_bus;
            if ESS1_charge_state==1 && ESS2_charge_state==0
                [DoD_ESS1,CR_ESS1]=ESS1_3(ESS1_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus),...
                    i,CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,...
                    motorfw_selection_ESS1,NoCells_ESS1_par);
            
            elseif ESS1_charge_state==0 && ESS2_charge_state==1
                [DoD_ESS2,CR_ESS2]=ESS2_3(ESS2_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus),i,CR_ESS2,DoD_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            
            elseif ESS1_charge_state==1 && ESS2_charge_state==1
                [DoD_ESS1,CR_ESS1]=ESS1_3(ESS1_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus)/2,...
                    i,CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,...
                    motorfw_selection_ESS1,NoCells_ESS1_par);
                
                [DoD_ESS2,CR_ESS2]=ESS2_3(ESS2_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus)/2,i,CR_ESS2,DoD_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            end
        else
            P_supp_by_apu_to_bus=P_supp_by_apu;
        end
    else
        P_supp_by_apu=0;
        I_supp_by_apu=0;
        H2_used_by_apu=0;
        P_reqd_apu=0;
        fc_eff=0;
        speed_out_of_generator=0;
        torque_out_of_generator=0;
        generator_eff_used=0;
        gb_eff_used=0;
        ICE_eff_used=0;
        volume_of_ICE_fuel_used=0;
        P_supp_by_apu_to_bus=0;
    end
    P_f_bus_out=P_f_bus_out+P_supp_by_apu_to_bus;
%%    
elseif EMS_selection==2
    %Calculate the power supplied by ESS1
    [DoD_ESS1,CR_ESS1,Pmax_ESS1,I_ESS1,V_ESS1,P_supp_by_ESS1,T_b_motorfw_to_gbfw,...
        w_b_motorfw_to_gbfw,T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,...
        T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw]=ESS1_3(ESS1_selection,P_b_bus_in,...
        i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,motorfw_selection_ESS1);

    %Calculate the target DoD_ESS1 for this step
    DoD_target_ESS1=v_req/v_max;
    DoD_target_ESS2=v_req/v_max;
    
    %Calculate the charge state for ESS1
    if DoD_ESS1>DoD_target_ESS1
        ESS1_charge_state=1;
    elseif DoD_ESS1<=DoD_target_ESS1
        ESS1_charge_state=0;
    end

    %Determine the power output from ESS2
    if P_b_bus_in>=0
        if ESS1_charge_state==0 %the condition when ESS2 does not need to produce extra power to charge ESS1
            P_reqd_from_ESS2=P_b_bus_in-P_supp_by_ESS1;
            [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            P_f_bus_out=P_supp_by_ESS1+P_supp_by_ESS2;
        elseif ESS1_charge_state==1 %the condition when ESS2 does need to produce extra power to charge ESS1
            P_reqd_from_ESS2=(P_b_bus_in-P_supp_by_ESS1)+(Pmax_prev_ESS2*ESS2_charging_fraction); %the power requested from ESS2 is the remainder from the difference between that required by the motor and that supplied by ESS1 as well as the extra power at a fraction of ESS2's max power from the previous step that goes towards charging ESS2
            [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2); %power supplied by ESS2
            P_on_bus=P_supp_by_ESS1+P_supp_by_ESS2; %total power on bus
            P_excess_on_bus=P_on_bus-P_b_bus_in;    %excess power on bus
            if P_excess_on_bus>0                    %if the bus has excess power then it goes towards charging ESS1
                [DoD_ESS1,CR_ESS1]=ESS1_3(ESS1_selection,-P_excess_on_bus,i,CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,motorfw_selection_ESS1);   
                P_f_bus_out=P_on_bus-P_excess_on_bus;
            else                                    %if the bus has no excess power then its power is just outputted to the motor
                P_f_bus_out=P_on_bus;
            end
        end
    elseif P_b_bus_in<0 %in the case of braking, ESS1 will not receive any charge from ESS2 because it is receiving the power during the regenerative braking process
        P_reqd_from_ESS2=P_b_bus_in-P_supp_by_ESS1;
        [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
        P_f_bus_out=P_b_bus_in;                 %for a negative power case, the power into the bus always equals the power out, its just a matter of how much the ESS gets charged      
    end 
    
    %Calculate the charge state for ESS2
    if DoD_ESS2>DoD_target_ESS2
        ESS1_charge_state=1;
    elseif DoD_ESS1<=DoD_target_ESS2
        ESS1_charge_state=0;
    end

    %Determine the power output from the APU
    if P_b_bus_in>=0
        P_reqd_apu_from_bus=(P_b_bus_in-(P_supp_by_ESS1+P_supp_by_ESS2));
        P_reqd_apu_from_ESS1=ESS1_charge_state*P_max_apu*apu_charging_fraction;
        P_reqd_apu_from_ESS2=ESS2_charge_state*P_max_apu*apu_charging_fraction;
        P_reqd_apu=P_reqd_apu_from_bus+P_reqd_apu_from_ESS1+P_reqd_apu_from_ESS2;
        
        if apu_type==1 %case of a fuel cell
            [P_supp_by_apu,I_supp_by_apu,H2_used_by_apu,fc_eff,speed_out_of_generator,...
                torque_out_of_generator,generator_eff_used,gb_eff_used,ICE_eff_used,...
                volume_of_ICE_fuel_used,c]=series_hev_apu_3(apu_selection,P_reqd_apu,...
                number_fc_modules,P_max_apu,timestep,apu_GR,ICE_selection,...
                generator_selection,ICE_apu_step);
            
        elseif apu_type==2 %case of an ICE based APU
            if P_reqd_apu < apu_minimum_power
                P_supp_by_apu=0;
                I_supp_by_apu=0;
                H2_used_by_apu=0;
                P_reqd_apu=0;
                fc_eff=0;
                speed_out_of_generator=0;
                torque_out_of_generator=0;
                generator_eff_used=0;
                gb_eff_used=0;
                ICE_eff_used=0;
                volume_of_ICE_fuel_used=0;
                %P_supp_by_apu_to_bus=0;
            else
                [P_supp_by_apu,I_supp_by_apu,H2_used_by_apu,fc_eff,...
                    speed_out_of_generator,torque_out_of_generator,...
                    generator_eff_used,gb_eff_used,ICE_eff_used,...
                    volume_of_ICE_fuel_used,c]=series_hev_apu_3(apu_selection,...
                    P_reqd_apu,number_fc_modules,P_max_apu,timestep,apu_GR,...
                    ICE_selection,generator_selection,ICE_apu_step);
            end
        end
        %Distributing the power generated by the APU
        if P_supp_by_apu>=P_reqd_apu_from_bus
            P_supp_by_apu_to_bus=P_reqd_apu_from_bus;
            if ESS1_charge_state==1 && ESS2_charge_state==0
                [DoD_ESS1,CR_ESS1]=ESS1_3(ESS1_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus),i,CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,motorfw_selection_ESS1);
            elseif ESS1_charge_state==0 && ESS2_charge_state==1
                [DoD_ESS2,CR_ESS2]=ESS2_3(ESS2_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus),i,CR_ESS2,DoD_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            elseif ESS1_charge_state==1 && ESS2_charge_state==1
                [DoD_ESS1,CR_ESS1]=ESS1_3(ESS1_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus)/2,i,CR_ESS1,DoD_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,motorfw_selection_ESS1);
                [DoD_ESS2,CR_ESS2]=ESS2_3(ESS2_selection,-(P_supp_by_apu-P_supp_by_apu_to_bus)/2,i,CR_ESS2,DoD_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            end
        else
            P_supp_by_apu_to_bus=P_supp_by_apu;
        end
    else
        P_supp_by_apu=0;
        I_supp_by_apu=0;
        H2_used_by_apu=0;
        P_reqd_apu=0;
        fc_eff=0;
        speed_out_of_generator=0;
        torque_out_of_generator=0;
        generator_eff_used=0;
        gb_eff_used=0;
        ICE_eff_used=0;
        volume_of_ICE_fuel_used=0;
        P_supp_by_apu_to_bus=0;
    end
    P_f_bus_out=P_f_bus_out+P_supp_by_apu_to_bus;
end
