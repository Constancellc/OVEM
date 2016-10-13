function [DoD_ESS1,DoD_ESS2,P_supp_by_ESS1,P_supp_by_ESS2,CR_ESS1,CR_ESS2,I_ESS1,I_ESS2,V_ESS1,V_ESS2,Pmax_ESS1,...
    Pmax_ESS2,P_f_bus_out,ESS1_charge_state,P_reqd_from_ESS2,T_b_motorfw_to_gbfw,w_b_motorfw_to_gbfw,T_b_gbfw_to_fw,...
    w_b_gbfw_to_fw,P_f_fw_to_gbfw,T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw,T_b_motorfw_in,w_b_motorfw_in,...
    motorfw_eff_b,motorfw_eff_f]=ev_bus_3(P_b_bus_in,i,CR_prev_ESS1,CR_prev_ESS2,DoD_prev_ESS1,DoD_prev_ESS2,...
    DoD_initial_ESS1,DoD_initial_ESS2,NoCells_ESS1,NoCells_ESS2,timestep,ESS1_selection,ESS2_selection,...
    ESS1_charge_off_limit,ESS1_charge_on_limit,Pmax_prev_ESS2,ESS2_charging_fraction,ESS1_charge_state,...
    motorfw_selection_ESS1,motorfw_selection_ESS2,EMS_selection,v_req,v_max,NoCells_ESS1_par)

