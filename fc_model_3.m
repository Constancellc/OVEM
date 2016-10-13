function [P_supp,I_supp,H2_used,c]=fc_model_3(P_reqd,P_vector,I_vector,...
    P_fc_module_max,number_fc_modules,cells_per_module)

%Purpose: Test level 3 fuel cell model

%Scale Power vector by the number of cells
P_vector=P_vector*number_fc_modules;
P_fc_max=P_fc_module_max*number_fc_modules;

%Limit power requests to the maximum amount of power that the fuel cell can
%produce
if P_reqd > P_fc_max
    P_reqd=P_fc_max;
    P_supp=P_reqd;
%Eliminate negative power requests because its a fuel cell and it can't
%accept charge
elseif P_reqd<0
    P_reqd=0;
    P_supp=0;
%If the power request is within the range the fc can provide and greater
%than or equal to zero then the fc produces it
else
    %P_reqd=P_reqd;
    P_supp=P_reqd;
end

%% Take a positive power request and then interpolate to find the lowest
%corresponding current
for i=1:length(P_vector)-1;
    if P_reqd <= P_vector(i+1) && P_reqd >= P_vector(i);
        m=(I_vector(i+1)-I_vector(i))/(P_vector(i+1)-P_vector(i));
        b=I_vector(i)-m*P_vector(i);
        I_supp=m*P_reqd+b;
    else
    end
end
c=1;
% [x,c] = min(abs(single(P_reqd-P_vector)));
% I_supp = I_vector(c);
%%

%Based on the amount of current supplied the amount of H2 used is
%calculated.  Note this stoichiometric hydrogen usage and it also does not
%account for powering peripherals
H2_used=single(1.05e-8*I_supp*cells_per_module*number_fc_modules); %kg/s


