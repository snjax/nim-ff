
import stint
export stint

type
    FFOrder* = object 
        data*: UInt256

    FF*[order:static[FFOrder]] = object
        data*: UInt256

func ff_order*(s:string): FFOrder {.inline.} = FFOrder(data: s.u256)

func ff*(n:UInt256, order:static[FFOrder]) : FF[order] {.inline.} =
    result.data = n mod order.u256

func ff*(n:SomeInteger|string, order:static[FFOrder]) : FF[order] {.inline.} =
    result.data = n.u256 mod order.u256


func `+`*[order](x,y:FF[order]): FF[order] {.inline.} = 
    result.data = addmod(x.data, y.data, order)

func `-`*[order](x,y:FF[order]): FF[order] {.inline.} = 
    result.data = submod(x.data, y.data, order.u256)

func `*`*[order](x,y:FF[order]): FF[order] {.inline.} = 
    result.data = mulmod(x.data, y.data, order.u256)

func `/`*[order](x,y:FF[order]): FF[order] {.inline.} = 
    result.data = x * y.inv


func inv*[order](x:FF[order]): FF[order] {.inline.} = 
    result.data = invmod(x.data, order.u256)

func `-`*[order](x:FF[order]): FF[order] {.inline.} = 
    result.data = order.u256 - x.data

func pow*[order](x:FF[order], y:UInt256): FF[order] {.inline.} = 
    result.data = powmod(x.data, y, order.u256)