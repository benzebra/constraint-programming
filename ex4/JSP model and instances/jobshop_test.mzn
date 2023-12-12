include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

int: maxduration = sum(duration);
array[JOB,MACH] of var 1..maxduration: start;		%array of starting times

%makespan var creation
var int: makespan = max(j in JOB, m in MACH)(start[j,m] + duration[j,m]);

%precedence constraints based on machine matrix & start init
constraint forall(i in 1..J, j in 1..(M-1))			
							(start[i,machine[i,j+1]] >= start[i,machine[i,j]] + duration[i,machine[i,j]])::domain;

%disjunctive GC - noOverlap of the tasks during the exec for each machine
constraint forall(m in MACH)(disjunctive(start[JOB,m],duration[JOB,m]))::domain;

%solve minimize makespan;
solve :: int_search(start, smallest, indomain_min) minimize makespan;
output ["makespan=\(makespan)"];