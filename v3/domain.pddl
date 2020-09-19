(define (domain agents-in-the-city)

(:requirements :strips :typing)

(:types ; enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    item agent faciltiy
    truck motorcycle drone car - agent
    workshop storage resourceNode shop - facility
)

(:functions
    (distance ?from - facility ?to - facility)
    (total-cost)
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    (item-in-resourceNode ?i - item ?rn - resourceNode) ; item i is in respource node rn
    (agent-at-facility ?a - agent ?f - facility)  ; agent is at facility l
    (agent-carrying-item ?a - agent ?i - item)  ; agent is carrying item i
    (item-in-storage ?i - item ?s - storage)  ; item is in storage
    (workshop-busy ?w - workshop)
    (agent-busy ?a - agent)
    (agent-commited ?a - agent ?i - item)  ; agent commited to assembly
    (workshop-allocated ?w - workshop ?i - item)
    (item-arranged-for-assembly ?i1 ?i2 - item) ; i1 - item required, i2 - item being assembled
    (agent-providing-item-for-assembly ?a - agent ?item_required ?item_assembled - item)
    (required-roles-arranged-for-assembly ?i - item) ; i - item to be assembled, w - workshop at which required roles are present
    (item-assembled ?i - item)
    (assemble-main-guy ?a - agent ?i - item) ; a - the agent who gets the item, i - item being assembled
    (assembly-procedure-complete ?i - item) ;  - item that got assembled and everythong is complete
    (assembly-item-consumed ?i1 ?i2 - item) ; i1 - item being condumed i2 - item being assembled
    (assembly-resources-acquired ?item_being_assembled - item)
    (assembly-lock ?item_being_assembled) ; to stop from repeated assembly on same items
    (assembly-required-agent ?a - agent ?i - item)
    
)

(:action give
    :parameters (?a1 ?a2 - agent ?i - item ?f - facility)
    :precondition (and 
        (agent-carrying-item ?a1 ?i)
        (agent-at-facility ?a1 ?f)
        (agent-at-facility ?a2 ?f)
        (not (agent-carrying-item ?a2 ?i))
        (not (agent-busy ?a1))
        (not (agent-busy ?a2))
        (not (assembly-required-agent ?a1 item5))
        (not (assembly-required-agent ?a2 item5))
        (not (assembly-required-agent ?a1 item6))
        (not (assembly-required-agent ?a2 item6))
        (not (assembly-required-agent ?a1 item7))
        (not (assembly-required-agent ?a2 item7))
        (not (assembly-required-agent ?a1 item8))
        (not (assembly-required-agent ?a2 item8))
        (not (assembly-required-agent ?a1 item9))
        (not (assembly-required-agent ?a2 item9))
        (not (assembly-required-agent ?a1 item10))
        (not (assembly-required-agent ?a2 item10))
    )
    :effect (and 
        (not (agent-carrying-item ?a1 ?i))
        (agent-carrying-item ?a2 ?i)
        (increase (total-cost) 10)
    )
)


; take an item from agent and add it to the storage
(:action store
    :parameters (?a - agent ?s - storage ?i - item)
    :precondition (and 
        (agent-carrying-item ?a ?i)
        (agent-at-facility ?a ?s)
        (not (agent-busy ?a))
        (not (assembly-required-agent ?a item5))
        (not (assembly-required-agent ?a item6))
        (not (assembly-required-agent ?a item7))
        (not (assembly-required-agent ?a item8))
        (not (assembly-required-agent ?a item9))
        (not (assembly-required-agent ?a item10))
    )
    :effect (and 
        (not (agent-carrying-item ?a ?i))
        (item-in-storage ?i ?s)
        (increase (total-cost) 1)
    )
)

; item taken by an agent from a resource node
(:action gather
    :parameters (?a - agent ?i - item ?n - resourceNode)
    :precondition (and 
        (item-in-resourceNode ?i ?n)
        (agent-at-facility ?a ?n)
        (not (agent-busy ?a))
        (not (assembly-required-agent ?a item5))
        (not (assembly-required-agent ?a item6))
        (not (assembly-required-agent ?a item7))
        (not (assembly-required-agent ?a item8))
        (not (assembly-required-agent ?a item9))
        (not (assembly-required-agent ?a item10))
    )
    :effect (and 
        (agent-carrying-item ?a ?i)
        (increase (total-cost) 10)
    )
)


(:action goto
    :parameters (?a - agent ?loc1 ?loc2 - facility)
    :precondition (and 
        (agent-at-facility ?a ?loc1)    
        (not (= ?loc1 ?loc2))
        (not (agent-busy ?a))
        (not (assembly-required-agent ?a item5))
        (not (assembly-required-agent ?a item6))
        (not (assembly-required-agent ?a item7))
        (not (assembly-required-agent ?a item8))
        (not (assembly-required-agent ?a item9))
        (not (assembly-required-agent ?a item10))
    )
    :effect (and 
        (agent-at-facility ?a ?loc2)
        (not (agent-at-facility ?a ?loc1))
        (increase (total-cost) (distance ?loc1 ?loc2))
    )
)
; item(item5, 5, roles([car, drone]), parts([item1, item4]))
; finalise the workshop for assembly of item 5
(:action prep_assemble_item5_finalise_workshop
    :parameters (?w - workshop)
    :precondition (and 
        (not (workshop-busy ?w))
        (not (assembly-lock item5))
    )
    :effect (and 
        (workshop-busy ?w)
        (workshop-allocated ?w item5)
        (assembly-lock item5)
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 1 for assembly
(:action prep_assemble_item5_arrange_item1
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (agent-commited ?a item5) (not (agent-busy ?a)))
        (not (item-arranged-for-assembly item1 item5))
        (workshop-allocated ?w item5)
        (assembly-lock item5)
        (agent-carrying-item ?a item1)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item1 item5)
        (agent-providing-item-for-assembly ?a item1 item5)
        (agent-busy ?a)
        (agent-commited ?a item5)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 4 for assembly
(:action prep_assemble_item5_arrange_item4
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (agent-commited ?a item5) (not (agent-busy ?a)))
        (not (item-arranged-for-assembly item4 item5))

        (workshop-allocated ?w item5)
        (assembly-lock item5)
        (agent-carrying-item ?a item4)
    )
    :effect (and 
        (item-arranged-for-assembly item4 item5)
        (agent-providing-item-for-assembly ?a item4 item5)
        (agent-busy ?a)
        (agent-commited ?a item5) 
        (increase (total-cost) 1)
    )
)

