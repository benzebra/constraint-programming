include "globals.mzn";

int: n;  
int: w;  
int: h;  

array[1..n] of int: ws;
array[1..n] of int: hs;

array[1..n] of var 0..w: x; % bottom-left figure coordinate 
array[1..n] of var 0..h: y; % bottom-left figure coordinate 



% constraint (no exceed)
constraint forall(i in 1..n)( x[i] >= 0 /\ x[i] + ws[i] <= w /\ y[i] >= 0 /\ y[i] + hs[i] <= h );

% noOverlap constraint (global)
constraint diffn(x, y, ws, hs);


solve satisfy;