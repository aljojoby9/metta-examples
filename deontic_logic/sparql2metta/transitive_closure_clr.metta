;# People and their favorite books
;ex:John a ex:Person ;
;        ex:likesBook ex:BookA .
;
;ex:Alice a ex:Person ;
;         ex:likesBook ex:BookC .
;
;# Books and inspiration (transitive)
;ex:BookA a ex:Book .
;ex:BookB a ex:Book .
;ex:BookC a ex:Book .
;ex:BookD a ex:Book .
;
;# Inspiration connection inspiredBy
;ex:BookB ex:inspiredBy ex:BookA .
;ex:BookC ex:inspiredBy ex:BookB .
;ex:BookD ex:inspiredBy ex:BookC .
;
;# Authors
;ex:Author1 a ex:Author ;
;           ex:wrote ex:BookA .

;PREFIX ex: <http://example.org/>
;
;SELECT DISTINCT ?person ?book
;WHERE {
;  ?person a ex:Person ;
;          ex:likesBook ?book .
;
;  #Recursive transitive closure up to 3 levels of inspiredBy
;  ?book ex:inspiredBy ?b1 .
;  ?b1 ex:inspiredBy ?b2 .
;  ?b2 ex:inspiredBy ?b3 .
;
;  # Author wrote the initial book
;  ?author a ex:Author ;
;          ex:wrote ?b3 .
;}

!(import! &self very_simple_inference_engine)
!(import! &self not_exist)

(likesBook (Person John) BookA)
(likesBook (Person Alice) BookB)

(Book BookA)
(Book BookB)
(Book BookC)
(Book BookD)

(inspiredBy BookB BookA)
(inspiredBy BookC BookB)
(inspiredBy BookD BookC)

(wrote (Author Author1) BookA)

(= (rule1)
    (match &self (inspiredBy $x $y) (if (not_exist (influenced $x $y)) (add-atom &self (influenced $x $y)) Empty)))

(= (rule2)
    (match &self (, (inspiredBy $x $y) (influenced $y $z)) (if (not_exist (influenced $x $z)) (add-atom &self (influenced $x $z)) Empty)))

!(rule-engine (rule1 rule2))

!(match &self (influenced BookD $y)  $y)