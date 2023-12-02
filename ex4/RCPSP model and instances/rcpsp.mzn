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

int: max_duration = sum(duration);  %max(makespan) = sum(duration) <- greedy solution
array[TASKS] of var 0..max_duration: start_time;

constraint forall(i in RESOURCES)(cumulative(start_time,duration,req[i,TASKS],L[i]))::domain;

constraint forall(j in PREC)(
              pre[j,0])::domain;