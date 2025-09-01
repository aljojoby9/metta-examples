;@prefix ex: <http://example.org/> .
;@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
;
;# People
;ex:Alice a ex:Person .
;ex:Bob a ex:Person .
;ex:Charlie a ex:Person .
;ex:Diana a ex:Person .
;
;# Relationships
;ex:Alice ex:isParentOf ex:Bob .
;ex:Bob ex:isParentOf ex:Charlie .
;ex:Charlie ex:isParentOf ex:Diana .

;@prefix ex: <http://example.org/> .
;@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
;
;# People
;ex:Alice a ex:Person .
;ex:Bob a ex:Person .
;ex:Charlie a ex:Person .
;ex:Diana a ex:Person .
;
;# Relationships
;ex:Alice ex:isParentOf ex:Bob .
;ex:Bob ex:isParentOf ex:Charlie .
;ex:Charlie ex:isParentOf ex:Diana .
;
;PREFIX ex: <http://example.org/>
;
;CONSTRUCT {
;  ?grandparent ex:isGrandparentOf ?grandchild .
;}
;WHERE {
;  ?grandparent ex:isParentOf ?parent .
;  ?parent ex:isParentOf ?grandchild .
;}

;PREFIX ex: <http://example.org/>
;
;CONSTRUCT {
;  ?greatGrandparent ex:isGreatGrandparentOf ?greatGrandchild .
;}
;WHERE {
;  ?greatGrandparent ex:isParentOf ?grandparent .
;  ?grandparent ex:isGrandparentOf ?greatGrandchild .
;}

;PREFIX ex: <http://example.org/>
;
;CONSTRUCT {
;  ?ancestor ex:isAncestorOf ?descendant .
;}
;WHERE {
;  ?ancestor ex:isParentOf ?descendant .
;}

;PREFIX ex: <http://example.org/>
;
;CONSTRUCT {
;  ?ancestor ex:isAncestorOf ?descendant .
;}
;WHERE {
;  ?ancestor ex:isParentOf ?intermediate .
;  ?intermediate ex:isAncestorOf ?descendant .
;}

!(import! &self very_simple_inference_engine)
!(import! &self not_exist)

(Parent Tom Bob)
(Parent Pam Bob)
(Parent Tom Liz)
(Parent Bob Ann)
(Parent Bob Pat)
(Parent Pat Jim)
(Parent Jim Lil)

(Person (Female Pam))
(Person (Female Liz))
(Person (Female Ann))
(Person (Female Lil))
(Person (Male Tom))
(Person (Male Bob))
(Person (Male Pat))
(Person (Male Jim))


(= (rule1)
    (match &self (Parent $x $y) (if (not_exist (Predecessor $x $z)) (add-atom &self (Predecessor $x $y)) Empty)))

(= (rule2)
    (match &self (, (Parent $x $y) (Predecessor $y $z)) (if (not_exist (Predecessor $x $z)) (add-atom &self (Predecessor $x $z)) Empty)))

(= (rule3)
    (match &self (, (Predecessor $y $z) (Person (Female $y))) (if (not_exist (FemPredecessor $y $z)) (add-atom &self (FemPredecessor $y $z)) Empty)))


!(rule-engine (rule1 rule2 rule3))

!(match &self (Predecessor $y Jim) $y)

!(match &self (FemPredecessor $y Jim) $y)
