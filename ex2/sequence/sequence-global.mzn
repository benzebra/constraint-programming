%Sequence Puzzle globalized

include "globals.mzn";

int: n; %number of variables (array length)
array [1..n] of var 0..n-1: seq; %sequence

%global constraint
%GCC
constraint global_cardinality(seq,[i | i in 0..n-1],seq);

%implied
%constraint sum(j in 1..n)(seq[j]) == n;
%constraint sum(j in 1..n)(seq[j]*j-1) == n;


solve satisfy;

output ["x = \(seq);\n"] ;