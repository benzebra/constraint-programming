include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

int: maxduration = sum(duration);
array[JOB,TASK] of var 0..maxduration: start;		%array of starting times

%makespan var creation
var 0..maxduration: makespan;

%precedence constraints based on machine matrix & start init
constraint forall(i in JOB, j in 1..(M-1))			
							(start[i,machine[i,j+1]] >= start[i,machine[i,j]] + duration[i,machine[i,j]]);

%disjunctive GC - noOverlap of the tasks during the exec for each machine
constraint forall(m in MACH)(
							forall(j in JOB, t in TASK where machine[j,t]==m)					
								(disjunctive(start[JOB,m],duration[JOB,m])
							)
					 );

solve minimize makespan;
%solve :: int_search(start, smallest, indomain_min) minimize makespan;
output ["makespan=\(makespan)"];