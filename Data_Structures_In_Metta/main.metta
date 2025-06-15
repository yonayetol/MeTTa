

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Binary Search Tree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(: BinTree (-> $value Type))

(: End (BinTree $value) )

(: ConsBinTree (-> $value (BinTree $value) (BinTree $value) (BinTree $value) ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; functions in Binary Search Tree  ;;;;;;;;;;;;;;;;;;;;

; 1. insert val into the tree 
; 2. height of the tree
; 3. count-nodes
; 4. find minimum
; 5. find maximum
; 6. delete nodes



;;;;;;;;;;;;;;;;;;; 1. insert ;;;;;;;;;;;;;;;;;;;;;;;;;;

(= (insert $new_value End) (ConsBinTree $new_value End End))

( = (insert $new_value (ConsBinTree $value $left $right)) 
    
    (if (> $value $new_value)
        (ConsBinTree $value (insert $new_value $left) $right)
        (ConsBinTree $value $left (insert $new_value $right))
    )
)

; !(insert 6 (ConsBinTree 5 (ConsBinTree 4 End End) (ConsBinTree 8 End End))) 




;;;;;;;;;;;;;;;;;;; 2. height ;;;;;;;;;;;;;;;;;;;;;;;;;;

( = (height End) 0)
( = (height (ConsBinTree $value $left $right)) (
    + 1 (max-atom ((height $left) (height $right)))
))

; !(height (ConsBinTree 5 (ConsBinTree 4 End End) (ConsBinTree 8 (ConsBinTree 6 End End) End)))




;;;;;;;;;;;;;;; 3. count how many nodes are there in the tree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

( = (count-nodes End) 0)
( = (count-nodes (ConsBinTree $value $left $right)) (+ 1 (
    + (count-nodes $left) (count-nodes $right)
)
)
)

; !(count-nodes (ConsBinTree 5 (ConsBinTree 4 End End) (ConsBinTree 8 (ConsBinTree 6 End End) End)))




;;;;;;;;;;;;;;;;;;; 4. find minimum ;;;;;;;;;;;;;;;;;;;;;;;;;;

( = (min-finder (ConsBinTree $value $left $right) ) (
    if (== $left End)
        $value
        (min-finder $left)
))

; !(min-finder (ConsBinTree 5 (ConsBinTree 4 End End) (ConsBinTree 8 (ConsBinTree 6 End End) End)))




;;;;;;;;;;;;;;;;;;; 5. find maximum ;;;;;;;;;;;;;;;;;;;;;;;;;;


( = (max-finder (ConsBinTree $value $left $right) ) (
    if (== $right End)
    $value
    (max-finder $right)
))

; !(max-finder (ConsBinTree 5 (ConsBinTree 4 End End) (ConsBinTree 8 (ConsBinTree 6 End End) End)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 6. delete nodes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; first let's define a function that might serve in delete function ;;

( = (pop-the-last (ConsBinTree $value $left $right)) (
    if (== $left End)
        End
        (ConsBinTree $value (pop-the-last $left) $right)
))

( = (delete $del_val (ConsBinTree $value $left $right) ) (
    if (> $value $del_val)
        (ConsBinTree $value (delete $del_val $left) $right)
        (
            if (< $value $del_val)
                (ConsBinTree $value $left (delete $del_val $right))
                ;;; here is what we are gonna delete
                (
                    if (== $left End)
                        $right
                        (
                            if (== $right End)
                                $left
                                (
                                    ;; here is when the node that we are gonna delete has 2 children
                                    ;; find the min value from right part of the node
                                    ;; get the corrected tree of the right
                                    ConsBinTree (min-finder $right) $left (pop-the-last $right)
                                )
                        )
                )
        )
    )
)

; !(delete 5 (ConsBinTree 5 (ConsBinTree 4 End End) (ConsBinTree 8 (ConsBinTree 6 End End) End)))
