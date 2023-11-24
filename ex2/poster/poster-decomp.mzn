int: n;  
int: w;  
int: h;  

array[1..n] of var int: ws;
array[1..n] of var int: hs;

array[1..n] of var 0..w: x; % bottom-left figure coordinate 
array[1..n] of var 0..h: y; % bottom-left figure coordinate

% constraint (no exceed)
constraint forall(i in 1..n)(x[i] + ws[i] <= w /\ y[i] + hs[i] <= h);

% noOverlap constraint
constraint forall(a, b in 1..n where a < b)((x[a] + ws[a] <= x[b]) \/ (x[b] + ws[b] <= x[a]) \/ (y[a] + hs[a] <= y[b]) \/ (y[b] + hs[b] <= y[a]));

solve satisfy;