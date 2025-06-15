
;;;; defined functions ;;;;;
; 1. length of a list
; 2. is-member 
; 3. append to list 
; 4. max-value of a list 
; 5. min-value of a list 
; 6. pop from a list 
; 7. push to a list 
; 8. remove-element from a list 
; 9. remove-duplicate from a list 
; 10.i list to map converter
; 10.ii accessing a value from a map 
; 11 filter
; 12 fold-l
; 13 fold-r
; 14 reverse a list
; 15 sort a list




;;;;;;;;;;;;;;;;;;; 1. function for length of list ;;;;;;;;;;;;;;;;;;;
;(: List Type)

;(: End List) 

( = (length (End))  0 )

( = (length (itm $head $tail)) ( + 1 (length $tail) ))

;!(length (itm 1 (itm 2 (itm 3 (End)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;; 2. function for is-member in list ;;;;;;;;;;;;;;;;
;(: List Type)
;
;(: End List) 
;
;;;; /_\ basecase /_\ we have reached the end of the list, therefore the number is missing for sure 

;; define the type of the is-member function ;;
(: remove (-> List Atom Bool))

( = (is-member (End) $_) False )

( = (is-member (itm $head $tail) $find) (
     if (== $find $head)
          True
          (is-member $tail $find)
))

;!(is-member (itm 1 (itm 2 (itm 3 (End)))) 2 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;; 3. function for append in list ;;;;;;;;;;;;;;;;
; (: List Type)
;(: End List) 

;; define the type of the is-member function ;;
(: append (-> List Expression List) )

;; the expression that we will get seems like this 
;; Expression === (9 8 7)
;; we need to change this in to a form like (itm 9(itm 8(itm 7(End))))
;; now lets add this created list to the orginal list
;; i.e (itm 1 (itm 2 (itm 3 (End)))) + (itm 9(itm 8(itm 7(End))))
; (itm 1 (itm 2 (itm 3 (itm 9(itm 8(itm 7(End)))))))


( = (expression-changer $head $tail) (
          if (== $tail ())
               (itm $head (End))

               (
                    itm ($head (expression-changer 
                         (car-atom $tail) 
                         (cdr-atom $tail) 
                              )
                         )
               )
     )
)


( = (append (itm $head $tail) $new_elements) (
          if (== $tail (End) )
               (itm $head (expression-changer (car-atom $new_elements) (cdr-atom $new_elements)))
               (itm $head (append $tail $new_elements))
     )
)

; !(append (itm 1 (itm 2 (itm 3 (End)))) (4 6 7) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;; 4. function for max-value in list ;;;;;;;;;;;;;;;;
; (: List Type)

; (: End List) 

;;;; /_\ basecase /_\ we have reached the end of the list

( = (maxi (End) $the_biggest_of_all) $the_biggest_of_all)

( = (maxi (itm $head $tail) $maxi) (
     if (> $head $maxi)
          (maxi $tail $head)
          (maxi $tail $maxi)
     ) 
)

( = (max-finder (itm $head $tail)) (maxi $tail $head))

;!(max-finder (itm 9 (itm 5 (itm 3 (End)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;; 5. function for min-value in list ;;;;;;;;;;;;;;;;
;(: List Type)
;
;(: End List) 

;;;;; /_\ basecase /_\ we have reached the end of the list

( = (mini (End) $the_biggest_of_all) $the_biggest_of_all)

( = (mini (itm $head $tail) $mini) (
     if (< $head $mini)
          (mini $tail $head)
          (mini $tail $mini)
     ) 
)

( = (min-finder (itm $head $tail)) (mini $tail $head))

;!(min-finder (itm 9 (itm 1 (itm 3 (End)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;; 6. function to push an element to a list ;;;;;;;;;;;;;;;;
; (: List Type)

; (: End List) 

;; push accepts 2 parameters the list and the new element; and returns the modified list

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; for example to push 5 to a list = (itm 1(itm 2(itm 3(itm 4(End))))) we will follow this steps   ;;;;;;;;;;;
;; 1 -> 2                                                                                                      ;;;;;;;
;; 2 -> 3                                                      "-> means waits for"                            ;;;;;;;
;; 3 -> 4                                                                                                      ;;;;;;;
;; 4 -> End                                                                                                    ;;;;;;;
;;;;;;;;;;;;;; the End is the Base case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; End returns (itm 5(End))                                                                                    ;;;;;;;
;; 4 returns (itm 4 End's_return) === (itm 4 (itm 5(End)))                                                     ;;;;;;;
;; 3 returns (itm 3 4's_return) === (itm 3 (itm 4 (itm 5(End))))                                               ;;;;;;;
;; 2 returns (itm 2 3's_return) === (itm 2 (itm 3 (itm 4 (itm 5(End)))))                                       ;;;;;;;
;; 1 returns (itm 1 2's_return) === (itm 1(itm 2 (itm 3 (itm 4 (itm 5(End))))))                                ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; the base-case 
( = (push (End) $new_number ) ( itm $new_number (End) ))

( = (push (itm $head $tail) $new_number) ( itm $head (push $tail $new_number) ))

; !(push (itm 1(itm 2(itm 3(itm 4(End))))) 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;; 7. pop function (to remove the element from a list)  ;;;;;;;;;;;;;;;;;;;;

( = (pop (End)) (Found No Element)) ;; base case incase the list is empty at first.

( = (pop (itm $head $tail)) (
     if (== $tail (End))
          (End)
          (itm $head (pop $tail))
))

; !(pop (itm 1(itm 2(itm 3(itm 4(End))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;;;;; 8. function to remove an element from a list ;;;;;;;;;;;;;;;;
(: List Type)

(: (End) List) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     Approach      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; for example to remove 3 to a list = (itm 1(itm 2(itm 3(itm 4(End))))) we will follow this steps   ;;;;;;;;;;;
;; 1 -> 2                                                                                                      ;;;;;;;
;; 2 -> 3                                                        "-> means waits for"                          ;;;;;;;
;;;;;;;;;;;;;; 3 is the Base case here ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3 returns its tail = (itm 4(End))                                                                           ;;;;;;;
;; 2 returns (itm 2 3's_return) === (itm 2 (itm 4(End)))                                                       ;;;;;;;
;; 1 returns (itm 1 2's_return) === (itm 1 (itm 2 (itm 4(End))))                                               ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; define the type of the remove function ;;
(: remove (-> List Atom List))

;; incase the number is missing in the list
( = (remove (End) $missing_element) (End))

( = (remove (itm $head $tail) $new_element) (
     if (== $head $new_element)
          $tail
          (itm $head (remove $tail $new_element))
))
;!(remove (itm 1(itm 2(itm 3(itm 4(End))))) 6)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  9. function remove all duplicates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(: List Type)

(: End List) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     Approach      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;   (itm 1(itm 2(itm 2(itm 4(End)))))                                                                          ;;;;;;; 
;;      1 -> 2                                                                                                        ;;;;;;;
;;      2 -> 2                                           "-> means waits for"                                         ;;;;;;;
;;      2 -> 4                                                                                                        ;;;;;;;
;;      4 -> End                                                                                                      ;;;;;;;
;;;;;;;;;;;;;; End - is the Base case and starts to wrap up ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;      4 got (End)     -- we will check whether 4 is in (End) -got no and returns including it self === (itm 4(End)) ;;;;;;;         

;;      2 got (itm 4(End)) -- we will check whether 2 is in (itm 4(End)) -got no, and returns including it self === (itm 2(itm 4(End)))                         ;;;;;;;   

;;      2 got (itm 2(itm 4(End))) -- we will check whether 2 is in (itm 2(itm 4(End))) -got yes, and returns with-out including it self === (itm 2(itm 4(End))) ;;;;;;;

;;      1 got (itm 2(itm 4(End))) -- we will check whether 1 is in (itm 2(itm 4(End))) -got no, and returns including it self === (itm 1(itm 2(itm 4(End))))    ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; define the type of the remove-duplicates function ;;
(: remove-duplicates (-> List List))

( = (remove-duplicates (End)) (End) )

;;; we can't redefine a value to a variable, therefore lets work around using a helper function
(: helper (-> List Atom List))

( = (helper $wrapped $head) (
     if (is-member $wrapped $head)
               $wrapped
               (itm $head $wrapped)
 ))

( = (remove-duplicates (itm $head $tail)) (helper (remove-duplicates $tail) $head) )

;! (remove-duplicates (itm 2(itm 1(itm 2(itm 1(End))))) )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 10. changing a list to map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(: map Type)

;; accepts the the first initial key and the list and returns map which we have got from the List
(: to-map (-> Atom List map))

( = (to-map $index (End)) ($index End))

( = (to-map $index (itm $head $tail)) (
     $index $head (to-map (+ $index 1) $tail)
))

; !(to-map 0 (itm 45(itm 46(itm 234(itm 2234(End))))))

;;; accessing a value by its key (we used the index as a key here)

;; accepts key, the map and returns element or (Not Found)
(: map-at (-> Atom List Atom))

( = (map-at $- ($last_idx End)) (Not Found))

( = (map-at $index ($key $value $tail)) (
     if (== $index $key)
          $value
          (map-at $index $tail)

     )
)

; !(map-at 25 (0 45 (1 46 (2 234 (3 2234 (4 End))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 11. filter ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

(: filter (-> (-> Atom Bool) List List))

( = (filter $function (End)) (End))

( = (filter $function (itm $head $tail)) (
          if ($function $head)
               (itm $head (filter $function $tail))
               (filter $function $tail)
     ) 
)

;;;;;;; example function even number checker ;;;;;;
( = (even-checker $number) (== (% $number 2) 0))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; !(filter even-checker (itm 8(itm 2(itm 3(itm 4(End))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; filter ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 12. fold-l ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
(: add (-> $a $b $c))
(= (add $num_1 $num_2) (+ $num_1 $num_2))

( = (fold-l $function $accumulator (itm $head $tail)) (
     if (== $tail (End))
          ($function $accumulator $head) ;; we only have left with the last number
          (fold-l $function ($function $accumulator $head) $tail ) ;; this will make the recursion by consistently changing the accumulator
) )

;!(fold-l add 0 (itm 1(itm 2(itm 3(itm 4(End))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; fold-l ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 13. fold-r ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

( = (fold-r $- (End)) 0) ;; base case just returning 0

;; we will add current number with the number that its next number returns to it
( = (fold-r $function (itm $head $tail)) (
     $function $head (fold-r $function $tail)
))


; !(fold-r add (itm 1(itm 2(itm 3(itm 2(End))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; fold-r ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 





;;;;;;;;;;;;;;;;;;; 14. function to reverse a list ;;;;;;;;;;;;;;;;
;(: List Type)

;(: End List) 
;
( = (list-reverser (End) $reversed_list) $reversed_list)

( = (list-reverser (itm $head $tail) $reversed) ( list-reverser $tail (itm $head $reversed) ))

( = (reverse $list) ( list-reverser $list (End) ))

;!(reverse (itm 9 (itm 1 (itm 3 (itm 4 (End))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    15. sorting list               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;; value insert to a given list  ;;;;;;;;;;;;;;;;
( = (insert (End) $the_number) (itm $the_number(End)))

( = (insert (itm $head $tail) $the_number) (
     if (> $head $the_number )
          (itm $the_number (itm $head $tail))
          (itm $head (insert $tail $the_number))
))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

( = (sort (End)) (End))

( = (sort (itm $head $tail)) ( insert (sort $tail) $head ))

; !(sort (itm 11(itm 9(itm 22(itm 1(End))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 







