function [ESS_mass,ESS_Capacity,ESS_energy,ESS_power]=ESS_mass_calculator(ESS_selection,NoCells)

%Title: battery_mass
%
%Author: Reed Doucette
%
%Created: May 18, 2009
%
%Purpose: To calculate the mass of the ESS.
%
%List of Inputs:
%       ESS_selection:
%           A positive integer that specifies the ESS chosen
%       NoCells:
%           The number of cells of that particular ESS that have been
%           chosen for this application
%
%List of Outputs:
%       ESS_mass:
%           The mass of the entire ESS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Specificy the ESS chosen, all masses are in kg

ESS_energy=0;   %Temporary until I update all of the data files
ESS_power=0;    %Temporary until I update all of the data files
if ESS_selection==0
    cell_mass=0;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=0;
elseif ESS_selection==1        %AltairNano, 50 Ah
    batt_specs_3_altairnano_50_Ah;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==2    %PowerGenix PGX 2000 sub C
    batt_specs_3_powergenix_2000_subC;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==3    %A123 ANR26650
    batt_specs_3_a123_ANR26650;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==4    %PowerGenix PGX 2000 aa
    batt_specs_3_powergenix_1500_aa;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==5    %Altair nano 11 Ah
    batt_specs_3_altairnano_11_Ah;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==6     %Exide 5EPzB 325
    batt_specs_3_exide_5epzb325;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==7     %Saft NHE NiMH
    batt_specs_3_saft_NHE_NiMH;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==8
    batt_specs_3_exide_9epzb585;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==10
    batt_specs_3_greensaver_sp_36_12;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
elseif ESS_selection==11
    batt_specs_3_bostonpower_swing4400;
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Capacity;
    
elseif ESS_selection==101
    ucap_specs_3_maxwell_350F;  %Maxwell BCAP 0350 F
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Max_Capacity;
    ESS_energy=energy_density*NoCells;
    ESS_power=power_density*NoCells;
elseif ESS_selection==102
    ucap_specs_3_maxwell_650F;  %Maxwell BCAP 0650 F
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Max_Capacity;
    ESS_energy=energy_density*NoCells;
    ESS_power=power_density*NoCells;
elseif ESS_selection==103
    ucap_specs_3_maxwell_2000F; %Maxwell BCAP 2000 F
    ESS_mass=cell_mass*NoCells;
    ESS_Capacity=Max_Capacity;
    ESS_energy=energy_density*NoCells;
    ESS_power=power_density*NoCells;
elseif ESS_selection==104
    ucap_specs_3_maxwell_3000F; %Maxwell BCAP 3000 F   
    ESS_mass=cell_mass*NoCells; 
    ESS_Capacity=Max_Capacity;
    ESS_energy=energy_density*NoCells;
    ESS_power=power_density*NoCells;
end


 