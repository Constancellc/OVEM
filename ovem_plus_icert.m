[pp,fc,per,fnc,ce,ra,fc_wtw,ce_wtw,batt_cap,mj_per_km,prob_tot,elec_co2_per_kwh1,...
    dynamic_scrap,out,mixed_logit,growth_damping,tvs_growth_rate,start_year,...
    end_year,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra] = icert_cons_pref1;

[pp1,fc1,per1,fnc1,ce1,ra1,fc_wtw1,ce_wtw1,prob_tot_with_policy] = ...
    icert_policy1(pp,fc,per,fnc,ce,ra,fc_wtw,ce_wtw,batt_cap,prob_tot,...
    elec_co2_per_kwh1,dynamic_scrap,out,mixed_logit,growth_damping,...
    tvs_growth_rate,start_year,end_year,b_pp,b_fc,b_per,b_fnc,b_ce,b_ra);

isequal(pp,pp1);
isequal(fc,fc1);
isequal(per,per1);
isequal(fnc,fnc1);
isequal(ce,ce1);
isequal(ra,ra1);
isequal(fc_wtw,fc_wtw1);
isequal(ce_wtw,ce_wtw1);
isequal(prob_tot,prob_tot_with_policy);

