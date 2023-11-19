%Sequence Puzzle

int: n; %number of variables (array length)
array [0..n-1] of var 0..n-1: seq; %sequence

%domain
constraint forall(i in 0..n-1)(seq[i] = sum(j in 0..n-1)(seq[j] = i));

%implied
%constraint sum(j in 0..n-1)(seq[j]) == n;
%constraint sum(j in 0..n-1)((seq[j])*j) == n;

solve satisfy;

output ["x = \(seq);\n"] ;