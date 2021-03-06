function [abs_veh_stock,out] = diff_curve2(growth,prob_tot,years,dynamic_scrap,...
    growth_damping,invest_mat)

%Technology Model_with Mixed logit Version 2/M_Tran/July 11_2011

%Steps:
%1.Run mixedlogit V.7 - calculates moving average probabilities for each
%technology type: a) specify vehicle attributes, b) specify probability
%distributions, c) specify number of random draws

%2. Run Vehicle Stock Model

%Initialize total vehicle stock

TVS_0 = 28411096; %24405548;           %TVS in yr2000 = 24405548, based on DfT 2006 data
                                       %note: add 4005548 on TVS_0 to account for scrappage rate in first year =
                                       %better matches actual data for DfT for year 2000=24405548

%Initialize individual technology stock

PET_0 = .870*TVS_0;         %ICE Petrol (DfT,2006)
DIE_0 = .129*TVS_0;         %ICE Diesel (DfT,2006)
HEV_0 = .0007*TVS_0;        %Hybrid Electric (DfT, 2006: remaining 0.1 % split b/w HEV, PHEV, EV, FC)
PHEV_0 = .0001*TVS_0;       %Plug-in hybrid electric
EV_0 = .0001*TVS_0;         %Electric Vehicle
FC_0 = .0001*TVS_0;         %Fuel Cell

%% Initialize growth parameter and scrappage

%r = 0.014;                  %r=rate of growth per year (1.4%)in total vehicle stock based on average from 2000-2050 UKTCM reference case; Note: Dft 2008 b/w 1999 - 2008 average annual growth is 1.84%

%Time vector
%time = 2000:2050;
                    
Ppet1 = prob_tot(:,1);
Pdie1 = prob_tot(:,2);
Phyb1 = prob_tot(:,3);
Pphyb1 = prob_tot(:,4);
Pev1 = prob_tot(:,5);
Pfc1 = prob_tot(:,6);

TVS = zeros(years,1);
TVSp = TVS;
TVSd = TVS;
TVSh = TVS;
TVSph= TVS;   
TVSe= TVS;
TVSf = TVS;
%abs_veh_stock = zeros(years,6);

%growth = 1.0185;

if dynamic_scrap == 1; 
    scrap = 1;
else
    scrap = 0.87; 
end

TVS = TVS_0 .* growth.^(0:1:years-1).*scrap;
%% 
% for i=1:length(TVS)
%     vs_growth(i,:) = prob_tot(i,:) * TVS(i);
% end
% 
% TVSp = vs_growth(:,1);
% TVSd = vs_growth(:,2);
% TVSh = vs_growth(:,3);
% TVSph = vs_growth(:,4);
% TVSe = vs_growth(:,5);
% TVSf = vs_growth(:,6);

%% Calculate scrappage of each technology introduced in year i + previous years
if growth_damping == 1;
    growth_rate = [1.014 1.08 1.15 1.15 1.10 1.10];
else
    growth_rate = ones(1,6);
end

growth_rate = growth_rate -1;

for i=1:years   
    if i==1
        TVSp(i) = PET_0;
        TVSd(i) = DIE_0;
        TVSh(i) = HEV_0;
        TVSph(i) = PHEV_0;
        TVSe(i) = EV_0;
        TVSf(i) = FC_0;

    else

%         TVSp(i) = (TVSp(i-1) + TVSp(i-1)*((growth_rate(1)+(1+invest_mat(i,1)))))*scrap*Ppet1(i);
%         TVSd(i) = (TVSd(i-1) + TVSd(i-1)*((growth_rate(2)+(1+invest_mat(i,2)))))*scrap*Pdie1(i);
%         TVSh(i) = (TVSh(i-1) + TVSh(i-1)*((growth_rate(3)+(1+invest_mat(i,3)))))*scrap*Phyb1(i);
%         TVSph(i) = (TVSph(i-1) + TVSph(i-1)*((growth_rate(4)+(1+invest_mat(i,4)))))*scrap*Pphyb1(i);
%         TVSe(i) = (TVSe(i-1) + TVSe(i-1)*((growth_rate(5)+(1+invest_mat(i,5)))))*scrap*Pev1(i);
%         TVSf(i) = (TVSf(i-1) + TVSf(i-1)*((growth_rate(6)+(1+invest_mat(i,6)))))*scrap*Pfc1(i);

        TVSp(i) = TVSp(i-1)*scrap + TVSp(i-1)*(growth_rate(1)+invest_mat(i,1))*Ppet1(i);
        TVSd(i) = TVSd(i-1)*scrap + TVSd(i-1)*(growth_rate(2)+invest_mat(i,2))*Pdie1(i);
        TVSh(i) = TVSh(i-1)*scrap + TVSh(i-1)*(growth_rate(3)+invest_mat(i,3))*Phyb1(i);
        TVSph(i) = TVSph(i-1)*scrap + TVSph(i-1)*(growth_rate(4)+invest_mat(i,4))*Pphyb1(i);
        TVSe(i) = TVSe(i-1)*scrap + TVSe(i-1)*(growth_rate(5)+invest_mat(i,5))*Pev1(i);
        TVSf(i) = TVSf(i-1)*scrap + TVSf(i-1)*(growth_rate(6)+invest_mat(i,6))*Pfc1(i);

   end
    
    %Calculate different growth rates for each technology; %Note: technology growth rates in green are baseline rates calibrated to DfT(2008)Note: can also set negative growth rates    
