function ele_maps

[xgrid1,ygrid1,zgrid1] = ice_map(ele1);

figure(1)
C =contour(xgrid1,ygrid1,zgrid1);
hold on
clabel(C)
xlabel('Speed (RPM)')
ylabel('Torque (Nm)')
xlim([0 1])
ylim([0 1])
hold off

%% Median
 med_zgrid = zeros(size(zgrid1));
% for i=1:length(zgrid1);
%     med_zgrid(i,:) = median([zgrid1(i,:);zgrid2(i,:);zgrid3(i,:);zgrid4(i,:);zgrid5(i,:);zgrid6(i,:);zgrid7(i,:)]);
% end

figure(2)
C =contour(xgrid1,ygrid1,zgrid1);
clabel(C)
xlabel('Speed (RPM)')
ylabel('Torque (Nm)')
xlim([0 1])
ylim([0 1])
hold off

xlswrite('C:\Users\Chris\Documents\Justin\OVEM\ele_map',zgrid1);
