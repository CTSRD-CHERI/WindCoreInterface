/*-
 * Copyright (c) 2021 Alexandre Joannou
 * All rights reserved.
 *
 * This software was developed by SRI International and the University of
 * Cambridge Computer Laboratory (Department of Computer Science and
 * Technology) under DARPA contract HR0011-18-C-0016 ("ECATS"), as part of the
 * DARPA SSITH research programme.
 *
 * @BERI_LICENSE_HEADER_START@
 *
 * Licensed to BERI Open Systems C.I.C. (BERI) under one or more contributor
 * license agreements.  See the NOTICE file distributed with this work for
 * additional information regarding copyright ownership.  BERI licenses this
 * file to you under the BERI Hardware-Software License, Version 1.0 (the
 * "License"); you may not use this file except in compliance with the
 * License.  You may obtain a copy of the License at:
 *
 *   http://www.beri-open-systems.org/legal/license-1-0.txt
 *
 * Unless required by applicable law or agreed to in writing, Work distributed
 * under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * @BERI_LICENSE_HEADER_END@
 */

package WindCoreLo;

// This package defines the "low level" WindCore interface as well as some
// helper types and functions
// HOPE: This interface is implemented by the Piccolo, Flute and Toooba cores.

// NOTE: The debug module and the PLIC are currently instantiated inside the
// Piccolo / Flute / Toooba core. There is a general intention for these to
// eventually be instantiated separately, effectively putting different
// requirements on the core interface. The current file is describing what is
// currently referred to as the "low-level" WindCore interface. It is expected
// that when the PLIC and debug module are handled separately from the cores,
// a possibly lower level interface will be desirable. Hopefully, the interface
// described here can remain as a "mid-level" interface on which the utils
// defined in the WindCoreUtils package can still rely.

// XXX This is a work in progress! XXX

import AXI4 :: *;
import Vector :: *;
import ClientServer :: *;

// Debug module interface helpers
// ------------------------------
// Debug module server for requests to the debug module
// * ReadReq should generate a ReadRsp
// * WriteReq should not generate any response
// * ResetReq should not generate any response
typedef union tagged {
  Bit #(7)                     ReadReq;
  Tuple2#(Bit #(7), Bit #(32)) WriteReq;
  void                         ResetReq;
} DebugModuleReq deriving (Bits);
typedef union tagged {
  Bit #(32) ReadRsp;
} DebugModuleRsp deriving (Bits);
typedef Server #(DebugModuleReq, DebugModuleRsp) DebugModuleServer;
// Debug module Reset client. Needed only since the debug module is currently
// still embedded inside the core. Used to route the reset commands generated
// by the debug module to the core.
typedef Client #(void, void) DebugModuleResetClient;

// Interrupt interface helpers
// ---------------------------
interface SetClear;
  method Action set();
  method Action clear();
endinterface

// Other control and status interface helpers
// ------------------------------------------
// Control and Status server for general requests to the core
// * ReleaseReq should release the core from a blocking state. It should not
//   generate any response
// * StatusReq should generate a response returning a status code from the core
typedef union tagged {
  void ReleaseReq;
  void StatusReq;
} ControlStatusReq deriving (Bits);
typedef union tagged {
  Bit #(8) StatusRsp;
} ControlStatusRsp deriving (Bits);
typedef Server #(ControlStatusReq, ControlStatusRsp) ControlStatusServer;

// The low lever WindCore interface
// --------------------------------
interface WindCoreLo #(
// AXI manager 0 port parameters
  numeric type t_axm_0_id
