import Mathlib.Util.AssertNoSorry
import LeanCert.Tactic.Verification
import QProduct.LeanCert

assert_no_sorry QProduct.finiteIntegralRatSparse_correct
assert_no_sorry QProduct.momentRatSparse_correct
assert_no_sorry QProduct.truncatedIntegralRat_correct
assert_no_sorry QProduct.shiftedTruncSparse_sub_tail_le_primeLambda

/--
info: 'QProduct.finiteIntegralRatSparse_correct' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in
#print axioms QProduct.finiteIntegralRatSparse_correct

#assert_trust kernel QProduct.finiteIntegralRatSparse_correct
#assert_trust kernel QProduct.shiftedTruncSparse_sub_tail_le_primeLambda

assert_no_sorry QProduct.primeLambda_sandwich
assert_no_sorry QProduct.primeLambda_eq_integral_tprod
assert_no_sorry QProduct.ConstantFactory.F_union_eq_observerIntegral
assert_no_sorry QProduct.ConstantFactory.F_union_mem_observerInterval

-- The upstream audit formerly covered these modules through the LeanCert
-- umbrella. Retain a whole-library audit here, including private helpers.
open Lean in
run_meta do
  let env ← getEnv
  for (n, _) in env.constants.toList do
    if let some idx := env.getModuleIdxFor? n then
      if let some moduleName := env.header.moduleNames[idx]? then
        if moduleName.getRoot == `QProduct then
          let axioms ← collectAxioms n
          for axiomName in axioms do
            unless #[``propext, ``Classical.choice, ``Quot.sound].contains axiomName do
              throwError "Unexpected axiom {axiomName} in {n}"
