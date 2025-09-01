(= (rule-bool $rule)
   (case ($rule) (
    (Empty True)
    ($_ False)
   )))

(: rule-applicator (-> Expression Expression))
(= (rule-applicator $rules)
    (trace! (noeval $rules) (if-decons-expr $rules $head $tail
        (let $res (rule-bool $head) (let $recres (rule-applicator $tail) (cons-atom $res $recres)))
        ())))

(= (applic-checker $rules_outputs)
    (foldl-atom $rules_outputs True  $a $b (and  $a $b)))


;rule engine takes a list of rules, each of which either populates space with new facts or returns Empty,
;and consistently applies these rules until knowledge base does not change

(= (rule-engine $rules)
    (if (applic-checker (rule-applicator $rules))
        Empty
        (rule-engine $rules))
    )