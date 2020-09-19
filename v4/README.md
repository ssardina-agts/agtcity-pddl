## v4: Numeric fluents

This version uses numeric fluents to capture the carrying capacity of the agents.

Because it uses numeric fluents, we used v1.0 of [Metric-FF](https://fai.cs.uni-saarland.de/hoffmann/metric-ff.html), the one that entered the competition. All the version of Metric-FF can be found [here](https://github.com/ssardina-planning/ff-planners).

Before using it, one has to change the number of allowed operators by modifying `ff.h` to something like this:

```
#define MAX_OPERATORS 1050
```

I tried Metric-FF v2.0 with option `-s 0`, which I think it corresponds to the default in v1.0, and it gets stuck after 30 mins.



So, under v1.0 we get:

```
[ssardina@Thinkpad-X1 v4]$ ~/git/soft/planning/ff-planners.git/Metric-FF-v1.0/ff -o domain.pddl -f problem.pddl 

ff: parsing domain file
domain 'AGENTS-IN-THE-CITY' defined
 ... done.
ff: parsing problem file
problem 'COMPLETE-JOBS' defined
 ... done.


no metric specified. plan length assumed.

checking for cyclic := effects --- OK.

ff: search configuration is EHC, if that fails then  best-first on 1*g(s) + 5*h(s) where
    metric is  plan length

Cueing down from goal distance:   63 into depth [1]
                                  62            [1]
                                  61            [1]
                                  60            [1]
                                  59            [1]
                                  58            [1]
                                  57            [1]
                                  56            [1]
                                  55            [1]
                                  54            [1]
                                  53            [1]
                                  52            [1]
                                  51            [1]
                                  50            [1]
                                  49            [1][2][3][4]
                                  48            [1][2][3]
                                  47            [1]
                                  46            [1][2][3][4][5][6]
[7][8]
                                  41            [1]
                                  40            [1]
                                  39            [1]
                                  38            [1]
                                  37            [1]
                                  36            [1]
                                  35            [1]
                                  34            [1]
                                  33            [1]
                                  32            [1][2][3][4]
                                  31            [1][2][3][4]
                                  30            [1][2][3][4]
                                  29            [1][2][3]
                                  28            [1]
                                  27            [1]
                                  26            [1][2]
                                  25            [1]
                                  24            [1][2][3]
                                  23            [1]
                                  22            [1]
                                  21            [1]
                                  20            [1]
                                  19            [1]
                                  18            [1]
                                  17            [1]
                                  16            [1][2][3]
                                  15            [1][2][3]
                                  14            [1][2][3]
                                  13            [1]
                                  12            [1]
                                  11            [1]
                                  10            [1]
                                   9            [1]
                                   8            [1]
                                   7            [1]
                                   6            [1]
                                   5            [1]
                                   4            [1]
                                   3            [1]
                                   2            [1]
                                   1            [1]
                                   0            

ff: found legal plan as follows

step    0: GOTO TRUCK4 STORAGE3 WORKSHOP3
        1: GOTO TRUCK1 STORAGE0 WORKSHOP3
        2: GOTO CAR4 STORAGE3 NODE0
        3: GOTO MOTORCYCLE4 STORAGE3 WORKSHOP3
        4: GATHER CAR4 ITEM0 NODE0
        5: GOTO CAR4 NODE0 NODE2
        6: GATHER CAR4 ITEM1 NODE2
        7: GOTO CAR4 NODE2 NODE1
        8: GATHER CAR4 ITEM2 NODE1
        9: GOTO CAR4 NODE1 NODE4
       10: GATHER CAR4 ITEM3 NODE4
       11: GOTO CAR4 NODE4 NODE3
       12: GATHER CAR4 ITEM4 NODE3
       13: GOTO CAR4 NODE3 WORKSHOP3
       14: PREP_ASSEMBLE_ITEM9_FINALISE_WORKSHOP WORKSHOP3
       15: GOTO TRUCK4 WORKSHOP3 WORKSHOP2
       16: PREP_ASSEMBLE_ITEM9_ARRANGE_ROLES TRUCK1 MOTORCYCLE4 WORKSHOP3
       17: GOTO MOTORCYCLE3 STORAGE2 WORKSHOP2
       18: PREP_ASSEMBLE_ITEM6_FINALISE_WORKSHOP WORKSHOP2
       19: PREP_ASSEMBLE_ITEM7_FINALISE_WORKSHOP WORKSHOP1
       20: PREP_ASSEMBLE_ITEM6_ARRANGE_ROLES TRUCK4 MOTORCYCLE3 WORKSHOP2
       21: GOTO MOTORCYCLE2 STORAGE1 WORKSHOP1
       22: GOTO CAR4 WORKSHOP3 WORKSHOP2
       23: PREP_ASSEMBLE_ITEM6_ARRANGE_ITEM0 CAR4 WORKSHOP2
       24: PREP_ASSEMBLE_ITEM6_ARRANGE_ITEM1 CAR4 WORKSHOP2
       25: PREP_ASSEMBLE_ITEM6_ARRANGE_ITEM2 CAR4 WORKSHOP2
       26: PREP_ASSEMBLE_ITEM6_ARRANGE_ITEM3 CAR4 WORKSHOP2
       27: PREP_ASSEMBLE_ITEM6_ARRANGE_ITEM4 CAR4 WORKSHOP2
       28: ASSEMBLE_I6_RESOURCES_AQUIRED
       29: ASSEMBLE_I6_MOTORCYCLE MOTORCYCLE3
       30: CONSUME_ITEM0_ASSEMBLE_I6 CAR4
       31: GOTO CAR4 WORKSHOP2 NODE0
       32: GATHER CAR4 ITEM0 NODE0
       33: GOTO CAR4 NODE0 WORKSHOP1
       34: PREP_ASSEMBLE_ITEM7_ARRANGE_ITEM0 CAR4 WORKSHOP1
       35: PREP_ASSEMBLE_ITEM7_ARRANGE_ITEM1 CAR4 WORKSHOP1
       36: PREP_ASSEMBLE_ITEM7_ARRANGE_ITEM2 CAR4 WORKSHOP1
       37: PREP_ASSEMBLE_ITEM7_ARRANGE_ITEM3 CAR4 WORKSHOP1
       38: PREP_ASSEMBLE_ITEM7_ARRANGE_ITEM4 CAR4 WORKSHOP1
       39: CONSUME_ITEM1_ASSEMBLE_I6 CAR4
       40: GOTO CAR4 WORKSHOP1 NODE2
       41: GATHER CAR4 ITEM1 NODE2
       42: GOTO CAR4 NODE2 WORKSHOP1
       43: CONSUME_ITEM2_ASSEMBLE_I6 CAR4
       44: GOTO CAR4 WORKSHOP1 NODE1
       45: GATHER CAR4 ITEM2 NODE1
       46: GOTO CAR4 NODE1 WORKSHOP1
       47: CONSUME_ITEM3_ASSEMBLE_I6 CAR4
       48: GOTO CAR4 WORKSHOP1 NODE4
       49: GATHER CAR4 ITEM3 NODE4
       50: GOTO CAR4 NODE4 WORKSHOP1
       51: CONSUME_ITEM4_ASSEMBLE_I6 CAR4
       52: POST_ASSEMBLE_I6_FREEUP_EVERYTHING TRUCK4 MOTORCYCLE3 WORKSHOP3
       53: GOTO MOTORCYCLE3 WORKSHOP2 WORKSHOP3
       54: RELEASE_ASSEMBLED_ITEM6 MOTORCYCLE3
       55: PREP_ASSEMBLE_ITEM9_ARRANGE_ITEM6 MOTORCYCLE3 WORKSHOP3
       56: GOTO CAR4 WORKSHOP1 NODE3
       57: GATHER CAR4 ITEM4 NODE3
       58: GOTO CAR4 NODE3 WORKSHOP1
       59: GOTO CAR4 WORKSHOP1 WORKSHOP3
       60: PREP_ASSEMBLE_ITEM9_ARRANGE_ITEM0 CAR4 WORKSHOP3
       61: GOTO CAR3 STORAGE2 WORKSHOP1
       62: PREP_ASSEMBLE_ITEM7_ARRANGE_ROLES CAR3 MOTORCYCLE2 WORKSHOP1
       63: ASSEMBLE_I7_RESOURCES_AQUIRED
       64: ASSEMBLE_I7_MOTORCYCLE MOTORCYCLE2
       65: CONSUME_ITEM2_ASSEMBLE_I7 CAR4
       66: CONSUME_ITEM3_ASSEMBLE_I7 CAR4
       67: PREP_ASSEMBLE_ITEM9_ARRANGE_ITEM1 CAR4 WORKSHOP3
       68: PREP_ASSEMBLE_ITEM9_ARRANGE_ITEM4 CAR4 WORKSHOP3
       69: CONSUME_ITEM0_ASSEMBLE_I7 CAR4
       70: GOTO CAR4 WORKSHOP3 NODE0
       71: GATHER CAR4 ITEM0 NODE0
       72: CONSUME_ITEM1_ASSEMBLE_I7 CAR4
       73: GOTO CAR4 NODE0 NODE2
       74: GATHER CAR4 ITEM1 NODE2
       75: CONSUME_ITEM4_ASSEMBLE_I7 CAR4
       76: POST_ASSEMBLE_I7_FREEUP_EVERYTHING CAR3 MOTORCYCLE2 WORKSHOP3
       77: GOTO MOTORCYCLE2 WORKSHOP1 WORKSHOP3
       78: GOTO CAR4 NODE2 NODE3
       79: GATHER CAR4 ITEM4 NODE3
       80: RELEASE_ASSEMBLED_ITEM7 MOTORCYCLE2
       81: PREP_ASSEMBLE_ITEM9_ARRANGE_ITEM7 MOTORCYCLE2 WORKSHOP3
       82: ASSEMBLE_I9_RESOURCES_AQUIRED
       83: ASSEMBLE_I9_TRUCK TRUCK1
       84: CONSUME_ITEM0_ASSEMBLE_I9 CAR4
       85: CONSUME_ITEM1_ASSEMBLE_I9 CAR4
       86: CONSUME_ITEM6_ASSEMBLE_I9 MOTORCYCLE3
       87: CONSUME_ITEM7_ASSEMBLE_I9 MOTORCYCLE2
       88: CONSUME_ITEM4_ASSEMBLE_I9 CAR4
       89: POST_ASSEMBLE_I9_FREEUP_EVERYTHING TRUCK1 MOTORCYCLE4 WORKSHOP3
       90: RELEASE_ASSEMBLED_ITEM9 TRUCK1
     

time spent:    0.04 seconds instantiating 173455 easy, 5384 hard action templates
               0.07 seconds reachability analysis, yielding 1449 facts and 67897 actions
               0.09 seconds creating final representation with 1030 relevant facts, 248 relevant fluents
               0.34 seconds computing LNF
               0.38 seconds building connectivity graph
            1846.91 seconds searching, evaluating 13885 states, to a max depth of 8
            1847.83 seconds total time
```
