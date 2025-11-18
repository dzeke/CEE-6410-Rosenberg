$ontext
CEE 6410 Fall 2025

Capacity Expansion Problem with Variable Costs of Delivery
Example 7-3 Text Modified to include variable costs of delivery

Consider a regional water supply problem in which supply capacity can be
 added by any of five independent projects. Each project will be located in
 a different city. The additional supply and the project costs
 (already been discounted to present value) are shown in Table 7.4.
 Possible discrete construction periods and related growth in demand
 are also summarized in the table.  Assume that end-of-period added capacities shown must be con¬structed at the beginning of each 5-year period because projects can be constructed only during year 1, 6, 11, or 16.

Table 7.1 Additional Capacity by building a new water supply project.

City    Additional Capacity (thousand acre-feet)
Alpha   2
Bravo   4
Charlie 6
Delta   8
Echo    10

Table 7.2  Project Scheduling Problem Data (One-time Build Costs [$ Million]

Period Years   Discounted Cost to Build Project
                        ($ million)    
       Alpha   Bravo   Charlie Delta   Echo    
1   1-5 $12 $15 $18 $23 $26 2
2   6-10    $8  $11 $13 $15     6
3   11-15   $6  $8              8
4   16-20   $4                  10

Table 7.3. Variable (unit) Costs for use of  project ($/acre-feet)

Period  
Years   
        Alpha   Bravo   Charlie Delta   Echo
1   1-5 $10 $3  $7  $5  $3
2   6-10    $8  $7  $6  $1  $2.5
3   11-15   $14 $6  $5  $0.7    $2
4   16-20   $3  $4  $4.2    $0.5    $1.8
$Blue = Variable cost if project is built in a prior time period even though project can not be built in the present time period


David E Rosenberg
david.rosenberg@usu.edu
November 6, 2025
$offtext

* 1. DEFINE the SETS
SETS t Time periods /t1*t4/
         c new project (city) / Alpha, Bravo, Charlie, Delta, Echo/;
         
alias(t,m);

* 2. DEFINE input data
PARAMETERS
   CapCost(c,t) capital cost to build project c in time period t ($ Present Value)
         
   ConveyCost(c,t) Cost to convey water from project c in time period t to regional demand center ($ per ac-ft)
         
   AdditionalCapacity(c) Additional capacity provided by building project in city c (thousand ac-ft per year)
          /Alpha 2, Bravo 4, Charlie 6, Delta 8, Echo 10/
           
   AdditionalDemand(t) Additional demand required to serve in time period t (thousand acre-feet per year)
          /t1 2, t2, 6, t3 8, t4 10/;
  

* 3. DEFINE the variables
VARIABLES I(t,c) binary decision to build project c in time period t (1=yes 0=no)
          V(t,c) volume of water to convey from project c in time period t [acre-feet per year]
          TCOST  total capital and operating coststo deliver waters ($);

BINARY VARIABLES I;
* Non-negativity constraints
POSITIVE VARIABLES X;

* 4. COMBINE variables and data in equations
EQUATIONS
   COST            Total Cost ($) and objective function value
   MeetDemands(t)  Water delivered in timer period t has to eqqual or exceed the additional required demand
   BuildEachProjectOnce(c) We can only build each project once
   UseOnOrAfterBuild(t,c) We can use a project in the time period it is built or any time period afterwards
   
   
[[[[[Additional Equations for Constraints]]]]]

COST..                 TCOST =E= SUM((t,c),CapCost(c,t)*I(t,c) + ConveyCost(c,t)*V(t,c));

MeetDemands(t).. 1000 * SUM(c, V(t,c)) =G= AdditionalDemand(t);

BuildEachProjectOnce(c).. SUM(t , I(c,t)) =L= 1;

UseOnOrAfterBuild(t,c)..  V(t,c) =L= AdditionalCapacity(c) * SUM(m$(ord(m) le ord(t)), I(m,c));

* 5. DEFINE the MODEL from the EQUATIONS
MODEL CostToSupplyWater /ALL/;

* 6. Solve the Model as an LP (relaxed IP)
SOLVE CostToSupplyWater USING MIP MINIMIZING TCOST;

DISPLAY V.L, I.L, TCOST.L;

* Dump all input data and results to a GAMS gdx file
Execute_Unload "Ex7-3ExpandCapacity.gdx";
* Dump the gdx file to an Excel workbook
Execute "gdx2xls Ex7-3ExpandCapacity.gdx"
