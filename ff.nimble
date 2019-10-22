packageName   = "ff"
version       = "0.0.1"
author        = "Igor Gulamov"
description   = "Final fields"
license       = "Apache License 2.0 or MIT"
skipDirs      = @["tests", "benchmarks"]
### Dependencies

# TODO test only requirements don't work: https://github.com/nim-lang/nimble/issues/482
requires "nim >= 0.19",
         "stew",
         "https://github.com/snjax/nim-stint"

proc test(name: string, lang: string = "c") =
  if not dirExists "build":
    mkDir "build"
  --run
  switch("out", ("./build/" & name))
  setCommand lang, "tests/" & name & ".nim"

task test_debug, "Run all tests - test implementation (StUint[64] = 2x uint32":
  switch("define", "stint_test")
  test "all_tests"

task test_release, "Run all tests - prod implementation (StUint[64] = uint64":
  test "all_tests"

task test, "Run all tests - test and production implementation":
  exec "nimble test_debug"
  exec "nimble test_release"
