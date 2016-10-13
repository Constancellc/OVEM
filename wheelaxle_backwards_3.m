function [T_b_wheelaxle_out,w_b_wheelaxle_out,P_b_wheelaxle_out]=wheelaxle_backwards_3(F_b_wheelaxle_in,v_b_wheelaxle_in,...
    v0_ach,v1_req,tire_radius,timestep,total_driven_wheelaxle_inertia,in_out_of_wheel,number_of_driven_wheels,wheelaxle_efficiency,...
    regen_status,percentage_of_weight_on_front_axle,percentage_of_weight_on_rear_axle,front_or_rear_wheel_drive,dynamic_braking)

%Title: wheelaxle_backwards_3
%
%Author: Reed Doucette
%
%Created: May 15, 2009
%
%Purpose: To take the forces and speeds required by the vehicle and pass
%them through to the rest of the vehicle during the backwards phase of the
%vehicle simulation.
%
%List of Inputs:
%       F_b_wheelaxle_in: 
%           The force required to move that vehicle from the speed its at
%           to the requested speed
%       v_b_wheelaxle_in:
%           The average speed required from the vehicle during the timestep
%       v0_ach:
%           The speed achieved at the end of the previous timestep
%       v1_req: 
%           The speed the vehicle is requested to be at, at the end of the
%           current drive step.
%       tire_radius:
%           The radius of the tire
%       timestep:
%           The length of the current timestep in seconds
%       total_driven_wheelaxle_inertia:
%           The total inertia of the driven wheels and axles
%       in_out_of_wheel:
%           Specifies whether the vehicle has in wheel or out of wheel
%           motors.   1 if they are in wheel, and 0 if they are out of
%           wheel
%       number_of_driven_wheels:
%           Specifies the number of driven wheels, either 2 or 4
%       wheelaxle_efficiency
%           The set wheelaxle efficiency
%
%List of Outputs:
%       T_b_wheelaxle_out:
%           The torque requested by the driven wheels and axle(s) during
%           the backwards part of the simulation
%       w_b_wheelaxle_out:
%           The angular speed requested by driven wheels and axle(s)
%           during the backwards part of the simulation.
%       P_b_wheelaxle_out:
%           The power requested by the driven wheels) and axle(s) during
%           the backwards part of the simulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T_reqd_to_overcome_inertia=single(total_driven_wheelaxle_inertia*(v1_req-v0_ach)/tire_radius/timestep);

if dynamic_braking==0;
    if  F_b_wheelaxle_in == 0
        T_b_wheelaxle_out=0;
    elseif (v1_req-v0_ach) >= 0  
        T_b_wheelaxle_out=(T_reqd_to_overcome_inertia+F_b_wheelaxle_in*tire_radius)...
            /(wheelaxle_efficiency); 
    elseif (v1_req-v0_ach) < 0 
        T_b_wheelaxle_out=(T_reqd_to_overcome_inertia+F_b_wheelaxle_in*tire_radius)...
            *(wheelaxle_efficiency);
    end

    %Modify those requests for an in wheel motor
    if in_out_of_wheel == 1
        if number_of_driven_wheels == 2
            T_b_wheelaxle_out=T_b_wheelaxle_out/2;
        elseif number_of_driven_wheels == 4
            T_b_wheelaxle_out=T_b_wheelaxle_out/4;
        end
    end
    
    %% If no regen is employed
    if regen_status==0
        if F_b_wheelaxle_in < 0
            T_b_wheelaxle_out=0;
        end
    end
    
else% dynamic_braking==1
    if  F_b_wheelaxle_in == 0
        T_b_wheelaxle_out=0;
    elseif (v1_req-v0_ach) >= 0  
        T_b_wheelaxle_out=(T_reqd_to_overcome_inertia+F_b_wheelaxle_in*tire_radius)/(wheelaxle_efficiency); 
    elseif (v1_req-v0_ach) < 0 
        if front_or_rear_wheel_drive==1
            T_b_wheelaxle_out=(T_reqd_to_overcome_inertia+F_b_wheelaxle_in*tire_radius)*(wheelaxle_efficiency)*percentage_of_weight_on_front_axle;
        elseif front_or_rear_wheel_drive==2
            T_b_wheelaxle_out=(T_reqd_to_overcome_inertia+F_b_wheelaxle_in*tire_radius)*(wheelaxle_efficiency)*percentage_of_weight_on_rear_axle;
        elseif front_or_rear_wheel_drive==4
            T_b_wheelaxle_out=(T_reqd_to_overcome_inertia+F_b_wheelaxle_in*tire_radius)*(wheelaxle_efficiency)^2;
        end
    end
    %Modify those requests for an in wheel motor
    if in_out_of_wheel == 1
        if number_of_driven_wheels == 2
            T_b_wheelaxle_out=T_b_wheelaxle_out/2;
        elseif number_of_driven_wheels == 4
            T_b_wheelaxle_out=T_b_wheelaxle_out/4;
        end
    end

  %%  If no regen is employed
    if regen_status==0
        if F_b_wheelaxle_in < 0
            T_b_wheelaxle_out=0;
        end
    end
end

w_b_wheelaxle_out=single(v_b_wheelaxle_in/tire_radius);%Output is rad/s
P_b_wheelaxle_out=w_b_wheelaxle_out*T_b_wheelaxle_out; %Output in Nm.