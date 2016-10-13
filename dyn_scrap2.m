function [net_tvs,scrap_tvs,total_mj,total_co2] = dyn_scrap2(new_tvs)

%   new_tvs = 10^7*[    2.8411    2.5813    0.2592    0.0000    0.0000    0.0006    0.0000
%     2.8937    2.6275    0.2655    0.0000    0.0000    0.0006    0.0000
%     2.9472    2.6628    0.2837    0.0000    0.0000    0.0007    0.0000
%     3.0017    2.7035    0.2973    0.0000    0.0000    0.0009    0.0001
%     3.0573    2.7641    0.2922    0.0000    0.0000    0.0009    0.0001
%     3.1138    2.7666    0.3461    0.0000    0.0000    0.0010    0.0001
%     3.1714    2.7998    0.3705    0.0000    0.0000    0.0011    0.0001
%     3.2301    2.8483    0.3805    0.0000    0.0000    0.0012    0.0001
%     3.2899    2.8579    0.4305    0.0000    0.0000    0.0014    0.0001
%     3.3507    2.8697    0.4794    0.0000    0.0000    0.0015    0.0001
%     3.4127    2.9253    0.4857    0.0000    0.0000    0.0016    0.0001
%     3.4758    3.0053    0.4687    0.0000    0.0000    0.0017    0.0001
%     3.5401    2.8974    0.6405    0.0000    0.0000    0.0021    0.0001
%     3.6056    2.9473    0.6563    0.0000    0.0000    0.0019    0.0001
%     3.6723    3.0234    0.6467    0.0000    0.0000    0.0021    0.0001
%     3.7403    2.9802    0.7575    0.0000    0.0000    0.0025    0.0002
%     3.8095    2.9882    0.8184    0.0000    0.0000    0.0027    0.0002
%     3.8799    3.1181    0.7588    0.0000    0.0000    0.0029    0.0002
%     3.9517    3.0683    0.8802    0.0000    0.0000    0.0030    0.0002
%     4.0248    3.1387    0.8827    0.0000    0.0000    0.0032    0.0002
%     4.0993    3.0627    1.0331    0.0000    0.0000    0.0033    0.0002
%     4.1751    2.9960    1.1748    0.0000    0.0000    0.0041    0.0002
%     4.2524    3.0462    1.2014    0.0000    0.0000    0.0045    0.0003
%     4.3310    2.9678    1.3585    0.0000    0.0000    0.0044    0.0003
%     4.4112    3.0964    1.3098    0.0000    0.0000    0.0047    0.0003
%     4.4928    2.9333    1.5534    0.0000    0.0000    0.0058    0.0003
%     4.5759    2.9399    1.6299    0.0000    0.0000    0.0056    0.0004
%     4.6605    3.1740    1.4793    0.0000    0.0000    0.0069    0.0003
%     4.7468    3.0314    1.7085    0.0000    0.0000    0.0064    0.0004
%     4.8346    2.9701    1.8565    0.0000    0.0000    0.0076    0.0004
%     4.9240    2.9576    1.9582    0.0000    0.0000    0.0077    0.0005
%     5.0151    2.8485    2.1577    0.0000    0.0000    0.0084    0.0005
%     5.1079    2.9624    2.1359    0.0000    0.0000    0.0091    0.0005
%     5.2024    2.8210    2.3710    0.0000    0.0000    0.0098    0.0005
%     5.2986    2.8704    2.4166    0.0000    0.0000    0.0110    0.0006
%     5.3966    2.8250    2.5610    0.0000    0.0000    0.0101    0.0006
%     5.4965    2.8446    2.6393    0.0000    0.0000    0.0119    0.0007
%     5.5982    2.5893    2.9954    0.0000    0.0000    0.0128    0.0007
%     5.7017    2.7306    2.9555    0.0000    0.0000    0.0149    0.0008
%     5.8072    2.5514    3.2412    0.0000    0.0000    0.0138    0.0008
%     5.9147    2.4520    3.4455    0.0000    0.0000    0.0163    0.0009
%     6.0241    2.3709    3.6365    0.0000    0.0000    0.0158    0.0009
%     6.1355    2.6806    3.4366    0.0000    0.0000    0.0173    0.0009
%     6.2490    2.3226    3.9059    0.0000    0.0000    0.0195    0.0010
%     6.3646    2.2907    4.0515    0.0000    0.0000    0.0214    0.0011
%     6.4824    2.0468    4.4147    0.0000    0.0000    0.0199    0.0010
%     6.6023    2.1102    4.4693    0.0000    0.0000    0.0217    0.0011
%     6.7244    1.9705    4.7287    0.0000    0.0000    0.0240    0.0012
%     6.8488    2.1893    4.6319    0.0000    0.0000    0.0263    0.0013
%     6.9756    2.1728    4.7744    0.0000    0.0000    0.0269    0.0014];
% %     7.1046    2.2439    4.8283    0.0000    0.0000    0.0306    0.0018
% %     7.2360    2.1351    5.0679    0.0000    0.0000    0.0311    0.0020
% %     7.3699    1.9993    5.3325    0.0000    0.0000    0.0363    0.0018
% %     7.5062    2.0653    5.4036    0.0000    0.0000    0.0351    0.0022
% %     7.6451    1.9135    5.6900    0.0000    0.0000    0.0395    0.0021];
% 
% 
% ce_norm = [164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0
%   164.6780  150.5315   86.2811   91.2962         0         0];
% 
% mj_per_km = [241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397
%   241.9208  217.1690  128.9593  136.4550   56.3345  126.4397];
% 
% annual_km_per_veh = 1.0e+004 *[1.3115
%     1.3128
%     1.3439
%     1.3428
%     1.3417
%     1.3658
%     1.3618
%     1.4057
%     1.3962
%     1.4801
%     1.5157
%     1.5252
%     1.5283
%     1.5242
%     1.4176
%     1.3579
%     1.3502
%     1.3156
%     1.2968
%     1.2802
%     1.2646
%     1.2680
%     1.2534
%     1.2474
%     1.2413
%     1.2350
%     1.2285
%     1.2218
%     1.2150
%     1.2080
%     1.2009
%     1.1936
%     1.1862
%     1.1786
%     1.1710
%     1.1632
%     1.1554
%     1.1474
%     1.1393
%     1.1312
%     1.1230
%     1.1147
%     1.1063
%     1.0979
%     1.0894
%     1.0809
%     1.0723
%     1.0636
%     1.0550
%     1.0462];
% 
% ra = [1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050
%     1.0000    1.0000    1.0000    0.0100    0.0100    0.0050];