%Title: ev_bus_3
%
%Author: Reed Doucette
%
%Created: May 10, 2009
%
%Purpose: To take the power request from the motor and output the power
%that can be supplied from the batteries.  The bus controls the state of
%charge of the batteries via a thermostat control strategy where it charges
%ESS1 from ESS2 if ESS1 dips below a certain level until ESS1's SOC rises
%above a certain level.  It is assumed that ESS1 will be the power source
%with a greated specific power (e.g. ultracaps)
%
%List of Inputs
%   P_b_bus_in:
%           This is the power request that comes from the backwards
%           simulation into the bus (W)          
%   i:
%           This is the index of the drive cycle loop that denotes which
%           step through the drive cycle the simulation is currently on
%   CR_prev_ESS1:
%           The is the value of the total charge removed from the selected
%           ESS1 up to and including the previous timestep (Ah)
%   CR_prev_ESS2:
%           This is the value of the total charge removed from the selected
%           ESS2 up to and including the previous timestep (Ah)
%   DoD_prev_ESS1:
%           This is the depth of discharge of ESS1 at the end of the
%           previous timestep
%   DoD_prev_ESS2: 
%           This is the depth of discharge of ESS2 at the end of the
%           previous timestep
%   DoD_initial_ESS1
%           This is the initial depth of discharge of ESS1 as set by the user at the
%           beginning of the simulation 
%   DoD_initial_ESS2
%           This is the initial depth of discharge of ESS2 as set by the
%           user at the beginning of the simulation
%   NoCells_ESS1:
%           This is the number of cells of ESS1
%   NoCells_ESS2: 
%           This is the number of cells of ESS2
%   timestep:
%           The length of the timestep used during the simulation (seconds)
%   ESS1_selection
%           A number specifying which ESS was chosen as the ESS1
%   ESS2_selection
%           A number specifying which ESS was chosen as the ESS2
%   ESS2_charge_off_limit
%           When the ESS1 has a DoD that is less than the
%           ESS2_charge_off_limit then the ESS2 will no longer donate any
%           charge to ESS1
%   ESS2_charge_on_limit
%           When the ESS2 has a DoD that is greater than the
%           ESS2_charge_on_limit then it will donate some of its own charge
%           to charge the ESS1 until the ESS1 has a DoD less than the
%           ESS2_charge_off_limit
%   Pmax_prev_ESS2:
%           This is the maximum power that ESS2 was capable of producing
%           during the previous timestep.  If ESS2 is needed to charge ESS1
%           then ESS2 will donate a preset portion of the maximum power
%           from the previous timestep to ESS1. (W)
%   ESS2_charging_fraction:
%           This is the preset fraction of the maximum power from the
%           previous timestep that will go towards charging ESS1 from ESS2
%           it ESS1 needs to be charged
%   ESS2_charge_state:
%           This is a value either 0 or 1.  0 signifies that ESS1 does not
%           need charging so ESS2 will not charge it. 1 signifies that ESS1
%           does need charging so ESS2 will have to produce additional
%           power to charge ESS1.
%
%List of Outputs
%   DoD_ESS1_1:
%           This is the depth of discharge of ESS1 at the stage before it
%           has been recharged by ESS2
%   DoD_ESS1_2
%           This is the depth of discharge of ESS1 at the stage after it
%           has been recharged by ESS2
%   DoD_ESS2: 
%           This is the depth of discharge of ESS2 at the end of the
%           current time step
%   P_supp_ESS1:
%           This is the power supplied by ESS1 during the current time step
%           (W)
%   P_supp_ESS2:
%           This is the power supplied by ESS2 during the current time step
%           (w)
%   CR_ESS1:
%           This is the total charge removed from ESS1 over the course of
%           the simulation including the charge removed during the current
%           time step (Ah)
%   CR_ESS2:
%           This is the total charge removed from ESS2 over the course of
%           the simulation including the charge removied during the current
%           time step (Ah)
%   I_ESS1:
%           This is the current outputted in the case of motoring or
%           accepted during the case of regen braking by the ESS1 during
%           the current timestep (A)
%   I_ESS2:
%           This is the current outputted in the case of motoring or
%           accepted during the case of regen braking by the ESS1 during
%           the current timestep (A)
%   V_ESS1: 
%           This is the terminal voltage of ESS1 at the end of the current
%           time step (V)
%   V_ESS2:
%           This is the terminal voltage of ESS2 at the end of the current
%           time step (V)
%   P_max_ESS1:
%           This is the maximum power that ESS1 could have
%           accepted/produced during the previous time step (W)
%   P_max_ESS2:
%           This is the maximum power that ESS2 could have
%           accepted/produced during the previous time step (W)
%   P_f_bus_out:
%           This is the power available on the bus at the end of the
%           current time step (W)
%   ESS2_charge_state:
%           This is a value either 0 or 1 for the end of the current timestep.  
%           0 signifies that ESS1 does not need charging so ESS2 will not 
%           charge it. 1 signifies that ESS1 does need charging so ESS2 
%           will have to produce additional power to charge ESS1.  
%   P_reqd_from _ESS2:
%           This is the amount of power required from ESS2 (W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if EMS_selection==1
    %Calculate the power supplied by ESS1
    [DoD_ESS1,CR_ESS1,Pmax_ESS1,I_ESS1,V_ESS1,P_supp_by_ESS1,T_b_motorfw_to_gbfw,w_b_motorfw_to_gbfw,...
        T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw,T_b_motorfw_in,...
        w_b_motorfw_in,motorfw_eff_b,motorfw_eff_f]=ESS1_3(ESS1_selection,P_b_bus_in,i,CR_prev_ESS1,...
        DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,motorfw_selection_ESS1,NoCells_ESS1_par);
    
    %Determine whether ESS1 needs charging
    if DoD_ESS1>=ESS1_charge_on_limit
        ESS1_charge_state=1;
    elseif DoD_ESS1<=ESS1_charge_off_limit
        ESS1_charge_state=0;
    end

    %Determine the power output from ESS2 and the bus
    if P_b_bus_in>=0
        if ESS1_charge_state==0 %the condition when ESS2 does not need to produce extra power to charge ESS1
            P_reqd_from_ESS2=P_b_bus_in-P_supp_by_ESS1;
            [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,...
                i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2);
            
            P_f_bus_out=P_supp_by_ESS1+P_supp_by_ESS2;
            
        elseif ESS1_charge_state==1 %the condition when ESS2 does need to produce extra power to charge ESS1
            P_reqd_from_ESS2=(P_b_bus_in-P_supp_by_ESS1)+(Pmax_prev_ESS2*ESS2_charging_fraction); %the power requested from ESS2 is the remainder from the difference between that required by the motor and that supplied by ESS1 as well as the extra power at a fraction of ESS2's max power from the previous step that goes towards charging ESS2
            [DoD_ESS2,CR_ESS2,Pmax_ESS2,I_ESS2,V_ESS2,P_supp_by_ESS2]=ESS2_3(ESS2_selection,P_reqd_from_ESS2,i,CR_prev_ESS2,DoD_prev_ESS2,DoD_initial_ESS2,NoCells_ESS2,timestep,motorfw_selection_ESS2); %power supplied by ESS2
            P_on_bus=P_supp_by_ESS1+P_supp_by_ESS2; %total power on bus
            P_excess_on_bus=P_on_bus-P_b_bus_in;    %excess power on bus
            
            if P_excess_on_bus>0                    %if the bus has excess power then it goes towards charging ESS1
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
        P_f_bus_out=P_b_bus_in;              %for a negative power case, the power into the bus always equals the power out, its just a matter of how much the ESS gets charged      
    end
        
%%
elseif EMS_selection==2
    %Calculate the power supplied by ESS1
    [DoD_ESS1,CR_ESS1,Pmax_ESS1,I_ESS1,V_ESS1,P_supp_by_ESS1,T_b_motorfw_to_gbfw,w_b_motorfw_to_gbfw,T_b_gbfw_to_fw,w_b_gbfw_to_fw,P_f_fw_to_gbfw,T_f_gbfw_to_motorfw,w_f_gbfw_to_motorfw,T_b_motorfw_in,w_b_motorfw_in,motorfw_eff_b,motorfw_eff_f]=ESS1_3(ESS1_selection,P_b_bus_in,i,CR_prev_ESS1,DoD_prev_ESS1,DoD_initial_ESS1,NoCells_ESS1,timestep,motorfw_selection_ESS1);  

    %Calculate the target DoD_ESS1 for this step
    DoD_target=v_req/v_max;
    
    %Calculate the charge state for ESS2
    if DoD_ESS1>DoD_target
        ESS1_charge_state=1;
    elseif DoD_ESS1<=DoD_target
        ESS1_charge_state=0;
    end
    
    %Determine the power output from ESS2 and the bus
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
    
    
end
