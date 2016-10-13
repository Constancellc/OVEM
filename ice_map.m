function [xgrid,ygrid,zgrid] = ice_map(data)
 
%% Proportional
data(:,1) = data(:,1)/max(data(:,1));
data(:,2) = data(:,2)/max(data(:,2));
data(:,3) = data(:,3)*100;

max_t = max(data(:,2));
min_t = min(data(:,2));
max_w = max(data(:,1));
min_w = min(data(:,1));
% max_e = max(data(:,3));
% min_e = min(data(:,3));

t_vec = linspace(min_t,max_t,100);
w_vec = linspace(min_w,max_w,100);
%e_vec = linspace(min_e,max_e,100);

%[~,w] = meshgrid(t_vec,w_vec);

[zgrid,xgrid,ygrid] = gridfit(data(:,1),data(:,2),data(:,3),w_vec,t_vec,'extend','never');

%eff_vec = linspace(min_e,max_e,5);
%zgrid = zgrid;
% figure(1)
%  C =contour(xgrid,ygrid,zgrid);
% clabel(C)
% xlabel('Speed (RPM)')
% ylabel('Torque (Nm)')
% hold off