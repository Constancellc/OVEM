function total_mj = ene_his(out,annual_km_per_veh,km_prop,mj_per_km,new_tvs,scrap_vec)

%%
%data = [20.1	19.8	19.7	18.9	18.6	17.9	17.3	16.7	15.9;%Mtoe from DfT TSGB table ENV0101 years 2000-8; 1 toe = 41868 MJ
%2000 2001 2002 2003 2004 2005 2006 2007 2008];

total_mj = zeros(length(annual_km_per_veh),1);
%



% km_prop*annual_km_per_veh(1)
% out(1,:)
% km_prop*annual_km_per_veh(1).*out(1,:).*mj_per_km(1,:)
% 
% sum((km_prop*annual_km_per_veh(1).*out(1,:).*mj_per_km(1,:)))/10^5
%%


for i=1:length(annual_km_per_veh)
    total_mj(i) = (km_prop(i,:)*annual_km_per_veh(i)).*out(i,:)*mj_per_km(i,:)';
end
