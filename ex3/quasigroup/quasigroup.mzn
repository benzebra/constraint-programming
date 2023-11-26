include "globals.mzn";

int: N;
array[1..N,1..N] of var 0..N: start;      % if(value==0) (cell is empty) else (cell is colored)
array[1..N,1..N] of var 1..N: result;     % cell can't be == 0, no empty cells   


constraint forall(i,j in 1..N)(if start[i,j] > 0 then result[i,j] = start[i,j] else true endif);

% row & column constraints
constraint forall(i in 1..N)(alldifferent( [result[i,j] | j in 1..N] ))::domain;
constraint forall(j in 1..N)(alldifferent( [result[i,j] | i in 1..N] ))::domain;


% solver heuristics

solve satisfy;
%solve :: int_search(start, dom_w_deg, indomain_random) satisfy;
%solve :: int_search(start, dom_w_deg, indomain_random, restart_luby(250)) satisfy;
