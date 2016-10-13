function [v_req,t,slope,distance_req,distance_req_alt,timestep,drive_cycle_name,...
    drive_cycle_length]=drive_cycle_3(drive_cycle_selection,number_of_drive_cycles)

% Title: drive_cycle_3
%
% Author: Reed Doucette
% Created: May 18, 2009
%
% Modified: XX October 2016
% by: Constance Crozier
%
% Purpose: To output the drive cycle for the simulation to use.  The v here
% represents the requested velocity.
%
% List of Inputs:
%       drive_cycle_selection:
%           A positive integer that denotes which drive cycle was selected
%       number_of_drive_cycles: ...1?
%
% List of Outputs:
%       v_req:
%           the requested velocity of the drive cycle
%       t:
%           the time vector of the drive cycle
%       timestep: 
%           the time interval for the drive cycle
%       drive_cycle_name:
%           the string name of the drive cycle
%       drive_cycle_length:
%           the length of the drive cycle array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Output the correct parameters based on the drive cycle selected

dc_names = {'NEDC','Artemis','FUDS','NYCC','US06','US HWFET','US EPA'};
dc_files = {'CYC_nedc.mat','CYC_artemis_combined.mat','CYC_fuds.mat',...
    'CYC_nycc.mat','CYC_us06.mat','CYC_hwfet.mat',...
    'CYC_epa_combined_city_hwy.mat'};

load(char(dc_files(drive_cycle_selection)))

%Extract the speed (mph) from the drive cycle array and convert to m/s
v_req=cyc_mph(:,2)*.44704;

%Extract the time (sec) entries from the drive cycle array
time=cyc_mph(:,1);

%Assign name
drive_cycle_name=dc_names(drive_cycle_selection);

% t is a vector containing the time 
% (We should check all drive cycles have regular time intervals later)
timestep = time(2)-time(1);
t = time(1):timestep:max(time)*number_of_drive_cycles;

% Establish slope pattern of the drive cycle

% distance_req contains the distances of the vehicle from the start point
% at each timestep.
distance_req=zeros(length(v_req)-1,1);
distance_req(1)=trapz([t(1) t(2)],[v_req(1) v_req(2)]);

for i=2:length(v_req)-1
    distance_req(i)=trapz([t(i) t(i+1)],[v_req(i) v_req(i+1)])+distance_req(i-1);
end

% Need to eliminate repeating values in the distance_req vector in order
% for interpolation to work properly in the vehicle_backwards_3 block
distance_req_alt(1)=distance_req(1);
h_count=1;

for i = 2:length(distance_req)
    if distance_req(i)~=distance_req_alt(h_count)
        distance_req_alt(h_count+1)=distance_req(i);
        h_count = h_count+ 1;
    end
end

%Enter in slope parameter if the drive cycle does not have one (slope
%needs to be in radians)
slope=zeros(1,length(distance_req_alt));

%Establish the length of the drive cycle array
drive_cycle_length=length(v_req);
    