include "globals.mzn";

int: M;                             %number of machines = number of tasks
int: J;                             %number of jobs

set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;

array[JOB, TASK] of MACH: machine;   % machines for tasks
array[JOB, MACH] of int: duration;   % task durations on machines

% Start time for each job j and its task i
array[JOB, TASK] of var int: S;

% Start times 
constraint forall(j in JOB, i in TASK)(S[j, i] >= 0);

% Precedence constraint 
constraint forall(j in JOB, i in 1..M - 1)(S[j, i + 1] >= S[j, i] + duration[j, machine[j, i]]);

% Disjunctive constraint
constraint forall(m in MACH)(
  forall(j1 in JOB, j2 in JOB where j1 < j2)(
    let {
      array[int] of var int: tasks1 = [S[j1, i] + duration[j1, machine[j1, i]] | i in TASK where machine[j1, i] = m];
      array[int] of var int: tasks2 = [S[j2, i] + duration[j2, machine[j2, i]] | i in TASK where machine[j2, i] = m];
    }
    in
    disjunctive(tasks1, tasks2)
  )
);

            
% Objective: minimize makespan
var int: makespan = max(j in JOB, i in TASK)(S[j, i] + duration[j, machine[j, i]]);

solve minimize makespan;

% Output makespan
output ["Makespan: \(makespan)"] ++ ["\nStart times:\n"] ++ [show(S)];