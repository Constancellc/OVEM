%File containing the characteristic parameters for the Automotive Energy
%Supply Corporation EV Battery
%NOT FINISHED!
%Created: November 1, 2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Eo, battery constant voltage (V)
Eo=4.04039;          

%K, polarization voltage (V)
K=0.15439;          

%Q, Battery Capacity used to get the model to fit the actual data (Ah)
Q=32.5;           

%A, exponential zone amplitude (V)
A=0.4;

%B, Exponential zone time constant inverse (Ah^-1)
B=0.75;

%Rated Capacity of the Battery from the capacity of its slowest discharge
%(Ah)
Capacity=32.5;

%Internal Resistance
Rint=0.033;%17*10^-3 from datasheet

%Maximum Current (A)
Imax=90;%500;               

%Mass of one battery cell(kg)
cell_mass=single(0.787);

batt_kwh = 24;

NoCells_ESS1 = 192;

NoCells_ESS1_par = 2;
ser_cells = 96;