%    TVSp(i) = (PET_0*(growth_rate(1)+(1+invest_mat(i,1)))^(i-1))*(scrap)* Ppet1(i);         
%     TVSd(i) = (DIE_0*(growth_rate(2)+(1+invest_mat(i,2)))^(i-1))*(scrap)* Pdie1(i);     
%     TVSh(i) = (HEV_0*(growth_rate(3)+(1+invest_mat(i,3)))^(i-1))*(scrap)* Phyb1(i);      
%     TVSph(i)= (PHEV_0*(growth_rate(4)+(1+invest_mat(i,4)))^(i-1))*(scrap)* Pphyb1(i);   
%     TVSe(i) = (EV_0*(growth_rate(5)+(1+invest_mat(i,5)))^(i-1))*(scrap)* Pev1(i);         
%     TVSf(i) = (FC_0*(growth_rate(6)+(1+invest_mat(i,6)))^(i-1))*(scrap)* Pfc1(i);    

% 
% PET_0
% growth_rate(1)
% (1+invest_mat(:,1)).^(0:1:years-1)'
% (scrap)
% Ppet1 

% TVSp = PET_0*(growth_rate(1).*(1+invest_mat(:,1))).^(0:1:years-1).*(scrap).* Ppet1;  
% TVSd = DIE_0*(growth_rate(2).*(1+invest_mat(:,2))).^(0:1:years-1).*(scrap).* Pdie1;  
% TVSh = HEV_0*(growth_rate(3).*(1+invest_mat(:,3))).^(0:1:years-1).*(scrap).* Phyb1;  
% TVSph = PHEV_0*(growth_rate(4).*(1+invest_mat(:,4))).^(0:1:years-1).*(scrap).* Pphyb1;  
% TVSe = EV_0*(growth_rate(5).*(1+invest_mat(:,5))).^(0:1:years-1).*(scrap).* Pev1;  
% TVSf = FC_0*(growth_rate(6).*(1+invest_mat(:,6))).^(0:1:years-1).*(scrap).* Pfc1;  

end
               %scrap=scrappage rate of vehicle stock per year (14.5%) based on vehicle age distribution average calculated from 1999-2008 DfT data (See VSM_1)

               
for i=1:years
         norm = TVS(i)/(TVSp(i) + TVSd(i) + TVSh(i) + TVSph(i) + TVSe(i) + TVSf(i));  
        
         TVSp(i) = TVSp(i)*norm;
         TVSd(i) = TVSd(i)*norm;
         TVSh(i) = TVSh(i)*norm;
         TVSph(i)= TVSph(i)*norm;
         TVSe(i) = TVSe(i)*norm;
         TVSf(i) = TVSf(i)*norm;               
end

%Test output differences: Out1:without probabilities; Out: with probabilities
%out1 = [TVS1; TVSp1; TVSd1; TVSh1; TVSph1; TVSe1; TVSf1]'%without probability 
out = [TVS' TVSp TVSd TVSh TVSph TVSe TVSf]; %with probability
abs_veh_stock = [zeros(1,6); out(2:end,2:end)-out(1:end-1,2:end)];

[r,c] = size(abs_veh_stock);
for i=1:r
    for j=1:c
        if abs_veh_stock(i,j)<0;
            abs_veh_stock(i,j)=0;
        else
        end
    end
end