; when workshop is fixed and item has reached...make sure required roles are there
(:action prep_assemble_item5_arrange_roles
    :parameters (?c - car ?d - drone ?w - workshop)
    :precondition (and 
        (or (agent-commited ?c item5) (not (agent-busy ?c)))
        (or (agent-commited ?d item5) (not (agent-busy ?d)))
        (assembly-lock item5)

        (not (required-roles-arranged-for-assembly item5))
        (workshop-allocated ?w item5)
   
        (agent-at-facility ?c ?w)
        (agent-at-facility ?d ?w)
    )
    :effect (and 
        (required-roles-arranged-for-assembly item5)
        (assembly-required-agent ?c item5)
        (assembly-required-agent ?d item5)
        (agent-commited ?c item5)
        (agent-commited ?d item5)
        (agent-busy ?c)
        (agent-busy ?d)
        (increase (total-cost) 1)
    )
)

(:action assemble_i5_resources_aquired
    :parameters ()
    :precondition (and 
        (assembly-lock item5)
        (not (assembly-resources-acquired item5))

        (item-arranged-for-assembly item1 item5)
        (item-arranged-for-assembly item4 item5)

        (required-roles-arranged-for-assembly item5)
    )
    :effect (and 
        (assembly-resources-acquired item5)
        (increase (total-cost) 1)
    )
)

(:action assemble_i5_car
    :parameters (?c - car)
    :precondition (and
        (assembly-lock item5)
        (assembly-resources-acquired item5)
        (agent-commited ?c item5) 
        (not (item-assembled item5))
        (assembly-required-agent ?c item5)
    )
    :effect (and 
        (item-assembled item5)  
        (assemble-main-guy ?c item5)
        (increase (total-cost) 1)
    )
)


(:action assemble_i5_drone
    :parameters (?d - drone)
    :precondition (and 
        (not (item-assembled item5))
        (assembly-resources-acquired item5) 
        (assembly-lock item5)
        (agent-commited ?d item5)
        (assembly-required-agent ?d item5)
    )
    :effect (and 
        (item-assembled item5)    
        (assemble-main-guy ?d item5)
        (increase (total-cost) 1)
    )
)

(:action consume_item1_assemble_i5
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item5)
        (item-assembled item5)
        (agent-carrying-item ?a item1)
        (agent-providing-item-for-assembly ?a item1 item5)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item1))
        (not (agent-commited ?a item5))
        (assembly-item-consumed item1 item5)
        (not (item-arranged-for-assembly item1 item5))
        (not (agent-providing-item-for-assembly ?a item1 item5))
        (increase (total-cost) 1)
    )
)

(:action consume_item4_assemble_i5
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item5)
        (item-assembled item5)
        (agent-carrying-item ?a item4)
        (agent-providing-item-for-assembly ?a item4 item5)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item4))
        (not (agent-commited ?a item5))
        (assembly-item-consumed item4 item5)
        (not (item-arranged-for-assembly item4 item5))
        (not (agent-providing-item-for-assembly ?a item4 item5))
        (increase (total-cost) 1)
    )
)

(:action post_assemble_i5_freeup_everything
    :parameters (?c - car ?d - drone ?w - workshop)
    :precondition (and 
        (assembly-lock item5)
        (assembly-item-consumed item1 item5)
        (assembly-item-consumed item4 item5)
        (assembly-required-agent ?c item5)
        (assembly-required-agent ?d item5)
    )
    :effect (and 
        (not (item-assembled item5))
        (not (agent-commited ?c item5))
        (not (agent-commited ?d item5))
        (not (agent-busy ?c))
        (not (agent-busy ?d))
        (not (required-roles-arranged-for-assembly item5))
        (not (workshop-allocated ?w item5))
        (not (workshop-busy ?w))

        (not (assembly-item-consumed item1 item5))
        (not (assembly-item-consumed item4 item5))

        (not (assembly-required-agent ?c item5))
        (not (assembly-required-agent ?d item5))

        (not (assembly-resources-acquired item5)) 

        (assembly-procedure-complete item5)
        (increase (total-cost) 1)
    )
)

(:action release_assembled_item5
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item5)
        (assembly-procedure-complete item5)
        (assemble-main-guy ?a item5)
    )
    :effect (and 
        (not (assemble-main-guy ?a item5))
        (agent-carrying-item ?a item5)
        (not (assembly-procedure-complete item5))
        (not (assembly-lock item5))
        (increase (total-cost) 1)
    )
)

; item(item6, 5, roles([truck, motorcycle]), parts([item2, item3, item0, item1, item4])).

