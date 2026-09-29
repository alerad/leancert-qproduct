# AGENTS.md

## Lean Runtime in one paragraph

Every check runs inside one exact, immutable **environment** (toolchain plus
pinned packages). Where that environment comes from is the **context**: for
files in this project it is the project's own `lean-toolchain` and
`lake-manifest.json`, which is exact, not discovered. The **verdict** is Lean's
answer inside that environment: `accepted` or `rejected`. A rejection is a
normal result (exit 1); exit 2 means Lean could not be run at all and carries
no verdict. `--json` reports the verdict as `data.verdict`.

## Project workflow

This is a standard Lean 4 and Lake project whose exact dependencies are shared
through Lean Runtime. Read `lean-toolchain`, the Lake configuration, and
`lake-manifest.json` before changing the project.

- Use `lean-runtime build` for the normal full build.
- Use `lean-runtime check PATH` for a focused source check.
- Use `lean-runtime check` to check every declared local library without
  building executables.
- Use `lean-runtime status PATH` to see which environment a file would use
  and whether anything must be downloaded, without running Lean.
- Ordinary `lake build` and editor tooling work, but `lean-runtime build` also
  serializes writes when another project uses the same shared dependencies.
- Do not edit `.lake/packages` or files reached through its package links; they
  are generated shared dependencies. Keep project changes outside `.lake`.
- Treat `lake-manifest.json` as authoritative. Do not run `lake update` or change
  dependency revisions unless the task explicitly requires it.
- Use `lean-runtime update` to preview an intentional move to the latest
  cataloged Mathlib; apply it only after reviewing the plan.
- Commands that change the project or delete local content preview first and
  apply only with `--yes`; never pass `--yes` to `update`, `adopt`, or `clean`
  unless the task explicitly asks for that change.
- Before finishing, check the changed Lean files and run the smallest relevant
  build; use `lean-runtime build` when practical.
