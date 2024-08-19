$Title  Enumerate all Feasible Basic Solutions of the Transportation Problem (ALLBASES,SEQ=396)
$Ontext

This problem finds a least cost shipping schedule that meets
requirements at markets and supplies at factories. We reformulte in standard
form use binary variables to determine if a variable belongs to the basis or
not. Then we use binary cuts to enumerate all feasible basic solutions in the
sort order of the objective function.

Dantzig, G B, Chapter 3.3. In Linear Programming and Extensions.
Princeton University Press, Princeton, New Jersey, 1963.

$Offtext


  Sets
       i   canning plants   / seattle, san-diego /
       j   markets          / new-york, chicago, topeka / ;

  Parameters

       a(i)  capacity of plant i in cases
         /    seattle     350
              san-diego   600  /

       b(j)  demand at market j in cases
         /    new-york    325
              chicago     300
              topeka      275  / ;

  Table d(i,j)  distance in thousands of miles
                    new-york       chicago      topeka
      seattle          2.5           1.7          1.8
      san-diego        2.5           1.8          1.4  ;

  Scalar f  freight in dollars per case per thousand miles  /90/ ;

  Parameter c(i,j)  transport cost in thousands of dollars per case ;

            c(i,j) = f * d(i,j) / 1000 ;

  Variables
       x(i,j)      shipment quantities in cases
       z           total transportation costs in thousands of dollars
       sslack(i)   slack for supply constraint
       dslack(j)   slack for demand constraint


  Positive Variable x, sslack, dslack;

  Equations
       cost        define objective function
       supply(i)   observe supply limit at plant i
       demand(j)   satisfy demand at market j ;

  cost ..        z  =e=  sum((i,j), c(i,j)*x(i,j)) ;

  supply(i) ..   sum(j, x(i,j))  =e=  a(i) - sslack(i);

  demand(j) ..   sum(i, x(i,j))  =e=  b(j) + dslack(j);

* Basis definition
  Variables
       xind(i,j)    x basis indicator
       sslind(i)    sslack basis indicator
       dslind(j)    dslack basis indicator
  Binary Variable xind, sslind, dslind;

  Equations
       defbasis     basis definition
       defximp(i,j) xind=0 => x=0
       defsslimp(i) sslind=0 => ssl=0
       defdslimp(j) dslind=0 => dsl=0;

  defbasis ..    card(i) + card(j) =e=
                 sum((i,j), xind(i,j)) + sum(i, sslind(i)) + sum(j, dslind(j));

  defximp(i,j) .. x(i,j) =l= min(a(i),b(j))*xind(i,j);
  defsslimp(i) .. sslack(i) =l= a(i)*sslind(i);
  defdslimp(j) .. dslack(j) =l= b(j)*dslind(j);

* Cut definition
$onempty
  Set nb basis enumeration cuts / b1*b22 /
      nba(nb) active cuts / /
      xcc(nb,i,j) / /, sslcc(nb,i) / /, dslcc(nb,j) cut coefficients / /
$offempty

  Equation defcut(nb) cut;
  defcut(nba)..  card(i)*card(j) + card(i) + card(j) - 1 =g=
    sum((i,j)$xcc(nba,i,j), xind(i,j)) + sum((i,j)$(not xcc(nba,i,j)), 1-xind(i,j))
  + sum(i$sslcc(nba,i), sslind(i))     + sum(i$(not sslcc(nba,i)), 1-sslind(i))
  + sum(j$dslcc(nba,j), dslind(j))     + sum(j$(not dslcc(nba,j)), 1-dslind(j));

  Model transport /all/ ;

  Parameter rep, goon /1/;
  option optcr=0, solvelink=5, limrow=0, limcol=0, solprint=silent;
  loop(nb$goon,
    Solve transport using mip minimizing z ;
    xcc(nb,i,j) = round(xind.l(i,j));
    sslcc(nb,i) = round(sslind.l(i));
    dslcc(nb,j) = round(dslind.l(j));
    goon = transport.modelstat = %modelstat.optimal%;
    if (goon,
       rep(nb,'obj','','') = z.l;
       rep(nb,'supply.m',i,'') = supply.m(i);
       rep(nb,'demand.m',j,'') = demand.m(j);
       rep(nb,'x.l',i,j) = x.l(i,j);
       rep(nb,'x.m',i,j) = x.m(i,j);
       nba(nb) = yes);
  )
  abort$goon 'Set nb too small. Feasible basic solutions so far:', rep;
  abort$(abs(rep('b21','obj','','')-177.525)>1e-6) 'incorrect last solution';