; finalise the workshop for assembly of item 6
(:action prep_assemble_item6_finalise_workshop
    :parameters (?w - workshop)
    :precondition (and 
        (not (workshop-busy ?w))
        (not (assembly-lock item6))
    )
    :effect (and 
        (workshop-busy ?w)
        (workshop-allocated ?w item6)
        (assembly-lock item6)
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 0 for assembly
(:action prep_assemble_item6_arrange_item0
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (not (agent-busy ?a)) (agent-commited ?a item6))
        (not (item-arranged-for-assembly item0 item6))
        (workshop-allocated ?w item6)
        (assembly-lock item6)
        (agent-carrying-item ?a item0)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item0 item6)
        (agent-providing-item-for-assembly ?a item0 item6)   
        (agent-busy ?a)
        (agent-commited ?a item6) 
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 1 for assembly
(:action prep_assemble_item6_arrange_item1
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (agent-commited ?a item6) (not (agent-busy ?a)))
        (not (item-arranged-for-assembly item1 item6))
        (workshop-allocated ?w item6)
        (assembly-lock item6)
        (agent-carrying-item ?a item1)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item1 item6)
        (agent-providing-item-for-assembly ?a item1 item6)
        (agent-busy ?a)
        (agent-commited ?a item6)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 2 for assembly
(:action prep_assemble_item6_arrange_item2
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item6)
        (or (agent-commited ?a item6) (not (agent-busy ?a)))
        (workshop-allocated ?w item6)
        (not (item-arranged-for-assembly item2 item6))
        (agent-carrying-item ?a item2)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item2 item6)
        (agent-providing-item-for-assembly ?a item2 item6)
        (agent-busy ?a)
        (agent-commited ?a item6)
        (increase (total-cost) 1)    
    )
)

; once workshop has been finalised, get item 3 for assembly
(:action prep_assemble_item6_arrange_item3
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item6)
        (not (item-arranged-for-assembly item3 item6))
        (or (agent-commited ?a item6) (not (agent-busy ?a)))
        (workshop-allocated ?w item6)
        (agent-carrying-item ?a item3)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item3 item6)
        (agent-providing-item-for-assembly ?a item3 item6)
        (agent-busy ?a)
        (agent-commited ?a item6)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 4 for assembly
(:action prep_assemble_item6_arrange_item4
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item6)
        (not (item-arranged-for-assembly item4 item6))
        (or (agent-commited ?a item6) (not (agent-busy ?a)))
        (workshop-allocated ?w item6)
        (agent-carrying-item ?a item4)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item4 item6)
        (agent-providing-item-for-assembly ?a item4 item6)
        (agent-busy ?a)
        (agent-commited ?a item6) 
        (increase (total-cost) 1)
    )
)

; when workshop is fixed and item has reached...make sure required roles are there
(:action prep_assemble_item6_arrange_roles
    :parameters (?t - truck ?m - motorcycle ?w - workshop)
    :precondition (and 
        (assembly-lock item6)
        (or (agent-commited ?t item6) (not (agent-busy ?t)))
        (or (agent-commited ?m item6) (not (agent-busy ?m)))
       
        (workshop-allocated ?w item6)
        (not (required-roles-arranged-for-assembly item6))

        (agent-at-facility ?t ?w)
        (agent-at-facility ?m ?w)
    )
    :effect (and 
        (required-roles-arranged-for-assembly item6)
        (assembly-required-agent ?t item6)
        (assembly-required-agent ?m item6)
        (agent-commited ?t item6)
        (agent-commited ?m item6)
        (agent-busy ?t)
        (agent-busy ?m)
        (increase (total-cost) 1)
    )
)

(:action assemble_i6_resources_aquired
    :parameters ()
    :precondition (and 
        (assembly-lock item6)
        (not (assembly-resources-acquired item6))

        (item-arranged-for-assembly item0 item6)
        (item-arranged-for-assembly item1 item6)
        (item-arranged-for-assembly item2 item6)
        (item-arranged-for-assembly item3 item6)
        (item-arranged-for-assembly item4 item6)

        (required-roles-arranged-for-assembly item6)
    )
    :effect (and 
        (assembly-resources-acquired item6)
        (increase (total-cost) 1)
    )
)

(:action assemble_i6_truck
    :parameters (?t - truck)
    :precondition (and 
        (assembly-lock item6)
        (assembly-resources-acquired item6)
        (agent-commited ?t item6)
        (not (item-assembled item6))
        (assembly-required-agent ?t item6)
    )
    :effect (and 
        (item-assembled item6)    
        (assemble-main-guy ?t item6)
        (increase (total-cost) 1)
    )
)

(:action assemble_i6_motorcycle
    :parameters (?m - motorcycle)
    :precondition (and 
        (assembly-lock item6)
        (agent-commited ?m item6)
        (assembly-resources-acquired item6)
        (assembly-resources-acquired item6)  
        (assembly-required-agent ?m item6)
    )
    :effect (and 
        (item-assembled item6)     
        (assemble-main-guy ?m item6)
        (increase (total-cost) 1)
    )
)

(:action consume_item0_assemble_i6
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item6)
        (agent-providing-item-for-assembly ?a item0 item6)
        (item-assembled item6)
        (agent-carrying-item ?a item0)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item0))
        (not (agent-commited ?a item6))
        (assembly-item-consumed item0 item6)
        (not (item-arranged-for-assembly item0 item6))
        (not (agent-providing-item-for-assembly ?a item0 item6))
        (increase (total-cost) 1)
    )
)

