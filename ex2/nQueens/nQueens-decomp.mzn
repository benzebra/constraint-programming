%alldifferent decomposed model

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% Column attack and Diagonal attack constraints using the alldifferent constraint
% global: alldifferent(q)
constraint forall(i,j in 1..n where j>i)(q[j]!=q[i]);

% global: alldifferent([ q[i] + i | i in 1..n ])
constraint forall(i,j in 1..n where j>i)(q[i]+i!=q[j]+j);
% global: alldifferent([ q[i] - i | i in 1..n ])
constraint forall(i,j in 1..n where j>i)(q[i]-i!=q[j]-j);


solve :: int_search(q, input_order, indomain_min) satisfy;