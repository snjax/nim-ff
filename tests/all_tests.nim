# Stint
# Copyright 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import unittest
import stint
import "../ff.nim"

suite "Final field test":
  test "test inverse function":
    block:
      check: 3.bn128.inv == "14592161914559516814830937163504850059032242933610689562465469457717205663745".bn128
