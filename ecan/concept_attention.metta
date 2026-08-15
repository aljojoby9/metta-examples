; Attention-gated inheritance cycle.
; Requires: pip install hyperon-ecan[hyperon]
; Then:     metta ecan/concept_attention.metta
;
; Grounded atoms are registered by importing hyperon_ecan
; (see hyperon_ecan/ext.py in https://github.com/aljojoby9/hyperon-ecan).

!(import! &self hyperon_ecan)

!(ecan-new)
!(ecan-fact Inheritance dog mammal)
!(ecan-fact Inheritance mammal animal)
!(ecan-fact Inheritance cat mammal)
!(ecan-fact Inheritance oak tree)
!(ecan-add wolf)

!(ecan-tick dog)
!(ecan-tick dog)
!(ecan-focus)
!(neural-similar dog)
!(ecan-sti wolf)
!(ecan-sti oak)
