function [DoD,P_supp,CR,I,V,Pmax]=battery_model_3(P_reqd,ind,CR_prev,DoD_prev,...
    DoD_initial,NoCells,dT,Rint,Imax,Eo,K,Q,A,B,Capacity,total_cells,NoCells_ESS1_par)

%Title: battery_model
%
%Author: Reed Doucette
%
%Created: May 7,2009
%
%Record of Revisions:
%   June 4,2009: The function was changed to generate an open circuit
%   voltage based on the new battery model taken from the paper by Tremblay
%   et. al. entitled "A Generic Battery Model for the Dynamic Simulation of
%   Hybrid Electric Vehicles". By Reed Doucette.
%
%Purpose: Given battery parameters that can be obtained from the datasheet,
%and given a power requirement, this function can calculate the performance
%of a battery, typically over a given drive cycle.
%
%List of Inputs:
%   P_reqd:
%           The power requested from the battery.  A positive power request
%           indicates power leaving the battery and a negative power
%           request indicates power flowing into the battery.
%   ind:      
%           The index of the drive cycle.
%   CR_prev:
%           The cumulative amount of charge removed from the battery prior
%           to the current time step.
%   DoD_prev: 
%           The depth of discharge of the battery at the previous time
%           step.
%   DoD_initial:
%           The depth of discharge of the battery when the drive cycle was
%           started.  It will typically be 0, indicating the battery starts
%           with a full charge
%   NoCells:
%           The number of cells in the battery module     

%   dT:     
%           The length of a time step in the drive cycle
%   Rint:   
%           The internal resistance of the battery as determined from
%           fitting the battery model to the discharge curves provided by
%           the manufacturer
%   Imax:
%           The maximum current the battery can handle.
%   Eo
%           Battery constant voltage (V)
%   K
%           Polarization voltage of the battery (V)
%   Q
%           Battery capacity in Ah that was used in order to get the model
%           to fit the supplied discharge curves
%   A
%           The exponential zone amplitude (V) that was determined in order
%           to get the model to accurately fit the battery's discharge
%           curves
%   B
%           The exponential zone's time constant's inverse (Ah^-1)
%   Capacity:
%           The capacity of the battery as obtained from the datasheet
%
%List of Outputs:
%   P_supp: 
%           The power that the battery can supply, it will be zero in the
%           case when the battery is receiving power but is already full
%           charged.
%   DoD:    
%           The depth of discharge of the battery after the current time
%           step.
%   CR:
%           The charge removed from the battery during the current time
%           step.
%   I:      
%           The amount of current the battery can either supply or take on
%           given its condition in the current time step.
%   V:  
%           The actual voltage of the battery pack at the end of the
%           current time step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Scale the internal resistance of the battery 
R_ser=Rint*NoCells;
Rin = R_ser/NoCells_ESS1_par;
%Rin = Rint*NoCells;

  %Voc = single(NoCells*(Eo-K*Q*NoCells/(Q*NoCells-0)+A*exp(-B*0)));
  %Imax = Voc/Rin;

%The open circuit voltage is based on the DoD from the previous step, at
%the first step it is based on the the initial DoD
if ind==1
    E=open_circuit_batt_voltage(DoD_initial,NoCells,Eo,K,Q*NoCells,A,B,CR_prev);
else 
    E=open_circuit_batt_voltage(DoD_prev,NoCells,Eo,K,Q*NoCells,A,B,CR_prev);
end




%Calculate the maximum power that can be taken from or put into the battery
%so that you still get a real current
Pmax=(E^2)/4/Rin;

%Limit the maximum amount of power that can be discharged from the battery
%and subtract a little bit from Pmax so that we don't try to take the
%square root of a negative number
if P_reqd>=Pmax && P_reqd>=0
    P_reqd=Pmax-.01;
elseif P_reqd<=-Pmax && P_reqd<0
    P_reqd=-Pmax+.01;
end

%Calculate the current and charge removed if this is the first step of the
%drive cycle
if ind==1
%     if P_reqd>=0 && DoD_initial<.99
%         I=(E-(E^2-(4*Rin*P_reqd))^.5)/(2*Rin);  %current taken out of the battery
%     elseif P_reqd>=0 && DoD_initial>=.99
%         I=0;                                    %no current can be taken out of an empty battery
%     elseif P_reqd<0 && DoD_initial>0
%         I=(-E+(E^2+(4*Rin*P_reqd))^.5)/(2*Rin); %current put into the battery
%     elseif P_reqd<0 && DoD_initial<=0
%         I=0;                                    %no current can be put into a full battery
%     end

    if P_reqd>=0 && DoD_initial<.99
        I=(E-(E^2-(4*Rin*P_reqd))^.5)/(2*Rin);  %current taken out of the battery
    elseif P_reqd>=0 && DoD_initial>=.99
        I=0;                                    %no current can be taken out of an empty battery
    elseif P_reqd<0 && DoD_initial>0
        I=(-E+(E^2+(4*Rin*P_reqd))^.5)/(2*Rin); %current put into the battery
    elseif P_reqd<0 && DoD_initial<=0
        I=0;                                    %no current can be put into a full battery
    end


    %Limit the current to the maximum current
    if I>=Imax %&& I>=0
        I=Imax;
    elseif I<-Imax %&& I<0
        I=-Imax;
    end
    
    %compute the charge removed
    CR=CR_prev+(dT*I)/3600;                        
   
end

%Calculate the current charge removed for all of the other steps in the
%drive cycle
if ind>1
    if P_reqd>=0 && DoD_prev<.99
        I=single((E-(E^2-(4*Rin*P_reqd))^.5)/(2*Rin));
%current taken out of the battery
    elseif P_reqd>=0 && DoD_prev>=.99
        I=0;  %no current can be taken out of an empty battery
    elseif P_reqd<0 && DoD_prev>0
        I=(-E+(E^2+(4*Rin*P_reqd))^.5)/(2*Rin); %current put into the battery
    elseif P_reqd<0 && DoD_prev<=0
        I=0;  %current can't be put into a full battery
    end
    
    %Limit the current to the maximum current
    if I>=Imax && I>=0
        I=Imax;
    elseif I<-Imax && I<0
        I=-Imax;
    end    
    
    %compute the charge removed
    
    CR=CR_prev+(dT*I)/3600;   
end

%Compute the depth of discharge
DoD=CR/Capacity;

%[P_reqd CR_prev E I CR DoD_prev]
%[E I CR DoD]

%Limit the DoD
if DoD>1
    DoD=1;  %the battery can't be more than fully discharged
elseif DoD<0
    DoD=0;  %the battery can't be more than fully charged
end

%Compute the voltage
V=E-I*Rin;

%Calculate the power supplied by the battery
P_supp=I*V;