(:action consume_item1_assemble_i6
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item6)
        (agent-providing-item-for-assembly ?a item1 item6)
        (item-assembled item6)
        (agent-carrying-item ?a item1)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item1))
        (not (agent-commited ?a item6))
        (assembly-item-consumed item1 item6)
        (not (item-arranged-for-assembly item1 item6))
        (not (agent-providing-item-for-assembly ?a item1 item6))
        (increase (total-cost) 1)
    )
)

(:action consume_item2_assemble_i6
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item6)
        (agent-providing-item-for-assembly ?a item2 item6)
        (item-assembled item6)
        (agent-carrying-item ?a item2)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item2))
        (not (agent-commited ?a item6))
        (assembly-item-consumed item2 item6)
        (not (item-arranged-for-assembly item2 item6))
        (not (agent-providing-item-for-assembly ?a item2 item6))
        (increase (total-cost) 1)
    )
)

(:action consume_item3_assemble_i6
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item6)
        (agent-providing-item-for-assembly ?a item3 item6)
        (item-assembled item6)
        (agent-carrying-item ?a item3)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item3))
        (not (agent-commited ?a item6))
        (assembly-item-consumed item3 item6)
        (not (item-arranged-for-assembly item3 item6))
        (not (agent-providing-item-for-assembly ?a item3 item6))
        (increase (total-cost) 1)
    )
)

(:action consume_item4_assemble_i6
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item6)
        (agent-providing-item-for-assembly ?a item4 item6)
        (item-assembled item6)
        (agent-carrying-item ?a item4)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item4))
        (not (agent-commited ?a item6))
        (assembly-item-consumed item4 item6)
        (not (item-arranged-for-assembly item4 item6))
        (not (agent-providing-item-for-assembly ?a item4 item6))
        (increase (total-cost) 1)
    )
)

(:action post_assemble_i6_freeup_everything
    :parameters (?t - truck ?m - motorcycle ?w - workshop)
    :precondition (and 
        (assembly-lock item6)

        (assembly-item-consumed item0 item6)
        (assembly-item-consumed item1 item6)
        (assembly-item-consumed item2 item6)
        (assembly-item-consumed item3 item6)
        (assembly-item-consumed item4 item6)

        (assembly-required-agent ?t item6)
        (assembly-required-agent ?m item6)
    )
    :effect (and 

        (not (item-assembled item6))
        (not (agent-commited ?t item6))
        (not (agent-commited ?m item6))
        (not (agent-busy ?t))
        (not (agent-busy ?m))
        (not (required-roles-arranged-for-assembly item6))
        (not (workshop-allocated ?w item6))
        (not (workshop-busy ?w))

        (not (assembly-item-consumed item0 item6))
        (not (assembly-item-consumed item1 item6))
        (not (assembly-item-consumed item2 item6))
        (not (assembly-item-consumed item3 item6))
        (not (assembly-item-consumed item4 item6))

        (not (assembly-required-agent ?t item6))
        (not (assembly-required-agent ?m item6))

        (assembly-procedure-complete item6)
        (increase (total-cost) 1)
    )
)

(:action release_assembled_item6
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item6)
        (assembly-procedure-complete item6)
        (assemble-main-guy ?a item6)
    )
    :effect (and 
        (agent-carrying-item ?a item6)
        (not (assemble-main-guy ?a item6))
        (not (assembly-procedure-complete item6))
        (not (assembly-lock item6))
        (increase (total-cost) 1)
    )
)

; item(item7, 5, roles([car, motorcycle]), parts([item2, item3, item0, item1, item4])).

; finalise the workshop for assembly of item 7
(:action prep_assemble_item7_finalise_workshop
    :parameters (?w - workshop)
    :precondition (and 
        (not (workshop-busy ?w))
        (not (assembly-lock item7))
    )
    :effect (and 
        (workshop-busy ?w)
        (workshop-allocated ?w item7)
        (assembly-lock item7)
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 0 for assembly
(:action prep_assemble_item7_arrange_item0
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (not (agent-busy ?a)) (agent-commited ?a item7))
        (not (item-arranged-for-assembly item0 item7))
        (workshop-allocated ?w item7)
        (assembly-lock item7)
        (agent-carrying-item ?a item0)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item0 item7)
        (agent-providing-item-for-assembly ?a item0 item7)   
        (agent-busy ?a)
        (agent-commited ?a item7)
        (increase (total-cost) 1) 
    )
)

; once workshop has been finalised, get item 1 for assembly
(:action prep_assemble_item7_arrange_item1
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (agent-commited ?a item7) (not (agent-busy ?a)))
        (not (item-arranged-for-assembly item1 item7))
        (workshop-allocated ?w item7)
        (assembly-lock item7)
        (agent-carrying-item ?a item1)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item1 item7)
        (agent-providing-item-for-assembly ?a item1 item7)
        (agent-busy ?a)
        (agent-commited ?a item7)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 2 for assembly
(:action prep_assemble_item7_arrange_item2
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item7)
        (or (agent-commited ?a item7) (not (agent-busy ?a)))
        (workshop-allocated ?w item7)
        (not (item-arranged-for-assembly item2 item7))
        (agent-carrying-item ?a item2)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item2 item7)
        (agent-providing-item-for-assembly ?a item2 item7)
        (agent-busy ?a)
        (agent-commited ?a item7)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 3 for assembly
(:action prep_assemble_item7_arrange_item3
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item7)
        (not (item-arranged-for-assembly item3 item7))
        (or (agent-commited ?a item7) (not (agent-busy ?a)))
        (workshop-allocated ?w item7)
        (agent-carrying-item ?a item3)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item3 item7)
        (agent-providing-item-for-assembly ?a item3 item7)
        (agent-busy ?a)
        (agent-commited ?a item7)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 4 for assembly
