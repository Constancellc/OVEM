function [pet,die,ele] = fuel_prices(start_year,end_year)
years = start_year:1:end_year-1;

petrol = [2000	80 60.7 76 	%Year, total fuel price, Tax , % tax from DfT TSGB 2010 env0105
2001	 75.9 57.1 75	 
2002	 75 57 76	
2003	 78.2 57.5 73	 
2004	 77.8 58.7 75	 
2005	 85.4 59.8 70	 
2006	 94.1 61.1 65	 
2007	 91.9 62 67
2008	 107.6 66.4 62	 
2009	 93.6 66.4 71	 
2010	 119.8 75 63];	 	 

diesel = [2000	81.1 60.9  75 	%Year, total fuel price, Tax,  % tax from DfT TSGB 2010 env0105
2001	 77.3 57.3 74	 
2002	 76.9 57.3 74	
2003	 80.9 57.9 72	 
2004	 79.2 58.9 74	 
2005	 89.6 60.4 67	 
2006	 97.6 61.6 63	 
2007	 94.7 62.5 66
2008	 116.6 67.7 58	 
2009	 101.9 67.5 66	 
2010	 121.0 75.2 62];	

elec = [2000	.1056 	%Year, �/kWh from Eurostat table ten00115
2001	 .0996	 
2002	 .1031	
2003	 .0959	 
2004	 .0837	 
2005	 .0836	 
2006	 .0971	 
2007	 .1254
2008	 .1394	 
2009	 .1399 
2010	 .1321];	

% pet = petrol(:,2);
% die = diesel(:,2);
% ele = elec(:,2);

die_coeff = polyfit(diesel(:,1),diesel(:,2),2); %total fuel price
die_line = polyval(die_coeff,years);

pet_coeff = polyfit(petrol(:,1),petrol(:,2),2); %total fuel price
pet_line = polyval(pet_coeff,years);

ele_coeff = polyfit(elec(:,1),elec(:,2),2);
ele_line = polyval(ele_coeff,years);

upper_fuel_price = 10*petrol(end,2); %p/l
upper_elec_price = 10*elec(end,2);%�/kWh

for i=1:length(pet_line)
    if pet_line(i)>upper_fuel_price;
        pet_line(i)=upper_fuel_price;
    else
    end
    
      if die_line(i)>upper_fuel_price;
        die_line(i)=upper_fuel_price;
    else
      end
      
      if ele_line(i)>upper_elec_price;
        ele_line(i)=upper_elec_price;
    else
      end
end
    
% 
% figure(4)
% plot(elec(:,1),elec(:,2))
% hold on
% plot(years,ele_line,':')
% hold off
% 
% figure(6)
% plot(petrol(:,1),[petrol(:,2) diesel(:,2)])
% hold on
% plot([years years],[pet_line die_line],':')
% legend('Petrol','Diesel')
% hold off

pet = pet_line;
die = die_line;
ele = ele_line;