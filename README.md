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

## Setup

Pinned to Lean/Mathlib **4.35.0**. LeanCert is a Git dependency pinned to its
`v4.35.0` tag (`d3e7f686`), the first release without the q-product modules;
`lake-manifest.json` records the exact revisions. LeanCert does **not** depend
on this project.

```sh
lake exe cache get
lake build
lake build Examples Tests
lake build PrimeLambdaDigits
lean-runtime check --using . --offline Examples/PrimeLambda.lean
python3 scripts/check_docs.py
```

To develop against a local LeanCert checkout, temporarily replace the `git`/`rev`
lines of the LeanCert requirement with `path = "../../leancert"` and run
`lake update LeanCert`; do not commit that change.

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

## Upgrading LeanCert

Move to a newer LeanCert release by changing `rev` in `lakefile.toml` to its tag
and running `lake update LeanCert`. Keep the toolchain equal to LeanCert's, so
the inherited Mathlib pin and cache stay consistent.

## Documentation

- [Q-product certificates](docs/certificates/qproduct.md)
- [Prime limits](docs/domains/qproduct-prime-limits.md)
- [Directed-limit integration](docs/proof-templates/directed-limits.md)
- [ConstantFactory](docs/certificates/constants.md)
- [Provenance and migration](SOURCE.md)
