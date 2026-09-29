import QProduct

-- The mathematical umbrella must remain usable without importing LeanCert.
open Lean in
run_meta do
  for moduleName in (← getEnv).header.moduleNames do
    if moduleName.getRoot == `LeanCert then
      throwError "QProduct mathematical umbrella imports {moduleName}"
