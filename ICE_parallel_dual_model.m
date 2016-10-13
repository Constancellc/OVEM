function [w_f_ICE_to_gb,T_f_ICE_to_gb,ICE_eff,volume_of_fuel_used_by_ICE]=...
    ICE_parallel_dual_model(T_b_gb_to_ICE,w_b_gb_to_ICE,DoD_ESS1,DoD_ESS2,...
    ESS1_charge_on_limit,ESS2_charge_on_limit,cs_min_speed,cs_min_torque,...
    ICE_speed_vector,ICE_torque_vector,~,ICE_max_speed,ICE_min_torque_w_profile,...
    ~,~,ICE_max_torque_w_profile,ICE_max_torque_T_profile,ICE_eff_map,...
    ICE_fuel_heating_value,ICE_fuel_density,timestep,powertrain_type)

%Title: ICE_parallel_dual_model
%
%Author: Reed Doucette
%
%Created: March 10, 2010
%
%Purpose: To model the ICE in a parallel or dual configuration
%
%List of Inputs: 
%   T_b_gb_to_ICE               The torque request coming from the backwards gb
%                               connected to the PG
%   w_b_gb_to_ICE               The speed request coming from the backwards gb
%                               connected to the PG
%   DoD_ESS1                    The current DoD of ESS1
%   DoD_ESS2                    The current DoD of ESS2
%   ESS1_charge_on_limit        The DoD point at which ESS1 will request 
%                               additional power to recharge itself
%   ESS2_charge_on_limit        The DoD point at which ESS2 will request
%                               additional power to recharge itself
%   cs_min_speed                The minimum speed that the control strategy
%                               will allow the ICE to operate at
%   cs_min_torque               The minimum torque that the control strategy
%                           	ill allow the ICE to operate at
%   ICE_speed_vector            The speed index for the ICE eff map
%
%   ICE_torque_vector           The torque index for the ICE eff map
%
%   ICE_min_speed               The minimum speed of the ICE
%
%   ICE_max_speed               The maximum speed of the ICE
%
%   ICE_min_torque_w_profile    The speed vector of the minimum torque
%                               curve for the ICE
%   ICE_min_torque_T_profile    The torque vector of the minimum torque
%                               curve for the ICE
%   ICE_min_power               The minimum power of the ICE
%   ICE_max_torque_w_profile    The speed vector of the maximum torque
%                               curve for the ICE
%   ICE_max_torque_T_profile    The torque vector of the maximum torque
%                               curve for the ICE
%   ICE_eff_map                 The ICE efficiency map
%
%   ICE_fuel_heating_value      The heating value of the fuel used in the
%                               ICE
%
%   ICE_fuel_density            The density of the ICE's fuel
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Limit the speed to between the operable range
if w_b_gb_to_ICE >ICE_max_speed
    w_f_ICE_to_gb=ICE_max_speed;
elseif w_b_gb_to_ICE < cs_min_speed
    w_f_ICE_to_gb=cs_min_speed;
else
    w_f_ICE_to_gb = w_b_gb_to_ICE;
end

%% New method - approx
[~,min_w_error_index] = min(abs(ICE_min_torque_w_profile - w_b_gb_to_ICE));
min_torque_at_current_speed = cs_min_torque(min_w_error_index);

[~,min_t_error_index] = min(abs(ICE_max_torque_w_profile - w_b_gb_to_ICE));
max_torque_at_current_speed = ICE_max_torque_T_profile(min_t_error_index);


%Make sure that the torque request lies within the operable limits
if T_b_gb_to_ICE > max_torque_at_current_speed;
    T_f_ICE_to_gb=max_torque_at_current_speed;
elseif T_b_gb_to_ICE < min_torque_at_current_speed;
    T_f_ICE_to_gb=min_torque_at_current_speed;
else
    T_f_ICE_to_gb = T_b_gb_to_ICE;
    
end

%w_b_gb_to_ICE = max([cs_min_speed 0]);
%w_b_gb_to_ICE = min([ICE_max_speed max([cs_min_speed 0])]);


%% Old method - Determine the minimum and maximum torque allowed at the given speed

%min_torque_at_current_speed=interp1(ICE_min_torque_w_profile,cs_min_torque,w_b_gb_to_ICE,'linear','extrap');
%max_torque_at_current_speed=interp1(ICE_max_torque_w_profile,ICE_max_torque_T_profile,w_b_gb_to_ICE,'linear','extrap');



%T_b_gb_to_ICE =min([max([min_torque_at_current_speed 0]) max_torque_at_current_speed]);

%% For the parallel case when the ICE won't produce extra power to recharge the ESS
if powertrain_type==3
    %For the case when the speed of the engine is too low
    if w_b_gb_to_ICE < cs_min_speed
        w_f_ICE_to_gb=0;
        T_f_ICE_to_gb=0;
    %For the case when the engine is operating at an allowable speed
    else
        %For the case when the torque demanded is too low
        if T_b_gb_to_ICE < min_torque_at_current_speed 
                T_f_ICE_to_gb=0;
                w_f_ICE_to_gb=0;
        % For the case when the torque demanded is at or above the minimum torque allowed    
        else 
                T_f_ICE_to_gb=T_b_gb_to_ICE;
                w_f_ICE_to_gb=w_b_gb_to_ICE;
        end
    end
