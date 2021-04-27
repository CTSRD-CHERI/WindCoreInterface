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

Currently unsupported by these interfaces:
* Tandem verification / minimal PC debugging - TODO
* RVFI-DII - TODO
* Performance counters export -
  internal? probably should not appear on the ifc?
  possibly input to `WindCoreLo`...
* to/fromHost - static? probably should not appear on the ifc?
