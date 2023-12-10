include "globals.mzn";

int: n;  
int: w;  
int: h;  

array[1..n] of int: ws;
array[1..n] of int: hs;

array[1..n] of var 0..w: x; % bottom-left figure coordinate 
array[1..n] of var 0..h: y; % bottom-left figure coordinate 

array[1..n*2] of var 0..max(w-1,h-1): xy; % big array with x and y

%var set of int: xy

% constraint (no exceed)
constraint forall(i in 1..n)(x[i] >= 0 /\ x[i] + ws[i] <= w /\ y[i] >= 0 /\ y[i] + hs[i] <= h);

% array populating
constraint forall (i in 1..n)(xy[2*i]=y[i] /\ xy[2*i-1]=x[i]);

% noOverlap constraint (global)
constraint diffn(x, y, ws, hs);

%solve :: int_search(xy, input_order, indomain_min) satisfy;
%solve :: int_search(xy, input_order, indomain_random) satisfy;
%solve :: int_search(xy, first_fail, indomain_min) satisfy;
solve :: int_search(xy, first_fail, indomain_random) satisfy;
%solve :: int_search(xy, dom_w_deg, indomain_min) satisfy;
%solve :: int_search(xy, dom_w_deg, indomain_random) satisfy;
