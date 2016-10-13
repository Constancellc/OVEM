function [cost_hi, cost_lo] = ess_cost2(pack_size,batt_cost_kwh)
%% Scope
% Aim: This function receives the total energy in kWh that the ess must deliver
%over the drive cycle in a level_2 simulation and returns the cost premium (Euro)
%range based on assumed pricing for lead acid at the minimum and lithium ion at the high end.
%This premium is added to the base model or incumbent vehicle price

% Cell technologies include: lead acid, nickel cadmium, lithium ion and
% nickel zinc, ultracapacitors and flywheels

%Cost per technologies taken from "Battery energy storage technology for
%power systems - an overview", EPSR vol 79 iss 4 Apr 2009 KC Divya & J
%Ostergaard:
%lead acid 50-150 euro/kWh; NiCd 200-600 euro/kWh; LiIon 700-1000 euro/kWh 

%NiMH and NiZn cells are chosen to cost the same as NiCd and LiIon
%respectively, while ultracapacitors cost the same as LiIon and flywheels
%the same as NiCd

% Created 26 October 2009 (Justin Bishop)

%% Function

min_ess_cost = 50; %€/kWh
max_ess_cost = 1000;

cost_premium_min = pack_size* min_ess_cost;
cost_premium_max = pack_size* batt_cost_kwh;

cost_hi = cost_premium_max;
cost_lo = cost_premium_min;