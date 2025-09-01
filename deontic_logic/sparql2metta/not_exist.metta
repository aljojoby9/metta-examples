; xsd:boolean  NOT EXISTS { pattern }
;Returns false if pattern matches. Returns true otherwise.
;
;NOT EXISTS { pattern } is equivalent to fn:not(EXISTS { pattern }).
;
; xsd:boolean  EXISTS { pattern }
;Returns true if pattern matches. Returns false otherwise.

(: not_exist (-> Atom Bool))
(= (not_exist $pattern)
    (let $top-space (mod-space! top)
        (unify $top-space $pattern False True)))
