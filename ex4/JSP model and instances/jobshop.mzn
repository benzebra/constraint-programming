include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

int: maxduration =  sum(j in JOB, i in MACH)(duration[j,i]);
array[JOB,TASK] of var 0..maxduration: start;		%array of starting times

%makespan var creation
var 0..maxduration: makespan;

%precedence constraints based on machine matrix & start init
constraint forall(i in JOB, j in 1..M-1)((start[i, j] + duration[i, machine[i, j]]) <= start[i, j+1]);


constraint forall(i in JOB)(start[i, M] + duration[i, machine[i, M]] <= makespan); 

%disjunctive GC - noOverlap of the tasks during the exec for each machine
constraint forall(mach in MACH)(disjunctive([start[i, j] | i in JOB, j in TASK where machine[i, j] == mach ], duration[..,mach]));


solve minimize makespan;
%solve :: int_search(start, smallest, indomain_min) minimize makespan;
output ["makespan=\(makespan)"];

