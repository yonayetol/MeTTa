( = ( real-substitute-func $thePattern $setOfVariables $accumulator)
    (   
        if (== $thePattern ())
            ($accumulator $setOfVariables) ;;;``;;; end of expression ;;;
            ( let* 
                (
                    ($head (car-atom $thePattern)) 
                    ($tail (cdr-atom $thePattern)) 
                    ($headType (get-metatype $head))
                    ($firstVariable (car-atom $setOfVariables))
                    ($restVariables (cdr-atom $setOfVariables))
                ) 

                ( 
                    if (== $headType Variable) 
                        ( real-substitute-func $tail $restVariables ( union-atom $accumulator ($firstVariable) ) )

                        (   
                            if (== $headType Expression)  
                                ;; work for this expression and return the corrected expression here
                                ( let* (
                                        ( $returnedValue (real-substitute-func $head $setOfVariables ()) )
                                        ( $textPart      ((car-atom $returnedValue)))
                                        ( $variablePart   (cdr-atom $returnedValue) )
                                        ( $leftVariable  (car-atom $variablePart))
                                        ( () (println! (returnedValue ~ $returnedValue , textPart ~ $textPart , left over variable ~ $leftVariable)) )
                                    ) ( 
                                        ;; call this function by passing empty accumulator and u have to track the substituting variables here 
                                        let
                                            $fullHistory (union-atom $accumulator $textPart) 
                                            ;; work for the rest of the pattern with the leftover substituting variables
                                            ( real-substitute-func $tail $leftVariable $fullHistory )
                                    )
                                    
                                ) 
                                (
                                    let 
                                        $joined (union-atom $accumulator ($head)) 
                                        ( real-substitute-func $tail $setOfVariables $joined )

                                )
                                
                        )
                )
            )
    
    )
)

( = (substitute $pattern $setOfVariables) 
    (
        let 
            $answer (real-substitute-func $pattern $setOfVariables ()) 

            (car-atom $answer)
    )   
)

; !(bind! &prompt (Inheritance (here spoiler (another (spoiler $fact)) ) $new my $x $y) )
; !(bind! &vars ((but yeah it is working!) is dog killer) )

; !(substitute &prompt &vars) 