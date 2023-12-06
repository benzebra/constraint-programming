include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

array[JOB,MACH] of var int: starttime;

%init
%constraint forall(i in JOB, j in TASK)(starttime[i,j] >= 0);

%precedence
constraint forall(i in JOB, j in 1..M-1)(starttime[i,machine[i,j+1]] >= starttime[i,machine[i,j]] + duration[i,machine[i,j]]);

%disjunctive
constraint forall(m in MACH)(disjunctive(starttime[JOB,M], duration[JOB,m]));
%constraint forall(j in JOB)(disjunctive(starttime[j,MACH], duration[j,MACH]));


solve satisfy;
%var int: makespan = max(i in JOB, j in TASK)(starttime[i,machine[i,j]] + duration[i,machine[i,j]]);

%constraint forall(i in JOB)(
 %             forall(j in TASK)(
  %              if(j=1)then
   %               (starttime[i,j] = 0 /\ endtime[i,j] = duration[i,machine[i,j]])
    %            else
     %             (starttime[i,j] = endtime[i,j-1] /\ endtime[i,j] = starttime[i,j] + duration[i,machine[i,j]])
      %          endif
       %       )
        %   ); 
             
%constraint disjunctive(starttime[i,j], )

%solve minimize makespan;