import macros, options

import ./ffconst, ./ffmath
export options



macro make_optional_ff_ops(op: untyped): untyped =
  result = newStmtList()

  result.add quote do:
    proc `op`*[order](a, b: Option[FF[order]]): Option[FF[order]] {.inline.} =
      if a.isNone or b.isNone:
        FF[order].none
      else:
        `op`(a.get, b.get).some

  result.add quote do:
    proc `op`*[order](a: Option[FF[order]], b: FF): Option[FF[order]] {.inline.} =
      if a.isNone:
        FF[order].none
      else:
        `op`(a.get, b).some

  result.add quote do:
    proc `op`*[order](a: FF, b: Option[FF[order]]): Option[FF[order]] {.inline.} =
      if b.isNone:
        FF[order].none
      else:
        `op`(a, b.get).some

macro make_optional_ff_ops_unary(op: untyped): untyped =
  result = newStmtList()

  result.add quote do:
    proc `op`*[order](a: Option[FF[order]]): Option[FF[order]] {.inline.}=
      if a.isNone:
        FF[order].none
      else:
        `op`(a.get).some



make_optional_ff_ops(`+`)
make_optional_ff_ops(`-`)
make_optional_ff_ops(`*`)
make_optional_ff_ops(`/`)

make_optional_ff_ops_unary(`-`)
make_optional_ff_ops_unary(inv)



func obn128*(n:SomeInteger|string|UInt256): Option[BN128] {.inline.} = 
  some(n.bn128)

func obls12*(n:SomeInteger|string|UInt256): Option[BLS12] {.inline.} = 
  some(n.bls12)
