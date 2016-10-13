function [batt_kwh,NoCells_ESS1,NoCells_ESS2,NoCells_ESS1_par,NoCells_ESS1_ser] ...
    = make_batt(ESS1_selection,~,batt_V,batt_cap)


%% Select battery to use
if ESS1_selection==1      %AltairNano, 50 Ah
    batt_specs_3_altairnano_50_Ah;
    
elseif ESS1_selection==2  %PowerGenix PGX 2000 sub C
    batt_specs_3_powergenix_2000_subC;
    
elseif ESS1_selection==3  %A123 ANR26650
    batt_specs_3_a123_ANR26650;
    
elseif ESS1_selection==4 %PowerGenix PGX 2000 aa
    batt_specs_3_powergenix_1500_aa;
    
elseif ESS1_selection==5
    batt_specs_3_altairnano_11_Ah; %AltairNano, 11 Ah
    
elseif ESS1_selection==6
    batt_specs_3_exide_5epzb325; %Exide 5EPzB325
    
elseif ESS1_selection==7
    batt_specs_3_saft_NHE_NiMH; %SAFT NHE NiMH
        
elseif ESS1_selection==8
    batt_specs_3_exide_9epzb585; %Exide 9EPzB585
    
elseif ESS1_selection==9
    batt_specs_3_LiFeBATT_40166; %LiFEBATT X-2E 15 Ah 40166 
  
elseif ESS1_selection==10
    batt_specs_3_greensaver_sp_36_12;

else 
    batt_specs_3_bostonpower_swing4400;
  
end
%% Series pack

% ser_cells = round(batt_V/Eo);
% par_cells = 1;
% %ser_cells = round(batt_cap/3.6*1000/Eo/Q)
% 
% NoCells_ESS1_par = par_cells;
% NoCells_ESS1_ser = ser_cells;
% NoCells_ESS2 = 0;
% NoCells_ESS1 = round(par_cells * ser_cells);

%% Series-parallel pack

ser_cells = round(batt_V/Eo);
string_kwh = ser_cells * Eo * Q/1000;
par_cells = single((batt_cap/3.6)/string_kwh);%max([1 round((batt_cap/3.6)/string_kwh)]);

NoCells_ESS1 = round(par_cells * ser_cells);
NoCells_ESS1_par = par_cells;
NoCells_ESS1_ser = ser_cells;
NoCells_ESS2 = 0;

batt_kwh = NoCells_ESS1 * Eo * Q/1000;