%%
% Year of first registration, percentage remaining on the road in 2006 
%(DfT Table 17)
per_scrap = [1980 	1
1981 	1
1982 	1
1983 	1
1984 	1
1985 	2
1986 	2
1987 	3
1988 	5
1989 	8
1990 	13
1991 	18
1992 	26
1993 	39
1994 	51
1995 	62
1996 	72
1997 	80
1998 	84
1999 	88
2000 	90
2001 	92
2002 	93
2003 	94
2004 	95
2005 	95
2006 	95];%changed from 94 to maintain increase

%new_tvs = new_tvs(1:25,:);
new_tvs = new_tvs(:,2:end);

if length(new_tvs)>length(per_scrap)
    new_per_scrap_rate = [per_scrap(1,2)*ones((length(new_tvs)-length(per_scrap)),1); per_scrap(:,2)];
else
    new_per_scrap_rate = per_scrap(:,2);
end

[~,c] = size(new_tvs);
scrap_tvs = zeros(size(new_tvs));
total_mj = scrap_tvs;
total_co2 = scrap_tvs;

for i=1:c
    [scrap_tvs(:,i)] = find_scrap(new_tvs(:,i),new_per_scrap_rate);
end

net_tvs = new_tvs - scrap_tvs;

% figure(10)
% plot(new_tvs)
% hold on
% plot(sum(new_tvs,2),'k')
% hold on
% plot(net_tvs,':')
% hold on
% plot(sum(net_tvs,2),'k:');
% hold off
% 
% figure(12)
% plot(scrap_tvs)
% hold on
% plot(sum(scrap_tvs,2),'k:')
% hold off

% figure(11)
% plot(total_mj)
% hold on
% plot(sum(total_mj,2),'k:')
% hold off

% 
% time = [2000:1:2000+length(new_tvs)-1]';
% time = [time time time time time time];
% 
% figure(7)
% % plot(time(:,1),sum(scrap_tvs,2),'k--','MarkerSize',8,'LineWidth',2)
% % hold on
% plot(time,scrap_tvs,'MarkerSize',8,'LineWidth',2)
% legend('Total Scrapped Stock','Petrol','Diesel','Hybrid Petrol','Plugin Hybrid','Battery Electric','Fuel Cell')
% xlabel('Years')
% ylabel('Total scrapped vehicles per technology')
% hold off