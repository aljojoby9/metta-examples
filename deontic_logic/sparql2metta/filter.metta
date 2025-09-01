;:book1  dc:title  "SPARQL Tutorial" .
;:book1  ns:price  42 .
;:book2  dc:title  "The Semantic Web" .
;:book2  ns:price  23 .

;SELECT  ?title ?price
;WHERE   { ?x ns:price ?price .
;          FILTER (?price < 30.5)
;          ?x dc:title ?title . }

;title	price
;"The Semantic Web"	23

(book1 title sprql-tutorial)
(book1 price 42)
(book2 title semantic-web)
(book2 price 23)

!(match &self ($x price $y)
            (if (< $y 30.5)
            (match &self ($x title $z) ($z $y))
            Empty))

!(match &self
   (, ($x price $y)
      ($x title $z))
   (if (< $y 30.5) ($z $y) Empty))

;(= (filter $pattern)
;    (match &self ($x price $y)
;            (if $pattern
;            (match &self ($x title $z) ($z $y))
;            Empty)))
;
;
;(= (filter (less-than $b))
;    (match &self ($x price $y)
;            (if (< )
;            (match &self ($x title $z) ($z $y))
;            Empty)))
;
;!(filter (< $y 30.5))

