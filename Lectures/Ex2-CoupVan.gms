$ontext
CEE 6410 - Water Resources Systems Analysis
Example Coups Minivans from Lecture Example 2 on Graphical solution to LP

A manufacturer can produce:  coups and minivans.  Data are as fol-lows:

Seasonal Resource
Inputs or Profit        Crops        Resource
Availability
        Eggplant        Tomatoes
Water        1x103 gal/plant        2x103 gal/plant      4x106 gal/year
Land        4 ft2/plant        3 ft2/plant               1.2x104 ft2
Labor         5hr/plant        2.5/hr plant              17,500 hours
Profit/plant        $6        $7

                Determine the optimal planting for the two crops.

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

David E Rosenberg
david.rosenberg@usu.edu
September 15, 2015
$offtext

* 1. DEFINE the SETS
SETS vehicle Type of vehicle to produce /coup, minivan/
     res resources /Metal, CircuitBoards, Labor/;

* 2. DEFINE input data
PARAMETERS
   c(vehicle) Objective function coefficients ($ per vehicle)
         /coup 6000,
        minivan 7000 /

   b(res) Right hand constraint values (per resource)
          /Metal 4000000,
           CircuitBoards  12000,
           Labor  17500/;

TABLE A(vehicle,res) Left hand side constraint coefficients
                 Metal    CircuitBoards   Labor
 Coup            1000      4                5
 Minivan        2000      3                2.5;

*PARAMETER UB(plnt) Upper bound on decision variables
* / Eggplant 10000, Tomatoes 700/;
************
*TABLE A(plnt,res) Left hand side constraint coefficients;
*A("Eggplant", "Water") = 1000;
*A("Eggplant", "Land") = 4;


*******

* 3. DEFINE the variables
VARIABLES X(vehicle) plants planted (Number)
          VPROFIT  total profit ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints;
*   LowerLimitDecisionVariables(plnt) Lower limit on decision variable
*   UpperBoundDecisionVariables(plnt) Upper bound on decision variables;

PROFIT..                 VPROFIT =E= SUM(vehicle, c(vehicle)*X(vehicle));
RES_CONSTRAIN(res) ..    SUM(vehicle, A(vehicle,res)*X(vehicle)) =L= b(res);
*LowerLimitDecisionVariables(plnt)..     X(plnt) =G= 10;
*UpperBoundDecisionVariables(plnt)..    X(plnt) =L= ub(plnt);

* 5. DEFINE the MODEL from the EQUATIONS
MODEL PLANTING /PROFIT, RES_CONSTRAIN/;
*MODEL AmmonsPLANTING /PROFIT, RES_CONSTRAIN, LowerLimitDecisionVariables, UpperBoundDecisionVariables /;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;

PlANTING.dictfile = 4;
PLANTING.optfile  = 1;
option lp = cplex;

* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
SOLVE PLANTING USING LP MAXIMIZING VPROFIT;

*SOLVE AmmonsPLANTING USING LP MAXIMIZING VPROFIT;



* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
