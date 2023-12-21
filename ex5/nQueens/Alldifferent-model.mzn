include "alldifferent.mzn";
include "gecode.mzn";

int: n; % Number of queens
array[1..n] of var 1..n: q; % Variables for queens on the rows (or columns)
% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.  
constraint alldifferent(q)::domain;

constraint alldifferent([q[i] + i | i in 1..n])::domain;
constraint alldifferent([q[i] - i | i in 1..n])::domain;

var int: obj = sum(i in 1..n)(abs(q[i]-i));

% default resolution
solve minimize obj;

% domWdeg resolution + random
%solve:: int_search(q, dom_w_deg, indomain_random) minimize obj;

% domWdeg resolution + random + luby_restart
% solve :: int_search(q, dom_w_deg, indomain_random)
%       :: restart_luby(250) minimize obj; 

% domWdeg resolution + random + luby_restart + LNS
% solve :: int_search(q, dom_w_deg, indomain_random)
%       :: restart_luby(250)
%       :: relax_and_reconstruct(q, 85) minimize obj;
      
output ["obj = \(obj)"];