%% For the dual case when the ICE will produce extra power to recharge the ESS
% elseif powertrain_type==4 || powertrain_type==16;% (PHEV version) 
%     %For the case when the speed of the engine is too low
%     
%     if w_b_gb_to_ICE < cs_min_speed
%         w_f_ICE_to_gb=0;
%         T_f_ICE_to_gb=0;
%     %For the case when the engine is operating at an allowable speed
%     else
%         %For the case when the torque demanded is too low
%         if T_b_gb_to_ICE < min_torque_at_current_speed 
%             %when there is no need for the ICE to produce extra torque to recharge
%             %the ESS
%             if DoD_ESS1 <= ESS1_charge_on_limit && DoD_ESS2 <= ESS2_charge_on_limit
%                 T_f_ICE_to_gb=0;
%                 w_f_ICE_to_gb=0;
%             %when the ICE needs to produce extra torque to recharge the ESS
%             else
%                 T_f_ICE_to_gb=(max_torque_at_current_speed-...
%                     min_torque_at_current_speed)*.3+min_torque_at_current_speed;
%                 w_f_ICE_to_gb=w_b_gb_to_ICE;
%             end
%         % For the case when the torque demanded is at or above the minimum torque allowed    
%         else 
%             %When there is no need for the ICE to produce extra torque to recharge
%             %the ESS
%             if DoD_ESS1 <= ESS1_charge_on_limit && DoD_ESS2 <= ESS2_charge_on_limit
%                 T_f_ICE_to_gb=T_b_gb_to_ICE;
%                 w_f_ICE_to_gb=w_b_gb_to_ICE;
%             %When the ICE needs to produce extra torque to recharge the ESS
%             else
%                 T_f_ICE_to_gb=(max_torque_at_current_speed-T_b_gb_to_ICE)*.3+T_b_gb_to_ICE;
%                 w_f_ICE_to_gb=w_b_gb_to_ICE;
%             end
%         end
%     end
% end

%% New method
elseif powertrain_type==4 || powertrain_type==16;% (PHEV version) 
   
w_search = max([round(w_f_ICE_to_gb/max(ICE_speed_vector) * length(ICE_speed_vector)) 1]);
t_search = max([round(T_f_ICE_to_gb/max(ICE_torque_vector) * length(ICE_torque_vector)) 1]);

% if w_search == 0;
%     w_search = 1;
% elseif w_search>length(ICE_speed_vector)
%     w_search = length(ICE_speed_vector);
% end
% 
% if t_search == 0;
%     t_search = 1;
% elseif t_search>length(ICE_torque_vector)
%     t_search = length(ICE_torque_vector);
% end
ICE_eff = ICE_eff_map(w_search,t_search);
    
    
    %For the case when the speed of the engine is too low
    
%     if w_b_gb_to_ICE < cs_min_speed
%         w_f_ICE_to_gb=0;
%         T_f_ICE_to_gb=0;
%     %For the case when the engine is operating at an allowable speed
%     else
        %For the case when the torque demanded is too low
        if T_b_gb_to_ICE < min_torque_at_current_speed 
            %when there is no need for the ICE to produce extra torque to recharge
            %the ESS
            if DoD_ESS1 <= ESS1_charge_on_limit && DoD_ESS2 <= ESS2_charge_on_limit
                T_f_ICE_to_gb=0;
                w_f_ICE_to_gb=0;
            %when the ICE needs to produce extra torque to recharge the ESS
            else
                T_f_ICE_to_gb=(max_torque_at_current_speed-...
                    min_torque_at_current_speed)*.3+min_torque_at_current_speed;
                w_f_ICE_to_gb=w_b_gb_to_ICE;
            end
        % For the case when the torque demanded is at or above the minimum torque allowed    
        else 
            %When there is no need for the ICE to produce extra torque to recharge
            %the ESS
            if DoD_ESS1 <= ESS1_charge_on_limit && DoD_ESS2 <= ESS2_charge_on_limit
                T_f_ICE_to_gb=T_b_gb_to_ICE;
                w_f_ICE_to_gb=w_b_gb_to_ICE;
            %When the ICE needs to produce extra torque to recharge the ESS
            else
                T_f_ICE_to_gb=(max_torque_at_current_speed-T_b_gb_to_ICE)*.3+T_b_gb_to_ICE;
                w_f_ICE_to_gb=w_b_gb_to_ICE;
            end
        end
%     end
 end

%Calculate the efficiency and the fuel used
if w_f_ICE_to_gb == 0 || T_f_ICE_to_gb == 0
    ICE_eff=0;
    volume_of_fuel_used_by_ICE=0;
else    
       
    %% Old method
    
    %ICE_eff=interp2(ICE_speed_vector,ICE_torque_vector,ICE_eff_map,w_f_ICE_to_gb,T_f_ICE_to_gb);
    

%%
    P_into_ICE=w_f_ICE_to_gb*T_f_ICE_to_gb/ICE_eff;
    volume_of_fuel_used_by_ICE=P_into_ICE/ICE_fuel_heating_value*timestep/ICE_fuel_density;
end       