% nissan leaf

global SPD
%SPD=[S P D] 
% S=SMMT Category   2=m, 3=sm, 4=lm, 5=um, 6=e, 7=ls, 8=ss, 9=dp, 10=mpv
% P=powertrain      2=ice, 3=hybrid, 4=ev
% D=drivecycle      2=NEDC, 3=Artemis, 4=FUDS, 5=NYCC, 6=US06, 7=US HWFET, 8=US EPA 
global VP
% VP=[dc fa kw wd td tr]
% dc=drag
% fa=frontal area
% kw=weight
% wd=wheel drive
% td=tyre diameter
% tr=tyre rolling resistance
global PS
% PS=[ht et ft tc]
% ht=hybrid type, 1=series, 2=dual, 3=plugin
% et=engine type (fuel cell or IC), in IC set to 3, in EV set to 2
% ft=fuel type, 1=petrol, 0=diesel, 2=EV
% tc=turbocharged, 1=tc, 0=not tc, 2=EV
global EP
% EP=[es et ep]
% es=engine size, in EV set to 2
% et=engien torque, in EV set to 2
% ep=engine power, in EV set to 2
global MP
% MP=[mp mt me]
% mp=motor power, in IC set to 3
% mt=motor torque, in IC set to 3
% me=motor efficiency, in IC set to 3
global T
% T=[gbt gbs tgr fgr gbe axe]
% gbt=gearbox type
% gbs=gearbox speed
% tgr=top gear ratio
% fgr=final gear ratio
% gbe=gearbox efficiency
% axe=axle efficiency
global VR
% VR=[rng reg ref]
% rng=user desired range
% reg=makes use of regeneration or not
% ref=regeneration efficiency

SPD = [3 4 8];
VP = [0.28 0.725 1521 2 16 0.0099];
PS = [0 2 2 2];
EP = [2 2 2];
MP = [80 280 0.95];
T=[2 2 2 2 2 2];
VR = [100 0 0];

[pp,fc,per,fnc,ce,ra,fc_wtw,ce_wtw,med_batt_cap,mj_km] = ovem31_cc 