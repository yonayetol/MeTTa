( = (variable-extractor $head () $answer)  
    (if (== (get-metatype $head) Variable)
        ( union-atom $answer ($head))
        (if (== (get-metatype $head) Expression)
            (variable-extractor (car-atom $head) (cdr-atom $head) $answer )    
            $answer
        ) 
    )
)
( = (variable-extractor $head $tail $answer) 
    (
        if (== (get-metatype $head) Variable)
            (variable-extractor (car-atom $tail) (cdr-atom $tail) ( union-atom $answer ($head) ) )
            (
                if (== (get-metatype $head) Expression)
                    ( 
                        let* 
                            ( 
                                ;;;;; get all variables from this expression as well as post expression variables
                                ($var1 (variable-extractor (car-atom $head) (cdr-atom $head) () ) )
                                ($var2 (variable-extractor (car-atom $tail) (cdr-atom $tail) () ) )
                                )

                            (   ;;;; merge all variables u have got so far
                                let 
                                    $first_unity (union-atom $answer $var1)
                                    (union-atom $first_unity $var2)
                            )
                            
                        
                    )
                    ( variable-extractor (car-atom $tail) (cdr-atom $tail) $answer )          
            )
    )
)

( = (get-variables $var) (variable-extractor (car-atom $var) (cdr-atom $var) ( ) ) )

; !( get-variables (Inheritance $new ( $x $y ($again ( $3rd_expression ) ) ) (((text )))$other $r hi there $hi))
