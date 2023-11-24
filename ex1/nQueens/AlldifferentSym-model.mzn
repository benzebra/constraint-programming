% Alldifferent model

include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)
% Map each position i,j to a Boolean telling us whether there is a queen at i,j
array[1..n,1..n] of var bool: qb;
% Column attack and Diagonal attack constraints using the alldifferent constraint
% Append ::domain to the end.  
constraint alldifferent(q)::domain;

constraint alldifferent([ q[i] + i | i in 1..n ])::domain;
constraint alldifferent([ q[i] - i | i in 1..n ])::domain;
% Channeling constraint
constraint forall (i,j in 1..n) ( qb[i,j] <-> (q[i]=j) );
% Lexicographic symmetry breaking constraints
constraint
    lex_lesseq(array1d(qb), [ qb[j,i] | i,j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(qb), [ qb[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(qb), [ qb[j,i] | i,j in reverse(1..n) ])
;

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;