(:action prep_assemble_item7_arrange_item4
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item7)
        (not (item-arranged-for-assembly item4 item7))
        (or (agent-commited ?a item7) (not (agent-busy ?a)))
        (workshop-allocated ?w item7)
        (agent-carrying-item ?a item4)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item4 item7)
        (agent-providing-item-for-assembly ?a item4 item7)
        (agent-busy ?a)
        (agent-commited ?a item7) 
        (increase (total-cost) 1)
    )
)

; when workshop is fixed and item has reached...make sure required roles are there
(:action prep_assemble_item7_arrange_roles
    :parameters (?c - car ?m - motorcycle ?w - workshop)
    :precondition (and 
        (assembly-lock item7)
        (or (agent-commited ?c item7) (not (agent-busy ?c)))
        (or (agent-commited ?m item7) (not (agent-busy ?m)))
       
        (workshop-allocated ?w item7)
        (not (required-roles-arranged-for-assembly item7))

        (agent-at-facility ?c ?w)
        (agent-at-facility ?m ?w)
    )
    :effect (and 
        (required-roles-arranged-for-assembly item7)
        (assembly-required-agent ?c item7)
        (assembly-required-agent ?m item7)
        (agent-commited ?c item7)
        (agent-commited ?m item7)
        (agent-busy ?c)
        (agent-busy ?m)
        (increase (total-cost) 1)
    )
)

(:action assemble_i7_resources_aquired
    :parameters ()
    :precondition (and 
        (assembly-lock item7)
        (not (assembly-resources-acquired item7))

        (item-arranged-for-assembly item0 item7)
        (item-arranged-for-assembly item1 item7)
        (item-arranged-for-assembly item2 item7)
        (item-arranged-for-assembly item3 item7)
        (item-arranged-for-assembly item4 item7)

        (required-roles-arranged-for-assembly item7)
    )
    :effect (and 
        (assembly-resources-acquired item7)
        (increase (total-cost) 1)
    )
)

(:action assemble_i7_car
    :parameters (?c - car)
    :precondition (and 
        (assembly-lock item7)
        (assembly-resources-acquired item7)
        (agent-commited ?c item7)
        (not (item-assembled item7))
        (assembly-required-agent ?c item7)
    )
    :effect (and 
        (item-assembled item7)    
        (assemble-main-guy ?c item7)
        (increase (total-cost) 1)
    )
)

(:action assemble_i7_motorcycle
    :parameters (?m - motorcycle)
    :precondition (and 
        (assembly-lock item7)
        (agent-commited ?m item7)
        (assembly-resources-acquired item7)
        (assembly-resources-acquired item7)  
        (assembly-required-agent ?m item7)
    )
    :effect (and 
        (item-assembled item7)     
        (assemble-main-guy ?m item7)
        (increase (total-cost) 1)
    )
)

(:action consume_item0_assemble_i7
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item7)
        (agent-providing-item-for-assembly ?a item0 item7)
        (item-assembled item7)
        (agent-carrying-item ?a item0)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item0))
        (not (agent-commited ?a item7))
        (assembly-item-consumed item0 item7)
        (not (item-arranged-for-assembly item0 item7))
        (not (agent-providing-item-for-assembly ?a item0 item7))
        (increase (total-cost) 1)
    )
)

(:action consume_item1_assemble_i7
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item7)
        (agent-providing-item-for-assembly ?a item1 item7)
        (item-assembled item7)
        (agent-carrying-item ?a item1)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item1))
        (not (agent-commited ?a item7))
        (assembly-item-consumed item1 item7)
        (not (item-arranged-for-assembly item1 item7))
        (not (agent-providing-item-for-assembly ?a item1 item7))
        (increase (total-cost) 1)
    )
)

(:action consume_item2_assemble_i7
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item7)
        (agent-providing-item-for-assembly ?a item2 item7)
        (item-assembled item7)
        (agent-carrying-item ?a item2)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item2))
        (not (agent-commited ?a item7))
        (assembly-item-consumed item2 item7)
        (not (item-arranged-for-assembly item2 item7))
        (not (agent-providing-item-for-assembly ?a item2 item7))
        (increase (total-cost) 1)
    )
)

(:action consume_item3_assemble_i7
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item7)
        (agent-providing-item-for-assembly ?a item3 item7)
        (item-assembled item7)
        (agent-carrying-item ?a item3)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item3))
        (not (agent-commited ?a item7))
        (assembly-item-consumed item3 item7)
        (not (item-arranged-for-assembly item3 item7))
        (not (agent-providing-item-for-assembly ?a item3 item7))
        (increase (total-cost) 1)
    )
)

(:action consume_item4_assemble_i7
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item7)
        (agent-providing-item-for-assembly ?a item4 item7)
        (item-assembled item7)
        (agent-carrying-item ?a item4)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item4))
        (not (agent-commited ?a item7))
        (assembly-item-consumed item4 item7)
        (not (item-arranged-for-assembly item4 item7))
        (not (agent-providing-item-for-assembly ?a item4 item7))
        (increase (total-cost) 1)
    )
)

