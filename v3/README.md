# Version 3.0: Using metric

This adds minimization on total cost of the plan:

```
(:metric minimize (total-cost))
```

We tried Metric-FF and Madagascar.


## Metric-FF

Unfortunately, Metric-FF with optimisation (`-O`) crashes:

```
[ssardina@Thinkpad-X1 v3]$ ~/git/soft/planning/ff-planners.git/Metric-FF-v1.0/ff -o domain.pddl -f problem.pddl -O 

ff: parsing domain file
domain 'AGENTS-IN-THE-CITY' defined
 ... done.
ff: parsing problem file
problem 'COMPLETE-JOBS' defined
 ... done.

Segmentation fault
```


Otherwise it works, but no minimization is actually performed:


```
[ssardina@Thinkpad-X1 v3]$ ~/git/soft/planning/ff-planners.git/Metric-FF-v1.0/ff -o domain.pddl -f problem.pddl

ff: parsing domain file
domain 'AGENTS-IN-THE-CITY' defined
 ... done.
ff: parsing problem file
problem 'COMPLETE-JOBS' defined
 ... done.



no optimization required. skipping criterion.


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
                                  46            [1][2][3][4][5][6][7][8]
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

step    0: GOTO CAR4 STORAGE3 NODE1
        1: GOTO TRUCK4 STORAGE3 WORKSHOP3
        2: GOTO TRUCK1 STORAGE0 WORKSHOP3
        3: GATHER CAR4 ITEM2 NODE1
        4: GOTO CAR4 NODE1 NODE4
        5: GATHER CAR4 ITEM3 NODE4
        6: GOTO CAR4 NODE4 NODE0
        7: GOTO MOTORCYCLE4 STORAGE3 WORKSHOP3
        8: GATHER CAR4 ITEM0 NODE0
        9: GOTO CAR4 NODE0 NODE2
       10: GATHER CAR4 ITEM1 NODE2
       11: GOTO CAR4 NODE2 NODE3
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
       79: RELEASE_ASSEMBLED_ITEM7 MOTORCYCLE2
       80: PREP_ASSEMBLE_ITEM9_ARRANGE_ITEM7 MOTORCYCLE2 WORKSHOP3
       81: ASSEMBLE_I9_RESOURCES_AQUIRED
       82: ASSEMBLE_I9_TRUCK TRUCK1
       83: GATHER CAR4 ITEM4 NODE3
       84: CONSUME_ITEM0_ASSEMBLE_I9 CAR4
       85: CONSUME_ITEM1_ASSEMBLE_I9 CAR4
       86: ONSUME_ITEM6_ASSEMBLE_I9 MOTORCYCLE3
       87: CONSUME_ITEM7_ASSEMBLE_I9 MOTORCYCLE2
       88: CONSUME_ITEM4_ASSEMBLE_I9 CAR4
       89: POST_ASSEMBLE_I9_FREEUP_EVERYTHING TRUCK1 MOTORCYCLE4 WORKSHOP3
       90: RELEASE_ASSEMBLED_ITEM9 TRUCK1
     

time spent:    0.03 seconds instantiating 173455 easy, 5384 hard action templates
               0.10 seconds reachability analysis, yielding 1923 facts and 62697 actions
               0.04 seconds creating final representation with 1356 relevant facts, 1 relevant fluents
               0.17 seconds computing LNF
               2.61 seconds building connectivity graph
             992.40 seconds searching, evaluating 13865 states, to a max depth of 8
             995.35 seconds total time
```



## Madagascar (SAT-based)


```
Madagascar 0.99999 25/02/2015 09:46:27 amd64 1-core (no VSIDS)
Options: file:../agents-in-the-city/v3/domain.pddl file:../agents-in-the-city/v3/problem.pddl
Domain: agents-in-the-city
Problem: complete-jobs
Parser: 176367 ground actions and 1962 state variables
Invariants: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17  1.22 secs
Goal: conjunctive
Simplified: 57321 ground actions and 1097 state variables
Actions: general
Disabling graph %: 10 20 30 40 50 60 70 80 90 100 0.49 secs (max SCC size 42256)
Plan type: E-step
    Allocated 32 MB permanent (total 680 MB)
Horizon 0: 1097 variables
0 UNSAT (0 decisions 0 conflicts)
Horizon 5: 807607 variables
5 UNSAT (0 decisions 0 conflicts)
Horizon 10: 1614117 variables
10 UNSAT (0 decisions 0 conflicts)
Horizon 15: 2420627 variables
    Allocated 32 MB (total 1364 MB)
SAT (1945 decisions 18 conflicts)
PLAN FOUND: 15 steps

112 actions in the plan.
Cost of the plan is 190.
total time 41.85 preprocess 2.48 
total size 1.934 GB
max. learned clause length 303
t val conflicts decisions
0 0 0 0
5 0 0 0
10 0 0 0
15 1 18 1945
```

## Plan ouput on Madagascar Mp (SAT Planner)

