function [E_oc]=open_circuit_batt_voltage(DoD,NoCells,Eo,K,Q,A,B,CR_prev)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Title: open_circtui_voltage
%
%Author: Reed Doucette
%
%Created: May 6, 2009
%
%Record of Revisions:
%   June 4,2009: The function was changed to generate an open circuit
%   voltage based on the new battery model taken from the paper by Tremblay
%   et. al. entitled "A Generic Battery Model for the Dynamic Simulation of
%   Hybrid Electric Vehicles". By Reed Doucette.
%
%
%Purpose: To compute the open circuit voltage of the battery given its
%state of charge and the number of cells in the battery pack.
%
%List of Inputs
%   DoD:    
%           depth of discharge (0 when the battery is fully charged and 1 when
%           it is completely empy
%   NoCells:
%           the number of cells in the battery pack
%   open_circuit_polynomial_fit:
%           a vector containing the coefficients for a polynomial fit of
%           the battery's open circuit voltage
%
%List of Outputs:
%   E_oc: 
%           the open circuit voltage of the battery pack given its state of
%           charge and the number of cells it contains    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if DoD<0
    error('DoD < 0');

elseif DoD>1
    error('DoD > 1');
end

E_oc=single(NoCells*(Eo-K*Q/(Q-CR_prev)+A*exp(-B*CR_prev)));
