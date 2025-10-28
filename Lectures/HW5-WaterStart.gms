$ontext
CEE 6410 - Water Resources Systems Analysis

Home work #5 - Reservoir Operation problem for Irrigation and Hydropower benefits
       Determine the optimal planting for the two crops.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

David E Rosenberg
david.rosenberg@usu.edu
September 25, 2015
$offtext



* 1. DEFINE the SETS
SETS spatial points of interest in the problem schematic /ReservoirStorage, Turbine, Spill, FlowAtA, Irrigation/
         month time periods /month1, month2, month3, month4,  month5, month6 /;
*        /month1*month6/

* 2. DEFINE input data

SCALAR TurbineCapacity Upper limit on flow through the turbines [volume]  /4/
                MinFlowAtA Minimum required flow at point A [volume per month] /1/;

PARAMETERS
   HydroBenefits(month) Hydropower benefits per month /
            month1 1.6
            month2  1.7
            month3  1.8
            month4  1.9
            month5  2.0
            month6 2/

   IrrigationBenefits(month) Irrigation benefits per month 
            /month1 1
            month2  1.2
            month3  1.9
            month4  2
            month5  2.2
            month6 2.2/
            
    ReservoirInflow(month) Reservoir inflow
        /   month1 2
            month2  2
            month3  3
            month4  4
            month5  3
            month6  2/;
            


* 3. DEFINE the variables
VARIABLES  X(spatial, month) All of volume per location per month [arbritary] except storage which is a volume
            VPROFIT Objective Function value [$]
            FINALSTORAGE storage at the end of the last time step;
* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   TURBINECAPACITY Upper limit of turbine releases
   MINFLOWAtA Minimum flow at point A
   ReservoirMassBalance Reservoir Mass Balance in each time period 1 to 5;
   

PROFIT..                 VPROFIT =E= SUM(month, HydroBenefits(month)*X("Turbine", month)) + IrrigationBenefits(month)*X("Irrigation", month)) ;

TURBINECAPACITY(month)..   X("Turbine", month) =L=  TurbineCapacity; 

MINFLOWAtA(month)..             X("FlowAtA", month) =G= MinFlowAtA;

ReservoirMassBalance(month)$(ord(month) lt card(month))..  X("ReservoirStorage",month) + ReservoirInflow(month) - X("Turbine",month) - X("Spill",month) =E= X("ReserviorStorage", month+1);




* 5. DEFINE the MODEL from the EQUATIONS
MODEL PLANTING /PROFIT, RES_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;


* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANTING USING LP MAXIMIZING VPROFIT;


* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
