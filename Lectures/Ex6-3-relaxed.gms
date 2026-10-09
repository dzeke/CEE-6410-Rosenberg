$ontext
CEE 6410
Example 6.3 in the Bishop Et al text https://digitalcommons.usu.edu/ecstatic_all/76/ with an
additional $35,000 upfront costs to establish the wholesale contract (pay laywers :)

A water wholesaler is willing to sell water to your municipal water supply utility in an
amount not exceeding 12,000 ac-ft per year, but only if you buy at least 1,000 ac-ft/yr
(to amortize their pipe cost).  Water from the wholesaler will cost $150/ac-ft.

An alternative source of water is to construct your own treatment plant.
The minimum sized plant which will meet your demand of 2,000 ac-ft/yr will cost $90,000 annual
capital cost and $120/ac-ft to operate.

With the additional $35,000 capital cost for establishing the wholesale contract.

Allows user to control bounds on "integer" variables (IntUpBnd and IntLowBnd).

Presently fully relaxed.

David E Rosenberg
david.rosenberg@usu.edu
Updated October 10, 2026
$offtext

* 1. DEFINE the SETS
SETS src water supply sources /tp "treatment plant", wc "wholesale contract"/;

* 2. DEFINE input data
PARAMETERS
   CapCost(src) capital cost ($ to build)
         /tp 90000,
          wc 35000/
   OpCost(src) operating cost ($ per ac-ft)
         /tp 120
          wc 150/
   MaxCapacity(src) Maximum capacity of source when built (ac-ft per year)
          /tp 2000,
           wc  12000/
   MinUse(src) Minimum required use of source when built (ac-ft per year)
          /tp 0,
           wc  1000/
   TotDemand  Total Demand (ac-ft per year) /2000/


* "Integer" variables free within 0 to 1 bounds.
* Allows user to relax, tighten bounds on integer variables
* Presently set in fully relaxed mode
   IntUpBnd(src) Upper bound on integer variables (#)
          /tp 1,
           wc 1 /
   
IntLowBnd(src) Lower bound on integer variables (#)
           /tp 0,
           wc 0/ ;

* 3. DEFINE the variables
VARIABLES I(src) binary decision to build or do prject from source src (1=yes 0=no)
          X(src) volume of water provided by source src (ac-ft per year)
          TCOST  total capital and operating costs of supply actions ($);

* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   COST            Total Cost ($) and objective function value
   MaxCap(src)     Maximum capacity of source when built (ac-ft per year)
   MinReqUse(src)  Minimum required use of source when built (ac-ft per year)
   MeetDemand      Meet demand (ac-ft per year)
   IntUpBound(src) Upper bound on interger variables (number)
   IntLowBound(src) Lower bound on integer variables (number);

COST..                 TCOST =E= SUM(src,CapCost(src)*I(src) + OpCost(src)*X(src));
MaxCap(src) ..           X(src) =L= MaxCapacity(src)*I(src);
MinReqUse(src) ..        X(src) =G= MinUse(src)*I(src);
MeetDemand ..            sum(src,X(src)) =G= TotDemand;
IntUpBound(src) ..       I(src) =L= IntUpBnd(src);
IntLowBound(src) ..      I(src) =G= IntLowBnd(src);

* 5. DEFINE the MODEL from the EQUATIONS
MODEL WatSupplyRelaxed /ALL/;

option solprint = on;

* 6. Solve the Model as an LP (relaxed IP)
SOLVE WatSupplyRelaxed USING LP MINIMIZING TCOST;

DISPLAY X.L, I.L, TCOST.L;

$ontext
* Dump all input data and results to a GAMS gdx file
Execute_Unload "Ex6-3-relaxed.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls Ex6-3.relaxed.gdx"
$offtext
