# leancert-qproduct

Certified finite and infinite q-products, exact integrals and moments,
prime-indexed limiting constants, and perturbation observers.

## Imports

- `import QProduct`: mathematical theory and exact finite certificates; the
  module import closure uses only Mathlib, not LeanCert.
- `import QProduct.LeanCert`: additionally enables directed-limit certificates,
  sparse polynomial integration, and interval kernel banks.
- `import QProduct.ConstantFactory`: exact perturbation observers.

Declarations use `QProduct.*` and `QProduct.ConstantFactory.*`, not the former
`LeanCert.QProduct.*` / `LeanCert.ConstantFactory.*` namespaces.

## Local development

Initialized with Lean Runtime, pinned to Lean/Mathlib **4.34.0** to match
LeanCert. This initial extraction intentionally uses the sibling checkout:

```text
research/
  leancert/
  formalizations/
    leancert-qproduct/
```

`lakefile.toml` requires `../../leancert`. The exact inherited Mathlib pins in
`lake-manifest.json` match that checkout; `packagesDir` reuses its dependency
cache. LeanCert does **not** depend on this project. No local source links or
copied LeanCert implementation modules are needed.

```sh
lake --no-cache build
lake --no-cache build Examples Tests
lake --no-cache build PrimeLambdaDigits
lean-runtime check --using . --offline Examples/PrimeLambda.lean
python3 scripts/check_docs.py
```

For this two-checkout setup, Lake builds reuse the sibling's existing cache.
`lean-runtime build` is also supported, but its shared-dependency preparation
may create a separate cache and rebuild dependencies. Lean Runtime's explicit
project check above uses the exact pinned context rather than discovery.

`PrimeLambdaDigits` is the optional expensive 26-decimal-place enclosure.
`Tests` includes sparse/powerset agreement, the smaller digit certificate,
public import checks, and kernel-trust audits. All original theorem proofs
and copyright headers are preserved, apart from module/namespace changes.

## Example

```lean
import QProduct.LeanCert
open QProduct

example : ((19 / 36 : ℚ) : ℝ) ≤ primeLambda ∧
    primeLambda ≤ ((7 / 12 : ℚ) : ℝ) :=
  LeanCert.Validity.verify_limit_interval
    primeLambda_le_shiftedTrunc shiftedTrunc_sub_tail_le_primeLambda
    1 (19 / 36) (7 / 12) (by native_decide)
```

## Publishing

This project has not been published and has no configured remote. Before a
standalone release, replace the local LeanCert path with an exact Git revision
containing the extraction, remove the shared `packagesDir` setting, and
regenerate the manifest. CI currently provisions the documented two-checkout
layout against the LeanCert extraction commit recorded in `SOURCE.md`; update
that pin to the merged revision if the branch is squashed or rebased.

## Documentation

- [Q-product certificates](docs/certificates/qproduct.md)
- [Prime limits](docs/domains/qproduct-prime-limits.md)
- [Directed-limit integration](docs/proof-templates/directed-limits.md)
- [ConstantFactory](docs/certificates/constants.md)
- [Provenance and migration](SOURCE.md)
