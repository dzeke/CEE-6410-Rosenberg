$ontext
CEE 6410 - Water Resources Systems Analysis
Example 2.1 from Bishop Et Al Text (https://digitalcommons.usu.edu/ecstatic_all/76/)
Modifies Example to add a labor constraint

and further modified to represent the vehicle production problem with metal, curcuit boards, and labor consraints

THE PROBLEM:

How many coups and minivans should a car manufacturer produce in a year?

The data are as follows:

•   The car manufacturer profits by $6,000 per coup produced and $7,000 per minivan produced.
•   Each coup requires 1,000 pounds of metal to produce while each minivan requires 2,000 pounds of metal.
•   The manufacturer has 4,000,000 pounds of metal available for the year.
•   Coups have more electronics and features. Thus, each coup requires 4 circuit boards per vehicle while each minivan requires 3 circuit boards per vehicle.
•   The manufacturer has purchased 12,000 circuit boards for the year.
•   One coup takes one worker 5 days to produce while one worker takes 2.5 days to produce a minivan. 
•   The manufacturer has 67 workers and runs their factory for 261 days per year (i.e., the manufacturer has 17,500 worker-days per year).   

Determine the number of coups and minivans to produce

THE SOLUTION:
Uses General Algebraic Modeling System to Solve this Linear Program

David E Rosenberg
david.rosenberg@usu.edu
September 15, 2015
$offtext

* 1. DEFINE the SETS
SETS plnt crops growing /Eggplant, Tomatoes/
         res resources /Water, Land, Labor/
* for car production problem
        cars Cars to produce  / Coups, Minivans  /
        materials Materials used to produce vehicles /Metal, CircuitBoards, Labor/;

* 2. DEFINE input data
PARAMETERS
   c(plnt) Objective function coefficients ($ per plant)
         /Eggplant 6,
        Tomatoes 7 /

   b(res) Right hand constraint values (per resource)
          /Water 4000000,
           Land  12000,
           Labor  17500/
           
    carprofit(cars) Profit per car produced ($ per car)
        / coups 6
        minivans 7/
    
    carconstraints(materials) Righthand constraint values for car production (per resource)
        /Metal 4000000,
        CircuitBoards 12000,
        Labor 17500/;

TABLE A(plnt,res) Left hand side constraint coefficients
                 Water    Land   Labor
 Eggplant        1000      4       5
 Tomatoes        2000      3       2.5;

TABLE Z(cars,materials) Left hand side constraint coefficients for the car problem
                      Metal        CircuitBoards         Labor
*Coups         1000               4                   5
* Minivans       2000               3                 2.5;
 Coups               1000                     4             5
 Minivans          2000                     3              2.5;
       


* 3. DEFINE the variables
VARIABLES X(plnt) plants planted (Number)
          VPROFIT  total profit ($);

VARIABLES
          W(cars) cars to produce (Number)
        CPROFIT total profit from producing cars ($);

* Non-negativity constraints
POSITIVE VARIABLES X, W;

* 4. COMBINE variables and data in equations
EQUATIONS
   PROFIT Total profit ($) and objective function value
   RES_CONSTRAIN(res) Resource Constraints
   PROFITCARS Total profit from producing cars ($) the objective function value
   MATERIALCONSTRAINTS(materials) Resources used to produce cars;

PROFIT..                 VPROFIT =E= SUM(plnt, c(plnt)*X(plnt));
RES_CONSTRAIN(res) ..    SUM(plnt, A(plnt,res)*X(plnt)) =L= b(res);

PROFITCARS..        CPROFIT =E=  SUM(cars, carprofit(cars)*W(cars));
MATERIALCONSTRAINTS(materials).. SUM(cars, Z(cars,materials)*W(cars)) =L= carconstraints(materials);

* 5. DEFINE the MODEL from the EQUATIONS
MODEL PLANTING /PROFIT, RES_CONSTRAIN/;
*Altnerative way to write (include all previously defined equations)
*MODEL PLANTING /ALL/;
MODEL CARPRODUCTION / PROFITCARS, MATERIALCONSTRAINTS/;



* 6. SOLVE the MODEL
* Solve the PLANTING model using a Linear Programming Solver (see File=>Options=>Solvers)
*     to maximize VPROFIT
*SOLVE PLANTING USING LP MAXIMIZING VPROFIT;

SOLVE CARPRODUCTION USING LP MAXIMIZING CPROFIT;

* 6. CLick File menu => RUN (F9) or Solve icon and examine solution report in .LST file
