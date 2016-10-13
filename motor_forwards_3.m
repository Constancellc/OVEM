function [T_f_motor_out,w_f_motor_out,motor_eff_f]=motor_forwards_3(P_f_motor_in,...
    w_b_motor_out,speed_range,~,eff_matrix,TperP,T_b_motor_in,T_max_speed_vector,...
    T_max_profile,~)

%Title: motor_forwards_3
%
%Author: Reed Doucette
%
%Created: May 1, 2009
%
%Purpose: To calculate the torque and speed supplied by the motor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Calculate the supplied output speed of the motor
w_f_motor_out=w_b_motor_out;

%Calculate the maximum torque the motor can produce given its power input
T_max_supp=TperP*P_f_motor_in;

%% Old method - Now limit that maximum torque if it needs to be limited
%T_max=interp1(T_max_speed_vector,T_max_profile,w_b_motor_out);

%% New method - approx
[~,min_t_error_index] = min(abs(T_max_speed_vector - w_b_motor_out));
T_max = T_max_profile(min_t_error_index);

%%
%enforce torque limit
if T_max_supp > T_max && T_b_motor_in >= 0
    T_max_supp=T_max;
elseif T_max_supp < -T_max && T_b_motor_in<0
    T_max_supp=-T_max;
end

%% Old = Calculate the motor efficiency based on the maximum amount of torque it
%can supply 

%motor_eff_f=interp2(speed_range,torque_range,eff_matrix,w_b_motor_out,abs(T_max_supp))

%% New - approx method

% w_search = max([round(w_b_motor_out/max(speed_range)*length(speed_range)) 1]);
% t_search = max([round(abs(T_max_supp)/max(T_max_profile)*length(speed_range)) 1]);

%%

w_search = round(w_b_motor_out/max(speed_range) * length(speed_range));
t_search = round(abs(T_max_supp)/max(T_max_profile) * length(speed_range));

if w_search == 0;
    w_search = 1;
elseif w_search>length(speed_range)
    w_search = length(speed_range);
end

if t_search == 0;
    t_search = 1;
elseif t_search>length(speed_range)
    t_search = length(speed_range);
end
%%

motor_eff_f = eff_matrix(t_search,w_search);


%%
%Calculate the torque required to be put into the motor
if T_b_motor_in>=0
    T_f_motor_out=P_f_motor_in*motor_eff_f/w_f_motor_out;
elseif T_b_motor_in<0
    T_f_motor_out=P_f_motor_in/motor_eff_f/w_f_motor_out;
end

% %Compute the power needed by the motor
% if number_of_motors==1
%     P_b_motor_out=T_f_motor_out*w_f_motor_out;
% elseif number_of_motors==2
%     P_b_motor_out=T_f_motor_out*w_f_motor_out*2;
% elseif number_of_motors==4
%     P_b_motor_out=T_f_motor_out*w_f_motor_out*4;
% end

% %Calculate the actual power input to the motor given its efficiency at the
% %maximum torque it could operate at
% if P_f_motor_in>=0
%     P_supp_actual=P_f_motor_in*motor_eff_f;
% elseif P_f_motor_in < 0
%     P_supp_actual=P_f_motor_in/motor_eff_f;
% end
% 
% %Calculate the torque obtainable given those power losses
% if T_b_motor_in==0
%     T_f_motor_out=0;
% elseif number_of_motors==1    
%     T_f_motor_out=single(P_supp_actual/w_b_motor_out);
% elseif number_of_motors==2
%     T_f_motor_out=P_supp_actual/w_b_motor_out/2;
% elseif number_of_motors==4
%     T_f_motor_out=P_supp_actual/w_b_motor_out/4;
% end
% 
%Limit the torque so that it doesn't supply more than was computed to be
%needed during the backwards calculation
if T_f_motor_out >=0 && T_f_motor_out > T_b_motor_in
    T_f_motor_out = T_b_motor_in;
elseif T_f_motor_out < 0 && T_f_motor_out <T_b_motor_in
    T_f_motor_out = T_b_motor_in;
end

% 