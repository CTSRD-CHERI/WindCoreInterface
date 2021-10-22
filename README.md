# WindCoreInterface

This repo aims to unify and centralise the interfaces to the bluespec wind
cores, that is [Piccolo](https://github.com/bluespec/Piccolo),
[Flute](https://github.com/bluespec/Flute) and
[Toooba](https://github.com/bluespec/Toooba/).

The intention would be for each of these to use this WindCoreInterface as a
submodule providing them with the bluespec type of the interface for them to
implement.

This repository would allow factorising work undertaken re-wrapping the
individual cores for various higher level interfaces (typically, exposing lower
level signals such as the debugging interface through an AXI4 Lite port).
The hope is for downstream projects, consumer of the individual wind cores, to
only need develop against the types provided in this repository, hopefully
helping towards seamless swapping of specific wind core implementation.

## Notes

Provided interfaces:

* `WindCoreLo`  - not there yet
* `WindCoreMid` - currently actively being worked on
* `WindCoreHi`  - currently actively being worked on

Note: constructing a `WindCoreHi` from a `WindCoreMid` using the
`windCoreMid2Hi[_core]` module exposes via the AXI4Lite subordinate port and at
the given offsets the following:

  - offsets `0x0000_0000` -> `0x0000_0fff`: Debug Unit
  - offsets `0x0000_1000` -> `0x0000_1fff`: Interrupt lines
  - offsets `0x0000_2000` -> `0x0000_2fff`: Others (unclear what exactly...)

Additional AXI4Lite subordinates can also be explicitly mapped when using the
`_core` version of the `windCoreMid2Hi` constructor.

Currently unsupported by these interfaces:
* Tandem verification / minimal PC debugging - TODO
* RVFI-DII - TODO
* Performance counters export -
  internal? probably should not appear on the ifc?
  possibly input to `WindCoreLo`...
* to/fromHost - static? probably should not appear on the ifc?
