
import stint, options

const
  bn128_r_s = "21888242871839275222246405745257275088548364400416034343698204186575808495617"
  bls12_r_s = "52435875175126190479447740508185965837690552500527637822603658699938581184513"


type 
  FF*[bits:static[int], order:static[string]] = object
    data: StUint[bits]

  BN128=FF[256, bn128_r_s]
  BLS12=FF[256, bls12_r_s]

func ff*[bits](n:StUint[bits], order:static[string]) : FF[bits, order] {.inline.} =
  result.data = n mod order.parse(StUint[bits])

func ff*(n:SomeInteger, bits:static[int], order:static[string]) : FF[bits, order] {.inline.} =
  result.data = n.stuint(bits) mod order.parse(StUint[bits])

func ff*(n:string, bits:static[int], order:static[string]) : FF[bits, order] {.inline.} =
  result.data = n.parse(StUint[bits]) mod order.parse(StUint[bits])

func bn128*(n:SomeInteger): BN128 {.inline.} = 
  n.ff(256, bn128_r_s)

func bn128*(n:string): BN128 {.inline.} = 
  n.ff(256, bn128_r_s)

func bn128*(n:StUint): BN128 {.inline.} =
  n.ff(bn128_r_s)

func bls12*(n:SomeInteger): BLS12 {.inline.} = 
  n.ff(256, bls12_r_s)

func bls12*(n:string): BLS12 {.inline.} = 
  n.ff(256, bls12_r_s)

func bls12*(n:StUint): BLS12 {.inline.} =
  n.ff(bls12_r_s)


func `+`*[bits, order](x,y:FF[bits, order]): FF[bits, order] {.inline.} = 
  result.data = addmod(x.data, y.data, order.parse(StUint[bits]))

func `-`*[bits, order](x,y:FF[bits, order]): FF[bits, order] {.inline.} = 
  result.data = submod(x.data, y.data, order.parse(StUint[bits]))

func `*`*[bits, order](x,y:FF[bits, order]): FF[bits, order] {.inline.} = 
  result.data = mulmod(x.data, y.data, order.parse(StUint[bits]))

func inv*[bits, order](x:FF[bits, order]): FF[bits, order] {.inline.} = 
  result.data = invmod(x.data, order.parse(StUint[bits]))

func `/`*[bits, order](x,y:FF[bits, order]): FF[bits, order] {.inline.} = 
  result.data = x * y.inv

func pow*[bits, order](x:FF[bits, order], y:StUint[bits]): FF[bits, order] {.inline.} = 
  result.data = powmod(x.data, y, order.parse(StUint[bits]))