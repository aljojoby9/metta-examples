# ECAN + neural spreading

Example of [hyperon-ecan](https://github.com/aljojoby9/hyperon-ecan)
from MeTTa. The library lives in that repo. This folder is just the
usage sketch.

## Run

```bash
pip install git+https://github.com/aljojoby9/hyperon-ecan.git#egg=hyperon-ecan[hyperon]
metta ecan/concept_attention.metta
```

## What the script does

It walks the same loop one call at a time, so you can see each ECAN
op instead of a single `ecan-tick` blob.

1. `ecan-fact` — add Inheritance triples (also builds Hebbian links)
2. `ecan-add wolf` — wolf has no symbolic edge
3. `ecan-cluster` — put dog/wolf in one embedding group, oak/tree in another
4. `ecan-focus` / `ecan-sti` — working memory starts empty
5. `ecan-stimulate dog` then `ecan-cycle` — pay attention, spread STI
6. `neural-similar` / `ecan-sti wolf` / `ecan-sti oak` — wolf should
   move, oak should stay near 0
7. `ecan-infer` — should print `(Inheritance dog animal)`, not oak

Python experiments with more detail are in the library repo:

```bash
python examples/associative_memory.py
python examples/attention_gated_inference.py
```
