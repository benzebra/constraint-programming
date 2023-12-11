include "globals.mzn";

int: n_tasks;                     % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration;    % Task durations

int: n_res;                       % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L;       % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

int: p;                           % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre;   % Precedence relations

int: max_duration = sum(duration);  
array[TASKS] of var 0..max_duration: start;

%makespan var creation
var int: makespan = max(t in TASKS)(start[t] + duration[t]);

% precednec constraint & start init
constraint forall(j in PREC)(start[pre[j,2]] >= start[pre[j,1]] + duration[pre[j,1]])::domain;

% cumulative GC - tasks with multiple resources
constraint forall(r in RESOURCES)(cumulative(start,duration,req[r,TASKS],L[r]))::domain;

%solve minimize makespan;
solve :: int_search(start, first_fail, indomain_min) minimize makespan ;
output ["makespan=\(makespan)"];

