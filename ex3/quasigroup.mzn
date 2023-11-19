include "globals.mzn";

int: N;
array[1..N,1..N] of int: start;

array[1..N,1..N] of var 0..N: result;

%output ["N = \(N)\n start = \(start[N-1,N-1])\n"];
constraint forall(i,j in 1..N where start[i,j] > 0)(result[i,j] == start[i,j]);
constraint forall(i in 1..N)(alldifferent( [result[i,j] | j in 1..N] ));
constraint forall(j in 1..N)(alldifferent( [result[i,j] | i in 1..N] ));

%solve satisfy;
%solve :: int_search(start, dom_w_deg, indomain_random) satisfy;
solve :: int_search(start, dom_w_deg, indomain_random, restart_luby(250)) satisfy;
