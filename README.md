# PDDL Models for Agents in City 2018

These are a set of [PDDL models](http://users.cecs.anu.edu.au/~patrik/pddlman/writing.html) to handle the [2018 Agents in City](https://multiagentcontest.org/2018/) domain from the International [Multi-Agent Contest](https://multiagentcontest.org/).

These models were built as part of Ujjwal Batra's Minor Thesis at RMIT University in 2019.

The ovearall idea is to experiment how much we can use PDDL planners to support the synthesis of high-level plans for a set of agents playing the [2018 Agents in City](https://multiagentcontest.org/2018/). The plan obtained would then be passed to a reactive-based agent executor (e.g., [SARL](http://www.sarl.io/)) which will deploy and monitor the plan in the server, calling the planner for re-planning as needed.

**NOTE:** This is very much work "in progress".

## Models 

There are various directories for the following purposes:

* `v1`: Basic modeling with full assembly, yet not scalable.
* `v2`: The encodings with dummy actions to reduce number of operator's parameters (fixes scalablity). Version v2.1 makes use of existential quantifiers (which may get stuck while grounding).
  * Output files:
    * execution.details - Execution details of problem 1 on 
* `v3`: Uses action cost and minimization.
* `v4`: Uses numeric fluents to capture the carrying capacity of the agents.


## Editing & Running the models

Models have been developed using [Visual Studio Code](https://code.visualstudio.com/) IDE with the [PDDL extension](https://marketplace.visualstudio.com/items?itemName=jan-dolejsi.pddl).

The planners used, as of August 2019, were:

1. [SIW Plus-then-BFS with FF parser](https://github.com/LAPKT-dev/LAPKT-public/tree/master/planners/siw_plus-then-bfs_f-ffparser) from LAPTK. 
   * [siw plus planer](http://lapkt.org/index.php?title=Documentation#SIW_Plus) and Output of problem 1 on [siw plus planner](http://lapkt.org/index.php?title=Documentation#SIW_Plus)
2. [Metric-FF](https://fai.cs.uni-saarland.de/hoffmann/metric-ff.html), the one that entered the 3rd international planning competition. This is v1.0 in [here](https://github.com/ssardina-planning/ff-planners). Before using it, one has to change the number of allowed operators by modifying `ff.h` to something like this: `#define MAX_OPERATORS 1050`
3. The [Madagascar](https://users.aalto.fi/~rintanj1/satplan.html) SAT-based planner, which can give plans with concurrent actions.


## Planners

### Using LAPKT planners

The above models have been tested with various planers from the [Lightweight Automated Planning Toolkit](https://github.com/aig-upf/LAPKT-public) (LAPKT), which contains a [collection of planners](http://lapkt.org/index.php?title=Documentation) that can be compiled and used almost on-the-spot (many planners with both `FF` and `FD` parsers).

Assuming LAPKT has been compiled, here is an example:

```shell
$ ./siw-then-bfsf --domain v1/domain.pddl --problem v1/problem1.pddl --output v1/plan-p1-1.plan
 --- OK.
 Match tree built with 152608 nodes.

PDDL problem description loaded: 
	Domain: AGENTS-IN-THE-CITY
	Problem: COMPLETE-JOBS
	#Actions: 152608
	#Fluents: 867
Landmarks found: 1
Starting search with IW (time budget is 60 secs)...
rel_plan size: 11
#RP_fluents 15
Caption
{#goals, #UNnachieved,  #Achieved} -> IW(max_w)

{1/1/0}:IW(1) -> [2][3][4][5][6][7][8][9][10][11][12][13][14][15]rel_plan size: 0
#RP_fluents 0Plan found with cost: 14
Total time: 6.6792
Nodes generated during search: 10108
Nodes expanded during search: 9402
IW search completed
```

### Planning with simulators

```
planning-with-simulators.git/code/fs/run.py -i v1/problem1.pddl --domain v1/domain.pddl --driver sbfws
```

### SIW Plus:


```
./siw_plus.py v2/v2.1/domain.pddl v2/v2.1/problem.pddl plan.ipc
```

### Madagascar

[Paper](https://users.aalto.fi/~rintanj1/papers/Rintanen14IPC.pdf)

```
./madagascar/M v1/domain.pddl v1/problem1.pddl
./madagascar/Mp v1/domain.pddl v1/problem1.pddl
./madagascar/MpC v1/domain.pddl v1/problem1.pddl
```


### Fastdownards

[Link](http://www.fast-downward.org/IpcPlanners)

```
./planning/fast-downard.git/fast-downward.py --alias seq-sat-lama-2011 v3/domain.pddl v3/problem.pddl

./planning/fast-downard.git/fast-downward.py --alias seq-sat-fdss-2018 --search-time-limit 1000 v3/domain.pddl v3/problem.pddl
```



    