, numeric type t_axm_0_addr
, numeric type t_axm_0_data
, numeric type t_axm_0_awuser
, numeric type t_axm_0_wuser
, numeric type t_axm_0_buser
, numeric type t_axm_0_aruser
, numeric type t_axm_0_ruser
// AXI manager 1 port parameters
, numeric type t_axm_1_id
, numeric type t_axm_1_addr
, numeric type t_axm_1_data
, numeric type t_axm_1_awuser
, numeric type t_axm_1_wuser
, numeric type t_axm_1_buser
, numeric type t_axm_1_aruser
, numeric type t_axm_1_ruser
// AXI subordinate 0 port parameters
, numeric type t_axs_0_id
, numeric type t_axs_0_addr
, numeric type t_axs_0_data
, numeric type t_axs_0_awuser
, numeric type t_axs_0_wuser
, numeric type t_axs_0_buser
, numeric type t_axs_0_aruser
, numeric type t_axs_0_ruser
// Number of interrupt lines
, numeric type t_n_irq
);

  // Control interfaces
  //////////////////////////////////////////////////////////////////////////////

  // NOTE: the `interface Server #(Bool, Bool) cpu_reset_server` is replaced by
  // the standard bsv managed reset. Note that it should *NOT* reset the debug
  // module in the individual implementations, and a dedicated debug module
  // reset request should be used instead.

  // debug related signals
  // ---------------------
  // NOTE:
  // It is intended that the debug module would eventually be moved out of the
  // cores implementing this interface. In the meantime, the front end to the
  // debug module is exposed here in a Server interface supporting resets, reads
  // and write requests.
  // It is currently expected that Piccolo / Flute / Toooba would handle a
  // debug module ResetReq using the `assertReset` method of a `MakeResetIfc`
  // from a `mkReset` module, and use the associated `new_rst` signal as input
  // to the `reset_by` attribute on the debug module instance.
  // This interface should provide the functionalities that used to be supported
  // in Piccolo / Flute / Toooba by:
  // `interface DMI dm_dmi;`
  interface DebugModuleServer debugModuleServer;
  // The following interface implements the functionality of the legacy
  // `interface Client #(Bool, Bool) ndm_reset_client;`
  interface DebugModuleResetClient debugModuleResetClient;

  // interrupt related signals
  // -------------------------
  // NOTE:
  // The following interfaces provide the functionality of the Piccolo / Flute /
  // Toooba interfaces:
  // `interface Vector #(t_n_interrupt_sources, PLIC_Source_IFC) core_external_interrupt_sources;`
  // `method Action nmi_req (Bool set_not_clear);`
  interface Vector #(t_n_irq, SetClear) irq;
  interface SetClear nmirq;

  // other control and status signals
  // --------------------------------
  // NOTE:
  // The following interfaces provide the functionality of the Piccolo / Flute /
  // Toooba interfaces:
  // `method Action start (Bool is_running, Bit #(64) tohost_addr, Bit #(64) fromhost_addr);`
  // `method Action ma_ddr4_ready;`
  // `method Bit #(8) mv_status;`
  interface ControlStatusServer controlStatusServer;

  // TODO:
  // XXX
  // The following information (tohost) actually sound static to me.
  // It probably does not belong in an interface, but rather, should be passed
  // as module arguments
  // `method Action set_watch_tohost (Bool watch_tohost, Bit #(64) tohost_addr);`
  // `method Bit #(64) mv_tohost_value;`
  // XXX Can we remove this one?
  // method Action set_verbosity (Bit #(4) verbosity, Bit #(64) logdelay);
  // XXX more to discuss:
  // for tandem verification
  // `interface Get #(Info_CPU_to_Verifier)  tv_verifier_info_get;`
  // for RVFI_DII reporting
  // `interface Flute_RVFI_DII_Server rvfi_dii_server;`
  // for perf counters reporting
  // `method Action send_tag_cache_master_events (Vector #(6, Bit #(1)) events);`

  // Memory interfaces
  //////////////////////////////////////////////////////////////////////////////

  // AXI manager 0 port parameters
  interface AXI4_Master #(
    t_axm_0_id
  , t_axm_0_addr
  , t_axm_0_data
  , t_axm_0_awuser
  , t_axm_0_wuser
  , t_axm_0_buser
  , t_axm_0_aruser
  , t_axm_0_ruser
  ) manager_0;
  // AXI manager 1 port parameters
  interface AXI4_Master #(
    t_axm_1_id
  , t_axm_1_addr
  , t_axm_1_data
  , t_axm_1_awuser
  , t_axm_1_wuser
  , t_axm_1_buser
  , t_axm_1_aruser
  , t_axm_1_ruser
  ) manager_1;
  // AXI subordinate 0 port parameters
  interface AXI4_Slave #(
    t_axs_0_id
  , t_axs_0_addr
  , t_axs_0_data
  , t_axs_0_awuser
  , t_axs_0_wuser
  , t_axs_0_buser
  , t_axs_0_aruser
  , t_axs_0_ruser
  ) subordinate_0;

endinterface

endpackage
