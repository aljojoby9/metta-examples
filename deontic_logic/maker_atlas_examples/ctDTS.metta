;#------------------------------------------------------------------------------------------------------------------------------------------------
;# Inference rules
;#
;# :InferenceRule is a special class that contains the SPARQL rules in the form CONSTRUCT-WHERE to execute. Each individual of this
;# class is associated through the property has-sparql-code with a xsd:string that executes it. The automated reasoner first collects
;# all individuals of the class :InferenceRule; then, it iteratively re-execute the SPARQL rules in the range of :has-sparql-code
;# until no new individual is inferred.
;#------------------------------------------------------------------------------------------------------------------------------------------------
;
;:InferenceRule rdf:type rdfs:Class.
;:has-sparql-code rdf:type rdf:Property;
;	rdfs:domain :InferenceRule;
;	rdfs:range xsd:string.

;#------------------------------------------------------------------------------------------------------------------------------------------------
;# 1st-level classes and properties (Hobbs's logic) - eventualities, modalities, and thematic roles


;#Rexist modality:
;:Rexist rdf:type rdfs:Class,:Modality.

(= (not_exist pattern)
    !(unify &self (pattern) T F))

(rexist class modality)

;#Top classes:
;:Eventuality rdf:type rdfs:Class.
;:Modality rdf:type rdfs:Class.
;:ThematicRole rdf:type rdfs:Class.

(eventuality class type)
(modality class type)
(thematic_role class type)

;#negation, conjunction, and disjunction of eventualities:
;:not rdf:type rdf:Property; rdfs:domain :Eventuality; rdfs:range :Eventuality.
;:and1 rdf:type rdf:Property; rdfs:domain :Eventuality; rdfs:range :Eventuality.
;:and2 rdf:type rdf:Property; rdfs:domain :Eventuality; rdfs:range :Eventuality.
;:or1 rdf:type rdf:Property; rdfs:domain :Eventuality; rdfs:range :Eventuality.
;:or2 rdf:type rdf:Property; rdfs:domain :Eventuality; rdfs:range :Eventuality.


(NOT property eventuality)
(AND1 property eventuality)
(AND2 property eventuality)
(OR1 property eventuality)
(OR2 property eventuality)

;#Deontic modalities:
;:DeonticModality rdf:type rdfs:Class; rdfs:subClassOf :Modality.
;:Obligatory rdf:type rdfs:Class,:DeonticModality.
;:Permitted rdf:type rdfs:Class,:DeonticModality.
;:Optional rdf:type rdfs:Class,:DeonticModality.

(deontic_modality class modality)
(oligatory class deontic_modality)
(permitted class deontic_modality)
(optional class deontic_modality)

;#------------------------------------------------------------------------------------------------------------------------------------------------

;# 2nd-level classes and properties - classical logic operators applied to rdf:Statement(s), i.e., reifications of 1st-level assertions.
;# These are needed because RDF vocabulary does not implement several operators from classical logic (negation, disjunction, etc.), nor
;# the alethic modal logic operators of necessity (□) and possibility (◊)


;:statement rdf:type rdfs:Class; rdfs:subClassOf rdf:Statement.
;:true rdf:type rdfs:Class; rdfs:subClassOf :statement.
;:false rdf:type rdfs:Class; rdfs:subClassOf :statement.
;:hold rdf:type rdfs:Class; rdfs:subClassOf :statement.
;:necessary a rdfs:Class; rdfs:subClassOf :statement.
;:possible a rdfs:Class; rdfs:subClassOf :statement.
;
;:disjunction rdf:type rdf:Property;
;	rdfs:domain :statement;
;	rdfs:range :statement.

(true class statement)
(false class statement)
(hold class statement)
(necessary class statement)
(possible class statement)

(disjunction property (statement statement)) ;!!!!!!

;#------------------------------------------------------------------------------------------------------------------------------------------------

;3rd-level - explicit representation of contradictions, conflicts, violations, and other undesirable consequences (fallacies, mistakes, etc.)

;:is-in-contradiction-with rdf:type rdf:Property;
;	rdfs:domain :statement;
;	rdfs:range :statement.
;:is-in-conflict-with rdf:type rdf:Property;
;	rdfs:domain :statement;
;	rdfs:range :statement.
;:is-complied-with-by rdf:type rdf:Property;
;	rdfs:domain :statement;
;	rdfs:range :statement.
;:is-violated-by rdf:type rdf:Property;
;	rdfs:domain :statement;
;	rdfs:range :statement.
;:is-necessary-violated-by rdf:type rdf:Property;
;	rdfs:domain :statement;
;	rdfs:range :statement.

(is_in_contradiction_with property (statement statement))
(is_in_conflict_with property (statement statement))
(is_complied_with_by property (statement statement))
(is_violated_by property (statement statement))
(is_necessary_violated_by property (statement statement))

;#------------------------------------------------------------------------------------------------------------------------------------------------
;# Inference rules at the 1st level (the level of the eventualities)

;#The following rule infers that if two eventualities are direct instantiations of the same abstract eventuality (i.e., they both describe the
;#same action/state with the same thematic roles) but for at least one thematic role, for which it is asserted that one of the two eventualities
;#has a certain value on that thematic role while the other one does not, then the two eventualities are connected by the ":not" property.

;[rdf:type :InferenceRule;
;	:has-sparql-code """CONSTRUCT{?e1 :not ?e2}
;						WHERE{?e1 rdf:type ?c. ?e2 rdf:type ?c. ?c rdf:type :Eventuality. FILTER(?e1!=?e2)
;						  ?trn rdf:type :ThematicRole. ?e1 ?trn ?vn. ?r rdf:type :false,:hold; rdf:subject ?e2; rdf:predicate ?trn; rdf:object ?vn.
;						  NOT EXISTS{?tr rdf:type :ThematicRole. FILTER(?tr!=?trn) ?e1 ?tr ?tv1. NOT EXISTS{?e2 ?tr ?tv2}}
;						  NOT EXISTS{?tr rdf:type :ThematicRole. FILTER(?tr!=?trn) ?e2 ?tr ?tv2. NOT EXISTS{?e1 ?tr ?tv1}}
;						  NOT EXISTS{?tr rdf:type :ThematicRole. FILTER(?tr!=?trn) ?e1 ?tr ?tv1. ?e2 ?tr ?tv2. FILTER(?tv1!=?tv2)}}"""^^xsd:string].

!(match &self (, ($e1 rdf:type $c) ($e2 rdf:type $c) ($c property eventuality))
                 (if (not (== $e1 $e2))

                    (match &self (, ($trn rdf:type :ThematicRole) ($e1 $trn $vn) (hold ($r rdf:type :false)) )
                        (if (and (not_exist (, ($tr rdf:type :ThematicRole) ($e1 $tr $tv1) (not_exist ($e2 $tr $tv2))))
                                 (not_exist (, ($tr rdf:type :ThematicRole) ($e2 $tr $tv2) (not_exist ($e1 $tr $tv1))))
                                 (not_exist (, ($tr rdf:type :ThematicRole) ($e1 $tr $tv1) (($e2 $tr $tv2)))))

                            (add-atom &self (NOT $e1 $e2))))))

