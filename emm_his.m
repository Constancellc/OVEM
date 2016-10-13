function total_co2 = emm_his(out,annual_km_per_veh,km_prop,ce)

%data = [76.2	76.0	77.2	75.9	76.3	75.4	75.0	74.4	72.1; %Mt CO2 from DfT TSGB table ENV0202
%2000 2001 2002 2003 2004 2005 2006 2007 2008];

total_co2 = zeros(length(annual_km_per_veh),1);

for i=1:length(annual_km_per_veh)
    total_co2(i) = (km_prop(i,:)*annual_km_per_veh(i)).*out(i,:)*ce(i,:)';
end

