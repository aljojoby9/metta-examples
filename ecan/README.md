# ECAN + neural spreading

Economic Attention Networks for Hyperon. Classic OpenCog had this.
Hyperon does not. Full implementation, tests, and the two experiments
live in a sibling-style repo:

**https://github.com/aljojoby9/hyperon-ecan**

This folder is the in-tree hook: a MeTTa sketch plus the reason the
example exists.

## Why this is here

The Hyperon paper (arXiv:2310.18318) lists PLN, MOSES and ECAN as the
cognitive algorithms that should come back as MeTTa. PLN has
`trueagi-io/PLN`. ECAN has nothing. Classic `opencog/attention` is
marked obsolete.

`hyperon-ecan` implements Iklé, Pitt, Goertzel & Sellman 2009
Variant 1 (STI/LTI currencies, rent, wages, Hebbian, left-stochastic
diffusion, forgetting) and adds one thing Classic never had: implicit
Hebbian weights from embeddings. Attention can move from `dog` to
`wolf` with no symbolic `Inheritance` edge.

It also runs the PLN/ECAN interlock from the last section of that
paper: pick the next inference step by STI, pay those atoms, cycle
ECAN, repeat.

This is not MeTTa-Motto. No LLM is required on the default path.

## Run the experiments (from the full repo)

```bash
git clone https://github.com/aljojoby9/hyperon-ecan.git
cd hyperon-ecan
python -m pip install -e ".[dev]"
python examples/associative_memory.py
python examples/attention_gated_inference.py
python -m pytest
```

What you should see:

- Imprint `{dog, bark, leash, park}`, decay, cue `{dog, bark}` → the
  rest of the pattern re-enters the attentional focus. Distractors stay
  out.
- Prove `(Inheritance dog animal)` without expanding an oak/tree/plant
  subgraph that sits in the same space. `wolf` gets STI; `oak` does not.

## MeTTa façade

`concept_attention.metta` drives the Python grounded atoms. Needs
`pip install hyperon-ecan[hyperon]`.