(:action post_assemble_i7_freeup_everything
    :parameters (?c - car ?m - motorcycle ?w - workshop)
    :precondition (and 
        (assembly-lock item7)

        (assembly-item-consumed item0 item7)
        (assembly-item-consumed item1 item7)
        (assembly-item-consumed item2 item7)
        (assembly-item-consumed item3 item7)
        (assembly-item-consumed item4 item7)

        (assembly-required-agent ?c item7)
        (assembly-required-agent ?m item7)
    )
    :effect (and 

        (not (item-assembled item7))
        (not (agent-commited ?c item7))
        (not (agent-commited ?m item7))
        (not (agent-busy ?c))
        (not (agent-busy ?m))
        (not (required-roles-arranged-for-assembly item7))
        (not (workshop-allocated ?w item7))
        (not (workshop-busy ?w))

        (not (assembly-item-consumed item0 item7))
        (not (assembly-item-consumed item1 item7))
        (not (assembly-item-consumed item2 item7))
        (not (assembly-item-consumed item3 item7))
        (not (assembly-item-consumed item4 item7))

        (not (assembly-required-agent ?c item7))
        (not (assembly-required-agent ?m item7))

        (assembly-procedure-complete item7)
        (increase (total-cost) 1)
    )
)

(:action release_assembled_item7
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item7)
        (assembly-procedure-complete item7)
        (assemble-main-guy ?a item7)
    )
    :effect (and 
        (agent-carrying-item ?a item7)
        (not (assemble-main-guy ?a item7))
        (not (assembly-procedure-complete item7))
        (not (assembly-lock item7))
        (increase (total-cost) 1)
    )
)

; item(item8, 10, roles([car, drone]), parts([item0, item4]))

; finalise the workshop for assembly of item 8
(:action prep_assemble_item8_finalise_workshop
    :parameters (?w - workshop)
    :precondition (and 
        (not (workshop-busy ?w))
        (not (assembly-lock item8))
    )
    :effect (and 
        (workshop-busy ?w)
        (workshop-allocated ?w item8)
        (assembly-lock item8)
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 0 for assembly
(:action prep_assemble_item8_arrange_item0
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (not (agent-busy ?a)) (agent-commited ?a item8))
        (not (item-arranged-for-assembly item0 item8))
        (workshop-allocated ?w item8)
        (assembly-lock item8)
        (agent-carrying-item ?a item0)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item0 item8)
        (agent-providing-item-for-assembly ?a item0 item8)   
        (agent-busy ?a)
        (agent-commited ?a item8) 
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 4 for assembly
(:action prep_assemble_item8_arrange_item4
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item8)
        (not (item-arranged-for-assembly item4 item8))
        (or (agent-commited ?a item8) (not (agent-busy ?a)))
        (workshop-allocated ?w item8)
        (agent-carrying-item ?a item4)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item4 item8)
        (agent-providing-item-for-assembly ?a item4 item8)
        (agent-busy ?a)
        (agent-commited ?a item8) 
        (increase (total-cost) 1)
    )
)

; when workshop is fixed and item has reached...make sure required roles are there
(:action prep_assemble_item8_arrange_roles
    :parameters (?c - car ?d - drone ?w - workshop)
    :precondition (and 
        (assembly-lock item8)
        (or (agent-commited ?c item8) (not (agent-busy ?c)))
        (or (agent-commited ?d item8) (not (agent-busy ?d)))
       
        (workshop-allocated ?w item8)
        (not (required-roles-arranged-for-assembly item8))

        (agent-at-facility ?c ?w)
        (agent-at-facility ?d ?w)
    )
    :effect (and 
        (required-roles-arranged-for-assembly item8)
        (assembly-required-agent ?c item8)
        (assembly-required-agent ?d item8)
        (agent-commited ?c item8)
        (agent-commited ?d item8)
        (agent-busy ?c)
        (agent-busy ?d)
        (increase (total-cost) 1)
    )
)

(:action assemble_i8_resources_aquired
    :parameters ()
    :precondition (and 
        (assembly-lock item8)
        (not (assembly-resources-acquired item8))

        (item-arranged-for-assembly item0 item8)
        (item-arranged-for-assembly item4 item8)

        (required-roles-arranged-for-assembly item8)
    )
    :effect (and 
        (assembly-resources-acquired item8)
        (increase (total-cost) 1)
    )
)

(:action assemble_i8_car
    :parameters (?c - car)
    :precondition (and 
        (assembly-lock item8)
        (assembly-resources-acquired item8)
        (agent-commited ?c item8)
        (not (item-assembled item8))
        (assembly-required-agent ?c item8)
    )
    :effect (and 
        (item-assembled item8)    
        (assemble-main-guy ?c item8)
        (increase (total-cost) 1)
    )
)

(:action assemble_i8_drone
    :parameters (?d - drone)
    :precondition (and 
        (assembly-lock item8)
        (agent-commited ?d item8)
        (assembly-resources-acquired item8)
        (assembly-resources-acquired item8)  
        (assembly-required-agent ?d item8)
    )
    :effect (and 
        (item-assembled item8)     
        (assemble-main-guy ?d item8)
        (increase (total-cost) 1)
    )
)

(:action consume_item0_assemble_i8
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item8)
        (agent-providing-item-for-assembly ?a item0 item8)
        (item-assembled item8)
        (agent-carrying-item ?a item0)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item0))
        (not (agent-commited ?a item8))
        (assembly-item-consumed item0 item8)
        (not (item-arranged-for-assembly item0 item8))
        (not (agent-providing-item-for-assembly ?a item0 item8))
        (increase (total-cost) 1)
    )
)

