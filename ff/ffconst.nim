import ./ffmath

const
    bn128_r* = "21888242871839275222246405745257275088548364400416034343698204186575808495617".ff_order
    bls12_r* = "52435875175126190479447740508185965837690552500527637822603658699938581184513".ff_order

type
    BN128* = FF[bn128_r]
    BLS12* = FF[bls12_r]
  
  
  
func u256*(r: FFOrder):UInt256 = r.data

func bn128*(n:SomeInteger|string|UInt256): BN128 {.inline.} = 
    n.ff(bn128_r)

func bls12*(n:SomeInteger|string|UInt256): BLS12 {.inline.} = 
    n.ff(bls12_r)
