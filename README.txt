README

----------------------------------------------------------------------------------
WARNING: THIS WAS WRITTEN 5 YEARS AFTER THE PROGRAM'S CREATION, NOT BY THE AUTHOR.
----------------------------------------------------------------------------------

The main GUI is run from 'ovemplus'. The program encompasses three main functions: vehicle modelling, vehicle sweep and consumer preference modelling.

This file first runs through the high-level structure of each function and then discussed the lower level model layout.

-----------------
VEHICLE MODELLING
-----------------

Purpose: Given several vehicle parameters calculate the running cost, emissions, energy consumption and battery capacity. 

Run from the gui 'vmod1'. 

This creates several global parameters which are used to store the vehicle characteristics. 
The first 'SPD' contains the SMMT category (type of vehicle), the powertrain type (ICE, hybrid, electric) and the drive cycle that you are using to test the vehicle.

Dependant on the powertrain selected different subguis are launched in order to set the more specific parameters, which are then stored in the global variables. The subguis are : 'electric', 'ICE' and 'hybrid'.

You can either input all of the vehicle parameters or you have the option to select (suspect?) default values based on the vehicle SMMT category. Once these have been input the subgui is closed.

If all the parameters have been sucessfully set 'ovem31' is called. This is the top-level function which runs the simulation.

-------------
VEHICLE SWEEP
-------------

Purpose: For a given drive cycyle compare the cost, emissions and consumption of all powertrain and SMMT combinations.

Run from the gui 'para1'.

After a drive cycle is selected the script 'ovem_31' is run which returns global matricies containing the predictions for every combination of powertrain and smmt catergory.

These are then displayed as bar charts depending on what you select to plot.

--------------
CONSUMER MODEL
--------------

Purpose: predict a consumer's preference for vehicle powertrain given a personal criteria weighting and information about polict changes / subsidies.

Run from the gui 'proba1'.


-------------
FUNCTIONALITY
-------------

The main computation is run from 'level_3_ttw'.

There are a bunch of powertrain specific scripts which run the forwards / backwards simulation which have the form level_3_XX - eg. 'level_3_ev2'

These all call one script per functional block in the backwards / forwards model - eg.'vehicle_backwards_3' runs the vehicle block in the backwards part of the simulation.

All of these functions take vehicle parameters and the current torque and speed requirements as inputs and calculate updated requirements based on the performance of the block they are representing.