```
STEP 0:
    goto(car1,storage0,node9)
    goto(car2,storage1,node10)
    goto(car3,storage2,workshop0)
    goto(car4,storage3,node7)
    goto(drone1,storage0,node4)
    goto(drone2,storage1,node3)
    goto(drone3,storage2,node0)
    goto(drone4,storage3,node0)
    goto(motorcycle1,storage0,node9)
    goto(motorcycle2,storage1,workshop2)
    goto(motorcycle3,storage2,workshop0)
    goto(motorcycle4,storage3,node7)
    goto(truck1,storage0,node8)
    goto(truck2,storage1,node4)
    goto(truck3,storage2,workshop2)
    goto(truck4,storage3,workshop2)
    prep_assemble_item6_finalise_workshop(workshop2)
    prep_assemble_item7_finalise_workshop(workshop0)


STEP 1.0:
    gather(car1,item2,node9)
    gather(car2,item4,node10)
    gather(car4,item1,node7)
    gather(drone1,item3,node4)
    gather(drone2,item4,node3)
    gather(drone3,item0,node0)
    gather(drone4,item0,node0)
    gather(motorcycle1,item2,node9)
    gather(motorcycle4,item1,node7)
    gather(truck1,item1,node8)
    gather(truck2,item3,node4)
    goto(truck3,workshop2,node0)
    prep_assemble_item6_arrange_roles(truck4,motorcycle2,workshop2)
    prep_assemble_item7_arrange_roles(car3,motorcycle3,workshop0)


STEP 1.1:
    goto(car1,node9,workshop0)
    goto(car2,node10,workshop0)
    goto(car4,node7,workshop0)
    goto(drone1,node4,workshop2)
    goto(drone2,node3,workshop2)
    goto(drone3,node0,workshop0)
    goto(drone4,node0,workshop2)
    goto(motorcycle1,node9,workshop2)
    goto(motorcycle4,node7,workshop2)
    goto(truck1,node8,workshop2)
    goto(truck2,node4,workshop0)


STEP 2.0:

    give(motorcycle4,drone2,item1,workshop2)
    goto(truck3,node0,workshop2)
    prep_assemble_item6_arrange_item0(drone4,workshop2)
    prep_assemble_item6_arrange_item1(truck1,workshop2)
    prep_assemble_item6_arrange_item2(motorcycle1,workshop2)
    prep_assemble_item6_arrange_item3(drone1,workshop2)
    prep_assemble_item7_arrange_item0(drone3,workshop0)
    prep_assemble_item7_arrange_item1(car4,workshop0)
    prep_assemble_item7_arrange_item2(car1,workshop0)
    prep_assemble_item7_arrange_item3(truck2,workshop0)
    prep_assemble_item7_arrange_item4(car2,workshop0)

STEP 2.1:


    goto(motorcycle4,workshop2,node8)
    prep_assemble_item6_arrange_item4(drone2,workshop2)


STEP 3:

    assemble_i6_resources_aquired() assemble_i7_resources_aquired()
    goto(motorcycle4,node8,workshop2)
    goto(truck3,workshop2,node8)


STEP 4:

    assemble_i6_truck(truck4) assemble_i7_motorcycle(motorcycle3)
    goto(motorcycle4,workshop2,node0)
    goto(truck3,node8,workshop2)


STEP 5.0:


    consume_item0_assemble_i6(drone4)
    consume_item0_assemble_i7(drone3)
    consume_item1_assemble_i6(truck1)
    consume_item1_assemble_i7(car4)
    consume_item2_assemble_i6(motorcycle1)
    consume_item2_assemble_i7(car1)
    consume_item3_assemble_i6(drone1)
    consume_item3_assemble_i7(truck2)
    consume_item4_assemble_i6(drone2)
    consume_item4_assemble_i7(car2)
    gather(motorcycle4,item0,node0)
    goto(truck3,workshop2,node10)


STEP 5.1:


    goto(motorcycle4,node0,workshop2)

STEP 6.0:


    gather(truck3,item4,node10)
    give(drone2,truck1,item1,workshop2)
    give(motorcycle4,drone2,item0,workshop2)
    goto(drone1,workshop2,node4)
    post_assemble_i6_freeup_everything(truck4,motorcycle2,workshop0)
    post_assemble_i7_freeup_everything(car3,motorcycle3,workshop2)


STEP 6.1:


    goto(truck1,workshop2,workshop0)
    goto(truck3,node10,node4)


STEP 7.0:

    give(truck1,car3,item1,workshop0) 
    give(truck3,drone1,item4,node4)
    goto(motorcycle3,workshop0,workshop2)
    prep_assemble_item9_finalise_workshop(workshop2) 
    release_assembled_item6(truck4) 
    release_assembled_item7(motorcycle3)


STEP 7.1:

    goto(car3,workshop0,workshop2)
    goto(drone1,node4,workshop2)
    goto(truck1,workshop0,node4)
    goto(truck3,node4,workshop2)


STEP 8:

    prep_assemble_item9_arrange_item0(drone2,workshop2)
    prep_assemble_item9_arrange_item1(car3,workshop2)
    prep_assemble_item9_arrange_item4(drone1,workshop2)
    prep_assemble_item9_arrange_item6(truck4,workshop2)
    prep_assemble_item9_arrange_item7(motorcycle3,workshop2)
    prep_assemble_item9_arrange_roles(truck3,motorcycle2,workshop2)


STEP 9:

    assemble_i9_resources_aquired()


STEP 10:

    assemble_i9_motorcycle(motorcycle2)


STEP 11:


    consume_item0_assemble_i9(drone2)
    consume_item1_assemble_i9(car3)
    consume_item4_assemble_i9(drone1)
    consume_item6_assemble_i9(truck4)
    consume_item7_assemble_i9(motorcycle3)


STEP 12:
    post_assemble_i9_freeup_everything(truck3,motorcycle2,workshop0)


STEP 13:

    goto(motorcycle2,workshop2,node4) 
    release_assembled_item9(motorcycle2)


STEP 14:

    give(motorcycle2,truck1,item9,node4)
```


