# Overview

Examples of mapping between SPARQL language commands and some of the MeTTa concepts are collected in this folder.

Each file except inference engine has commented example in SPARQL and corresponding example in MeTTa.

## List of scripts 

[not_exist.metta](not_exist.metta) 

This script implements basic command, which returns false if pattern matches and true otherwise.

[filter.metta](filter.metta) 

This script implements is a restriction on solutions over the whole group pattern in which the filter appears.

[construct.metta](construct.metta) 

This script implements command that returns a single graph specified by a graph template.
The result is formed by taking each query solution in the solution sequence, substituting for the variables in the graph template, 
and combining the triples into a single graph adding it to the space.

[bind.metta](bind.metta) 

This script implements command that allows a value to be assigned to a variable from a basic graph pattern or property path expression.
Very similar to a `let` function in Metta.

[union.metta](union.metta) 

This script implements command that provides a means of combining graph patterns so that one of several alternative graph patterns may match. 
If more than one of the alternatives matches, all the possible pattern solutions are found.

[very_simple_inference_engine.metta](very_simple_inference_engine.metta)

This script implements simple variant of rule engine that takes a list of rules, each of which either populates space with new facts or returns Empty, 
and consistently applies these rules until knowledge base does not change.

[transitive_closure_clr.metta](transitive_closure_clr.metta)

This script provides simple transitive closure example for a family graph using some of the commands above and the inference engine. 

[transitive_closure_clr2.metta](transitive_closure_clr2.metta)

This script provides simple transitive closure example for a book authors graph using some of the commands above and the inference engine.