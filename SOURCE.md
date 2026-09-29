# Provenance and migration

Extracted from https://github.com/alerad/leancert at commit
`69d38e677c074b4a4697183d7fedda28955a6265` (2026-09-22).
Original Apache-2.0 license and source copyright notices are retained.

The mathematical modules under `LeanCert/QProduct/` move to `QProduct/`.
`LimitCert` and `Sparse` move to `QProduct/LeanCert/`; ConstantFactory moves
to `QProduct/ConstantFactory.lean`, with `IntervalBank` under
`QProduct/LeanCert/`. Their examples, digit tests, and trust checks move too.

The `LeanCert.QProduct` namespace becomes `QProduct`; the
`LeanCert.ConstantFactory` namespace becomes `QProduct.ConstantFactory`.
The old `LeanCert` umbrella aliases are intentionally not recreated.
Generic `QPoly`, Bernstein, integration, and directed-limit machinery remain
in LeanCert. The extraction branch in that repository is
`refactor/extract-qproduct`; its extraction commit
`a9a0a8b07964c6bb0343f7e1ea6ca14d58819798` (with the q-product modules
removed from LeanCert) is the revision CI builds against.