(:action consume_item4_assemble_i8
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item8)
        (agent-providing-item-for-assembly ?a item4 item8)
        (item-assembled item8)
        (agent-carrying-item ?a item4)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item4))
        (not (agent-commited ?a item8))
        (assembly-item-consumed item4 item8)
        (not (item-arranged-for-assembly item4 item8))
        (not (agent-providing-item-for-assembly ?a item4 item8))
        (increase (total-cost) 1)
    )
)

(:action post_assemble_i8_freeup_everything
    :parameters (?c - car ?d - drone ?w - workshop)
    :precondition (and 
        (assembly-lock item8)

        (assembly-item-consumed item0 item8)
        (assembly-item-consumed item4 item8)

        (assembly-required-agent ?c item8)
        (assembly-required-agent ?d item8)
    )
    :effect (and 

        (not (item-assembled item8))
        (not (agent-commited ?c item8))
        (not (agent-commited ?d item8))
        (not (agent-busy ?c))
        (not (agent-busy ?d))
        (not (required-roles-arranged-for-assembly item8))
        (not (workshop-allocated ?w item8))
        (not (workshop-busy ?w))

        (not (assembly-item-consumed item0 item8))
        (not (assembly-item-consumed item4 item8))

        (not (assembly-required-agent ?c item8))
        (not (assembly-required-agent ?d item8))

        (assembly-procedure-complete item8)
        (increase (total-cost) 1)
    )
)

(:action release_assembled_item8
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item8)
        (assembly-procedure-complete item8)
        (assemble-main-guy ?a item8)
    )
    :effect (and 
        (agent-carrying-item ?a item8)
        (not (assemble-main-guy ?a item8))
        (not (assembly-procedure-complete item8))
        (not (assembly-lock item8))
        (increase (total-cost) 1)
    )
)

;  item(item9, 6, roles([truck, motorcycle]), parts([item6, item7, item0, item1, item4]))
; finalise the workshop for assembly of item 9
(:action prep_assemble_item9_finalise_workshop
    :parameters (?w - workshop)
    :precondition (and 
        (not (workshop-busy ?w))
        (not (assembly-lock item9))
    )
    :effect (and 
        (workshop-busy ?w)
        (workshop-allocated ?w item9)
        (assembly-lock item9)
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 0 for assembly
(:action prep_assemble_item9_arrange_item0
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (not (agent-busy ?a)) (agent-commited ?a item9))
        (not (item-arranged-for-assembly item0 item9))
        (workshop-allocated ?w item9)
        (assembly-lock item9)
        (agent-carrying-item ?a item0)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item0 item9)
        (agent-providing-item-for-assembly ?a item0 item9)   
        (agent-busy ?a)
        (agent-commited ?a item9) 
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 1 for assembly
(:action prep_assemble_item9_arrange_item1
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (or (agent-commited ?a item9) (not (agent-busy ?a)))
        (not (item-arranged-for-assembly item1 item9))
        (workshop-allocated ?w item9)
        (assembly-lock item9)
        (agent-carrying-item ?a item1)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item1 item9)
        (agent-providing-item-for-assembly ?a item1 item9)
        (agent-busy ?a)
        (agent-commited ?a item9)
        (increase (total-cost) 1)    
    )
)

; once workshop has been finalised, get item 6 for assembly
(:action prep_assemble_item9_arrange_item6
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item9)
        (or (agent-commited ?a item9) (not (agent-busy ?a)))
        (workshop-allocated ?w item9)
        (not (item-arranged-for-assembly item6 item9))
        (agent-carrying-item ?a item6)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item6 item9)
        (agent-providing-item-for-assembly ?a item6 item9)
        (agent-busy ?a)
        (agent-commited ?a item9)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 7 for assembly
(:action prep_assemble_item9_arrange_item7
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item9)
        (not (item-arranged-for-assembly item7 item9))
        (or (agent-commited ?a item9) (not (agent-busy ?a)))
        (workshop-allocated ?w item9)
        (agent-carrying-item ?a item7)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item7 item9)
        (agent-providing-item-for-assembly ?a item7 item9)
        (agent-busy ?a)
        (agent-commited ?a item9)    
        (increase (total-cost) 1)
    )
)

; once workshop has been finalised, get item 4 for assembly
(:action prep_assemble_item9_arrange_item4
    :parameters (?a - agent ?w - workshop)
    :precondition (and 
        (assembly-lock item9)
        (not (item-arranged-for-assembly item4 item9))
        (or (agent-commited ?a item9) (not (agent-busy ?a)))
        (workshop-allocated ?w item9)
        (agent-carrying-item ?a item4)
        (agent-at-facility ?a ?w)
    )
    :effect (and 
        (item-arranged-for-assembly item4 item9)
        (agent-providing-item-for-assembly ?a item4 item9)
        (agent-busy ?a)
        (agent-commited ?a item9)
        (increase (total-cost) 1) 
    )
)

; when workshop is fixed and item has reached...make sure required roles are there
(:action prep_assemble_item9_arrange_roles
    :parameters (?t - truck ?m - motorcycle ?w - workshop)
    :precondition (and 
        (assembly-lock item9)
        (or (agent-commited ?t item9) (not (agent-busy ?t)))
        (or (agent-commited ?m item9) (not (agent-busy ?m)))
       
        (workshop-allocated ?w item9)
        (not (required-roles-arranged-for-assembly item9))

        (agent-at-facility ?t ?w)
        (agent-at-facility ?m ?w)
    )
    :effect (and 
        (required-roles-arranged-for-assembly item9)
        (assembly-required-agent ?t item9)
        (assembly-required-agent ?m item9)
        (agent-commited ?t item9)
        (agent-commited ?m item9)
        (agent-busy ?t)
        (agent-busy ?m)
        (increase (total-cost) 1)
    )
)

