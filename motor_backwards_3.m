function [P_b_motor_out,w_b_motor_out,T_b_motor_out,TperP,motor_eff_b]=motor_backwards_3(T_b_motor_in,...
    w_b_motor_in,w0,w1,w_max,rotor_inertia,speed_range,torque_range,eff_matrix,timestep,...
    T_max_speed_vector,T_max_profile,number_of_motors)

%Title: motor_backwards_3
%
%Author: Reed Doucette
%
%Created: May 1, 2009
%
%Purpose: To calculate the power required by the motor in order to meet the
%drive cycle requirements.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%enforce top speed
if w_b_motor_in>w_max
    w_b_motor_out=w_max;
else
    w_b_motor_out=w_b_motor_in;
end

%account for torque required to overcome rotor inertia
T_b_motor_out=T_b_motor_in+rotor_inertia*(w1-w0)/timestep;

%% Old method - calculate torque limit
%T_max=interp1(T_max_speed_vector,T_max_profile,w_b_motor_out);

%% New method - approx

[~,min_t_error_index] = min(abs(T_max_speed_vector - w_b_motor_out));
T_max = T_max_profile(min_t_error_index);

%% Enforce torque limit
if T_b_motor_out > T_max && T_b_motor_in >= 0
    T_b_motor_out=T_max;
elseif T_b_motor_out < -T_max && T_b_motor_in<0
    T_b_motor_out=-T_max;
end

%% Old method - Calculate backwards motor efficiency (assuming motoring and regen have the
%same efficiency map
%motor_eff_b=interp2(speed_range,torque_range,eff_matrix,w_b_motor_out,abs(T_b_motor_out))

%% New - approx method

% 
% abs(T_b_motor_out)
% [torque_range' speed_range']
% [max(torque_range) T_max max(T_max_profile)]
% abs(T_b_motor_out)/max(torque_range)

%t_search = max([round(abs(T_b_motor_out)/max(T_max_profile)*length(torque_range)) 1]);
%w_search = max([round(w_b_motor_out/max(speed_range)*length(speed_range)) 1]);

%%

t_search = round(abs(T_b_motor_out)/max(T_max_profile)*length(torque_range));
w_search = round(w_b_motor_out/max(speed_range)*length(speed_range));


if w_search == 0;
    w_search = 1;
elseif w_search>length(speed_range)
    w_search = length(speed_range);
end

if t_search == 0;
    t_search = 1;
elseif t_search>length(torque_range)
    t_search = length(torque_range);
end
%%

motor_eff_b = eff_matrix(t_search,w_search);

%%

%Calculate the torque required to be put into the motor

if T_b_motor_in>=0
    T_b_motor_out=T_b_motor_in*motor_eff_b;
elseif T_b_motor_in<0
    T_b_motor_out=T_b_motor_in/motor_eff_b;
end

%Compute the power needed by the motor
if number_of_motors==1
    P_b_motor_out=T_b_motor_out*w_b_motor_out;
elseif number_of_motors==2
    P_b_motor_out=T_b_motor_out*w_b_motor_out*2;
elseif number_of_motors==4
    P_b_motor_out=T_b_motor_out*w_b_motor_out*4;
end

%Torque required per unit of power input required
if P_b_motor_out == 0
    TperP=1;
else
    TperP=T_b_motor_in/P_b_motor_out;
end