include "globals.mzn";

int: N;
array[1..N,1..N] of int: start;      % if(value==0) (cell is empty) else (cell is colored)
array[1..N,1..N] of var 1..N: result;     % cell can't be == 0, no empty cells   


constraint forall (i in 1..N, j in 1..N where start[i, j] > 0) (
  result[i, j] = start[i, j]
);

% row & column constraints
constraint forall(i in 1..N)(alldifferent( [result[i,j] | j in 1..N] )::domain);
constraint forall(j in 1..N)(alldifferent( [result[i,j] | i in 1..N] )::domain);


% solver heuristics

%solve satisfy;
solve :: int_search(result, dom_w_deg, indomain_random) satisfy;
%solve :: int_search(result, dom_w_deg, indomain_random, restart_luby(250)) satisfy;
