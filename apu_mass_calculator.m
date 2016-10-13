function [apu_mass,P_fc_max]=apu_mass_calculator(apu_selection,number_fc_modules)

if apu_selection == 1
    fc_specs_3_schunk_fc_42;
    apu_mass=single(fc_module_mass*number_fc_modules);
    P_fc_max=single(P_fc_module_max*number_fc_modules);
elseif apu_selection==2
    fc_specs_3_horizon_h_4000;
    apu_mass=fc_module_mass*number_fc_modules;
    P_fc_max=P_fc_module_max*number_fc_modules;
elseif apu_selection==3
    fc_specs_3_horizon_h_5000;
    apu_mass=fc_module_mass*number_fc_modules;
    P_fc_max=P_fc_module_max*number_fc_modules;
end