(:action assemble_i9_resources_aquired
    :parameters ()
    :precondition (and 
        (assembly-lock item9)
        (not (assembly-resources-acquired item9))

        (item-arranged-for-assembly item0 item9)
        (item-arranged-for-assembly item1 item9)
        (item-arranged-for-assembly item6 item9)
        (item-arranged-for-assembly item7 item9)
        (item-arranged-for-assembly item4 item9)

        (required-roles-arranged-for-assembly item9)
    )
    :effect (and 
        (assembly-resources-acquired item9)
        (increase (total-cost) 1)
    )
)

(:action assemble_i9_truck
    :parameters (?t - truck)
    :precondition (and 
        (assembly-lock item9)
        (assembly-resources-acquired item9)
        (agent-commited ?t item9)
        (not (item-assembled item9))
        (assembly-required-agent ?t item9)
    )
    :effect (and 
        (item-assembled item9)    
        (assemble-main-guy ?t item9)
        (increase (total-cost) 1)
    )
)

(:action assemble_i9_motorcycle
    :parameters (?m - motorcycle)
    :precondition (and 
        (assembly-lock item9)
        (agent-commited ?m item9)
        (assembly-resources-acquired item9)
        (assembly-resources-acquired item9)  
        (assembly-required-agent ?m item9)
    )
    :effect (and 
        (item-assembled item9)     
        (assemble-main-guy ?m item9)
        (increase (total-cost) 1)
    )
)

(:action consume_item0_assemble_i9
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item9)
        (agent-providing-item-for-assembly ?a item0 item9)
        (item-assembled item9)
        (agent-carrying-item ?a item0)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item0))
        (not (agent-commited ?a item9))
        (assembly-item-consumed item0 item9)
        (not (item-arranged-for-assembly item0 item9))
        (not (agent-providing-item-for-assembly ?a item0 item9))
        (increase (total-cost) 1)
    )
)

(:action consume_item1_assemble_i9
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item9)
        (agent-providing-item-for-assembly ?a item1 item9)
        (item-assembled item9)
        (agent-carrying-item ?a item1)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item1))
        (not (agent-commited ?a item9))
        (assembly-item-consumed item1 item9)
        (not (item-arranged-for-assembly item1 item9))
        (not (agent-providing-item-for-assembly ?a item1 item9))
        (increase (total-cost) 1)
    )
)

(:action consume_item6_assemble_i9
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item9)
        (agent-providing-item-for-assembly ?a item6 item9)
        (item-assembled item9)
        (agent-carrying-item ?a item6)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item6))
        (not (agent-commited ?a item9))
        (assembly-item-consumed item6 item9)
        (not (item-arranged-for-assembly item6 item9))
        (not (agent-providing-item-for-assembly ?a item6 item9))
        (increase (total-cost) 1)
    )
)

(:action consume_item7_assemble_i9
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item9)
        (agent-providing-item-for-assembly ?a item7 item9)
        (item-assembled item9)
        (agent-carrying-item ?a item7)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item7))
        (not (agent-commited ?a item9))
        (assembly-item-consumed item7 item9)
        (not (item-arranged-for-assembly item7 item9))
        (not (agent-providing-item-for-assembly ?a item7 item9))
        (increase (total-cost) 1)
    )
)

(:action consume_item4_assemble_i9
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item9)
        (agent-providing-item-for-assembly ?a item4 item9)
        (item-assembled item9)
        (agent-carrying-item ?a item4)
    )
    :effect (and 
        (not (agent-busy ?a))
        (not (agent-carrying-item ?a item4))
        (not (agent-commited ?a item9))
        (assembly-item-consumed item4 item9)
        (not (item-arranged-for-assembly item4 item9))
        (not (agent-providing-item-for-assembly ?a item4 item9))
        (increase (total-cost) 1)
    )
)

(:action post_assemble_i9_freeup_everything
    :parameters (?t - truck ?m - motorcycle ?w - workshop)
    :precondition (and 
        (assembly-lock item9)

        (assembly-item-consumed item0 item9)
        (assembly-item-consumed item1 item9)
        (assembly-item-consumed item6 item9)
        (assembly-item-consumed item7 item9)
        (assembly-item-consumed item4 item9)

        (assembly-required-agent ?t item9)
        (assembly-required-agent ?m item9)
    )
    :effect (and 

        (not (item-assembled item9))
        (not (agent-commited ?t item9))
        (not (agent-commited ?m item9))
        (not (agent-busy ?t))
        (not (agent-busy ?m))
        (not (required-roles-arranged-for-assembly item9))
        (not (workshop-allocated ?w item9))
        (not (workshop-busy ?w))

        (not (assembly-item-consumed item0 item9))
        (not (assembly-item-consumed item1 item9))
        (not (assembly-item-consumed item6 item9))
        (not (assembly-item-consumed item7 item9))
        (not (assembly-item-consumed item4 item9))

        (not (assembly-required-agent ?t item9))
        (not (assembly-required-agent ?m item9))

        (assembly-procedure-complete item9)
        (increase (total-cost) 1)
    )
)

(:action release_assembled_item9
    :parameters (?a - agent)
    :precondition (and 
        (assembly-lock item9)
        (assembly-procedure-complete item9)
        (assemble-main-guy ?a item9)
    )
    :effect (and 
        (agent-carrying-item ?a item9)
        (not (assemble-main-guy ?a item9))
        (not (assembly-procedure-complete item9))
        (not (assembly-lock item9))
        (increase (total-cost) 1)
    )
)

)
