function [P_supp_by_di_ice_2,T_reqd_by_gb_f,w_reqd_by_gb_f,di_ice_2_eff,di_used_by_ice]=...
    level_3_di_ice(~,T_reqd_by_gb_b,w_reqd_by_gb_b,max_P,peak_di_ice_T_2,...
    peak_di_ice_w_2,~,ice_status,di_map,min_di_ice_2_eff)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Title: di_ice_backwards
%
%Author: Justin Bishop
%
%Created: 29 March 2011
%
%edited: XX October 2016
%by: Constance Crozier
%
%Purpose: To the take the torque and speed requested by the gb and
%return the power supplied by the apu and its fuel use. 

%Based on the bsfc map of the SI engine found on
%http://techno-fandom.org/~hobbit/cars/SAE-bsfc.gif which shows that fuel
%consumption (and thus efficiency) is related to the torque delivered by
%the engine and somewhat independent of the speed of the engine.

%The bsfc was converted to a matrix of torque versus speed using the major
%and minor divisions of the curve, with bsfc and efficiency plotted against
%torque.  The ensuing logarithmic best fit yielded an R^2 value of 0,98,
%with the equation of the curve used to determine the engine losses at a
%particular torque.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Set the maximum and minimum efficiency of the engine


peak_T = peak_di_ice_T_2;
%min_T = 0;
peak_w = peak_di_ice_w_2;

% scale_factor_T = peak_di_ice_T_2/peak_T;
% T_reqd_by_gb_b = T_reqd_by_gb_b/scale_factor_T;

if ice_status == 1; 

    % If the speed and torque requested by the backwards gb are within the 
    % the enigne's capabilities set the forwards gb requests to the
    % backwards ones. Otherwise request the max possible speed / torque
    
    if w_reqd_by_gb_b > peak_w && w_reqd_by_gb_b>=0;
        w_reqd_by_gb_f = peak_w;
    else
        w_reqd_by_gb_f = w_reqd_by_gb_b;
    end
        
    if T_reqd_by_gb_b > peak_T && T_reqd_by_gb_b>=0;
        T_reqd_by_gb_f = peak_T;
    else
        T_reqd_by_gb_f = T_reqd_by_gb_b;
    end

    %% Compute the engine efficiency 
    % peak_di_ice_2_eff=.349729;
    % min_di_ice_2_eff=.134063;
    % 
    % if T_reqd_by_gb_f ~=0
    %     di_ice_2_eff= 4e-10*(T_reqd_by_gb_f)^4 - 2e-7*(T_reqd_by_gb_f)^3 + 1e-5*(T_reqd_by_gb_f)^2 + 0.0022*T_reqd_by_gb_f + 0.127;
    % else
    %     di_ice_2_eff=min_di_ice_2_eff;
    % end
    % 
    % % Set reasonable limits to motor efficiency
    % if di_ice_2_eff > peak_di_ice_2_eff
    %     di_ice_2_eff=peak_di_ice_2_eff;
    %     
    % elseif di_ice_2_eff < min_di_ice_2_eff
    %     di_ice_2_eff=min_di_ice_2_eff;
    % else %di_ice_2_eff < peak_di_ice_2_eff && di_ice_2_eff>min_di_ice_2_eff;
    % 
    % end

    %% Find efficiency based on T, w
    %peak_di_ice_2_eff=max(max(di_map))/100;%.349729;
    %min_di_ice_2_eff= single(min(min(di_map))/100);%.134063;
    % T_lookup = linspace(0,1,100);
    % w_lookup = T_lookup;

    % w_search = max([round(single(w_reqd_by_gb_f/peak_di_ice_w_2))*100 1]);
    % t_search = max([round(single(T_reqd_by_gb_f/peak_di_ice_T_2))*100 1]);
    %[w_reqd_by_gb_f T_reqd_by_gb_f peak_w peak_T]

    % Find the percentage of the peak values for torque and speed being
    % requested
    w_search = round(single(w_reqd_by_gb_f/peak_di_ice_w_2)*100);
    t_search = round(single(T_reqd_by_gb_f/peak_di_ice_T_2)*100);

    %[w_reqd_by_gb_f/peak_di_ice_w_2 T_reqd_by_gb_f/peak_di_ice_T_2 w_search t_search]


    % Providing you're asking for some torque
    if T_reqd_by_gb_f >0
    % %     di_ice_2_eff = interp2(w_lookup,T_lookup,di_map,w_reqd_by_gb_f/peak_di_ice_w_2,...
    % %         T_reqd_by_gb_f/peak_di_ice_T_2,'nearest')/100;
    % 
    
        % This just stops you trying to index the 0th elememt. Classic
        % matlab
        if w_search == 0;
            w_search = 1;
        end

        if t_search == 0;
            t_search =1;
        end
        
        % An effeciency is read off the map, using these percentages to
        % index the operating point of the engine
        di_ice_2_eff = single(di_map(w_search,t_search)/100);

    % Otherwise set it to min efficiency from the map
    else
        di_ice_2_eff=min_di_ice_2_eff;
    end

    % How on earth would this happen? :/
    if di_ice_2_eff < min_di_ice_2_eff;
        di_ice_2_eff=min_di_ice_2_eff;
    else
    end

    %%

    %P_reqd_by_di_ice_2 = min([(T_reqd_by_gb_f*w_reqd_by_gb_f)/di_ice_2_eff max_P]);%P_reqd_by_gb/di_ice_2_eff;

    %P_reqd_by_di_ice_2 = (T_reqd_by_gb_f*w_reqd_by_gb_f)/di_ice_2_eff;%P_reqd_by_gb/di_ice_2_eff;

    %P_reqd_by_di_ice_2 = single(min([max_P T_reqd_by_gb_f*w_reqd_by_gb_f/di_ice_2_eff]));

    P_supp_by_di_ice_2 = single(T_reqd_by_gb_f*w_reqd_by_gb_f);

    di_used_by_ice = P_supp_by_di_ice_2/di_ice_2_eff/3600/1000*3.6;%MJ

    if P_supp_by_di_ice_2 > max_P && P_supp_by_di_ice_2>0;
            P_supp_by_di_ice_2 = max_P;
    else
    end

    else 
        P_supp_by_di_ice_2 = 0;
end