function [P_reqd_by_si_ice_2,T_reqd_by_gb_f,w_reqd_by_gb_f,si_ice_2_eff]=level_3_si_ice(~,T_reqd_by_gb_b,...
    w_reqd_by_gb_b,max_P,peak_si_ice_T_2,peak_si_ice_w_2,~,ice_status,si_map,min_si_ice_2_eff)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Title: si_ice_backwards
%
%Author: Justin Bishop
%
%Created: 29 March 2011
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

peak_T = peak_si_ice_T_2;
%min_T = 0;
peak_w = peak_si_ice_w_2;

% scale_factor_T = peak_si_ice_T_2/peak_T;
% T_reqd_by_gb_b = T_reqd_by_gb_b/scale_factor_T;

if ice_status == 1; 
    if w_reqd_by_gb_b > peak_w;
        w_reqd_by_gb_f = peak_w;
    elseif w_reqd_by_gb_b <=0;
        w_reqd_by_gb_f = 0;
    else
        w_reqd_by_gb_f = w_reqd_by_gb_b;
    end
    
    if T_reqd_by_gb_b > peak_T;
        T_reqd_by_gb_f = peak_T;
    elseif T_reqd_by_gb_b <= 0;
        T_reqd_by_gb_f = 0;
    else
        T_reqd_by_gb_f = T_reqd_by_gb_b;
    end
    
  %  [T_reqd_by_gb_b T_reqd_by_gb_f]
    
%% Compute the engine efficiency
% peak_si_ice_2_eff= .349729;
% min_si_ice_2_eff= .134063;
% 
% if T_reqd_by_gb_f ~=0
%     si_ice_2_eff= 8e-7*(T_reqd_by_gb_f)^3 - 0.0002*(T_reqd_by_gb_f)^2 + 0.0128*(T_reqd_by_gb_f) + 0.0092;
% else
%     si_ice_2_eff=min_si_ice_2_eff;
% end
% 
% %Set reasonable limits to motor efficiency
% if si_ice_2_eff > peak_si_ice_2_eff
%     si_ice_2_eff=peak_si_ice_2_eff;
% elseif si_ice_2_eff < min_si_ice_2_eff
%     si_ice_2_eff=min_si_ice_2_eff;
% else %si_ice_2_eff < peak_si_ice_2_eff && si_ice_2_eff>min_si_ice_2_eff;
% 
% end
    
%% Find efficiency based on T, w maps
%min_si_ice_2_eff= single(min(min(si_map))/100);%.134063;
% T_lookup = linspace(0,1,100);
% w_lookup = T_lookup;

w_search = max([round(w_reqd_by_gb_f/peak_si_ice_w_2)*100 1]);
t_search = max([round(T_reqd_by_gb_f/peak_si_ice_T_2)*100 1]);


%if T_reqd_by_gb_b >0;
%    si_ice_2_eff = interp2(w_lookup,T_lookup,si_map,w_reqd_by_gb_f/peak_si_ice_w_2,T_reqd_by_gb_f/peak_si_ice_T_2,'nearest')/100;

% if w_search == 0;
%     w_search = 1;
% end
% 
% if t_search == 0;
%     t_search =1;
% end

%%
    si_ice_2_eff = single(si_map(w_search,t_search)/100);

% else
%     si_ice_2_eff=min_si_ice_2_eff;
% end
%     
% if si_ice_2_eff < min_si_ice_2_eff;
%     si_ice_2_eff=min_si_ice_2_eff;
% else
% end

%%

P_reqd_by_si_ice_2 = T_reqd_by_gb_f/si_ice_2_eff*w_reqd_by_gb_f;%min([((T_reqd_by_gb_f*w_reqd_by_gb_f)/si_ice_2_eff) max_P]);%P_reqd_by_gb/si_ice_2_eff;
%[P_reqd_by_si_ice_2 T_reqd_by_gb_f w_reqd_by_gb_f si_ice_2_eff]
    

if P_reqd_by_si_ice_2 > max_P;
    P_reqd_by_si_ice_2 = max_P;
else
end

else 
        P_reqd_by_si_ice_2 = 0;
end