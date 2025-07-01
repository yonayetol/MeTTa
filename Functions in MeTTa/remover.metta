!(import! &self variable_identifier)
!(import! &self mainpy)

; !(GenerateVariable (any))

;; is-there function is a function that 
;; returns whether there is some wanted thing in the given given pattern or not

(: is-there (-> Expression Atom Bool) )

; base case
( = (is-there () $something) False )

( = (is-there $pattern $something) (
        let* 
            (
                ( $top (car-atom $pattern) )
                ( $bottom (cdr-atom $pattern) )
                ( $topType (get-metatype $top) )
            ) 
            (
                if ( == Expression $topType)

                    ( 
                        let*
                            (
                                ($ans1 (is-there $top $something))
                                ($ans2 (is-there $bottom $something))
                            )
                            (
                                or $ans1 $ans2
                            )
                        
                    )
                
                    (
                      if ( == $top $something)
                        True
                        (is-there $bottom $something)  
                    )
                    
            )
    ) 
)

; !(is-there ($hi (this is it ( guys ($new)) aji) ) $new)



;; get the variables in pattern_1 first which is:
;; var1 = ( $name $leave )
( = (common-variable-remover $pattern_1 $pattern_2) 
    (
        let*
            (
                ($VariablesInPattern1 (get-variables $pattern_1))
                (() (println! (variables in pattern_1 is $VariablesInPattern1) ))
            )
            (
                $pattern_1 (get-corrected-pattern $pattern_2 $VariablesInPattern1 ())
            )
    )
)


;; get-corrected-pattern - this function will check each atom in pat-2 and 
;; if there is repeated variable substitute it with unique variable and accumulate it
;; if not variable or it is not repeated accumulate the atom 
;; and return the accumulated value at the end

(: get-corrected-pattern (-> Expression Expression Expression Expression))

;;base case
( = (get-corrected-pattern () $_ $__) () )

( = (get-corrected-pattern $pattern_2 $VariablesInPattern1 $accumulator)
    (
        let*
            (
                ($topPat2 (car-atom $pattern_2)) 
                (() (println! (working on $topPat2)))
                ($topPat2Type (get-metatype $topPat2)) 
                ($botPat2 (cdr-atom $pattern_2))
            )

            (
                if ( == $topPat2Type Expression) 
                    (
                        ;; this head is expression so needs recursion
                        let*
                            ( 
                                ($ansHere (get-corrected-pattern $topPat2 $VariablesInPattern1 ()))
                                ($ansOfRest (get-corrected-pattern $botPat2 $VariablesInPattern1 ()))
                                ($joinedAns (union-atom $ansHere $ansOfRest))
                            )

                            ( union-atom $accumulator $joinedAns )  
                    )

                    (
                        let
                            $returnedPattern (get-corrected-pattern $botPat2 $VariablesInPattern1 $accumulator)

                            (
                                if ( == $topPat2Type Variable )
                                (
                                    if (is-there $VariablesInPattern1 $topPat2)
                                        ( ;; substitute here by calling function that is written in python
                                            let
                                                $tempoVar (GenerateVariable (any))
                                                (union-atom $tempoVar $returnedPattern)    
                                        )  
                                        ( union-atom ($topPat2) $returnedPattern )  ; just catch and continue 
                                )

                                ( union-atom ($topPat2) $returnedPattern ) ; just catch and continue, since not variable and not expression 
                            )
                        
                    )
                    

            )
    )
)

; pat_1 = (hi this is $name $leave)
!(bind! &pat_1 (hi this is $name $leave))

; pat_2 = ($name is working ($also) )
!(bind! &pat_2 ($name $name ($leave) is working ($also) ))

; (func-name pattern_1 pattern_2  ) => ( (hi this is $name $leave) ($newVariable is working ($also)) )

!(common-variable-remover &pat_1 &pat_2) ;; results [((hi this is $name $leave) (Random_Variable3 Random_Variable2 Random_Variable1 is working $also))]
