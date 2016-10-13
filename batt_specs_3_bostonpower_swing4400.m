%File containing the characteristic parameters for the Boston Power
%Swing4400 Li battery
%
%Created: October 25, 2010
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Eo, battery constant voltage (V)
Eo=4.04039;          

%K, polarization voltage (V)
K=0.15439;          

%Q, Battery Capacity used to get the model to fit the actual data (Ah)
Q=6.6;           

%A, exponential zone amplitude (V)
A=0.4;

%B, Exponential zone time constant inverse (Ah^-1)
B=1.666667;

%Rated Capacity of the Battery from the capacity of its slowest discharge
%(Ah)
Capacity=4.4;

%Internal Resistance
Rint=0.044;%17*10^-3 from datasheet

%Maximum Current (A)
Imax=12;%500;               

%Mass of one battery cell(kg)
cell_mass=single(0.09);    