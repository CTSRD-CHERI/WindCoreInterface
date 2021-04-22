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

// This package defines the "low level" WindCore interface.
// HOPE: This interface is implemented by the Piccolo, Flute and Toooba cores.

// XXX This is a work in progress! XXX

import AXI4 :: *;
import Vector :: *;
import ClientServer :: *;

interface WindCoreLo #(
// AXI master 0 port parameters
  numeric type axm_0_id
, numeric type axm_0_addr
, numeric type axm_0_data
, numeric type axm_0_awuser
, numeric type axm_0_wuser
, numeric type axm_0_buser
, numeric type axm_0_aruser
, numeric type axm_0_ruser
// AXI master 1 port parameters
, numeric type axm_1_id
, numeric type axm_1_addr
, numeric type axm_1_data
, numeric type axm_1_awuser
, numeric type axm_1_wuser
, numeric type axm_1_buser
, numeric type axm_1_aruser
, numeric type axm_1_ruser
// AXI slave 0 port parameters
, numeric type axs_0_id
, numeric type axs_0_addr
, numeric type axs_0_data
, numeric type axs_0_awuser
, numeric type axs_0_wuser
, numeric type axs_0_buser
, numeric type axs_0_aruser
, numeric type axs_0_ruser
);

  // TODO: Unify the methods below accross Piccolo / Flute / Toooba

  // Control interfaces
  //////////////////////////////////////////////////////////////////////////////

  // reset related signals
  // ---------------------
  // TODO: better understand the need for the Bool argument
  interface Server #(Bool, Bool) cpu_reset_server;
  interface Client #(Bool, Bool) ndm_reset_client;

  // interrupt related signals
  // -------------------------
  // External interrupt sources
  // TODO:
  // * remove dependency on PLIC_Source_IFC type,
  //   (use instead: method Action  m_interrupt_req (Bool set_not_clear))
  // * maybe unify with NMI
  //interface Vector #(t_n_interrupt_sources, PLIC_Source_IFC) core_external_interrupt_sources;
  // Non-maskable interrupt request
  (* always_ready, always_enabled *)
  method Action nmi_req (Bool set_not_clear);

  // debug related signals
  // ---------------------
  // TODO: remove dependency on DMI.
  //       It consists of 3 methods: read_addr / read_data / write
  //       if reads and writes are not expected to happen at the same time,
  //       we can simplify this to a Server interface
  //interface DMI dm_dmi;
  // Can we remove this one?
  method Action set_verbosity (Bit #(4) verbosity, Bit #(64) logdelay);

  // initial core release (? still unclear...)
  // -----------------------------------------

  // TODO:
  // Is this start method in Toooba achieving something similar to the
  // ma_ddr4_ready method? If so, could these be merged in a generic
  // "core_release" method?
  method Action start (Bool is_running, Bit #(64) tohost_addr, Bit #(64) fromhost_addr);
  // see previous method comment
  method Action ma_ddr4_ready;

  /*
  // more to discuss:
  // for tandem verification
  interface Get #(Info_CPU_to_Verifier)  tv_verifier_info_get;
  // for RVFI_DII reporting
  interface Flute_RVFI_DII_Server rvfi_dii_server;
  // for perf counters reporting
  (* always_ready, always_enabled *)
  method Action send_tag_cache_master_events (Vector #(6, Bit #(1)) events);
  // For ISA tests: watch memory writes to <tohost> addr
  method Action set_watch_tohost (Bool watch_tohost, Bit #(64) tohost_addr);
  method Bit #(64) mv_tohost_value;
  // Misc. status; 0 = running, no error
  (* always_ready *) method Bit #(8) mv_status;
  */

  // Memory interfaces
  //////////////////////////////////////////////////////////////////////////////

  // AXI master 0 port parameters
  interface AXI4_Master #(
    axm_0_id
  , axm_0_addr
  , axm_0_data
  , axm_0_awuser
  , axm_0_wuser
  , axm_0_buser
  , axm_0_aruser
  , axm_0_ruser
  ) master_0;
  // AXI master 1 port parameters
  interface AXI4_Master #(
    axm_1_id
  , axm_1_addr
  , axm_1_data
  , axm_1_awuser
  , axm_1_wuser
  , axm_1_buser
  , axm_1_aruser
  , axm_1_ruser
  ) master_1;
  // AXI slave 0 port parameters
  interface AXI4_Slave #(
    axs_0_id
  , axs_0_addr
  , axs_0_data
  , axs_0_awuser
  , axs_0_wuser
  , axs_0_buser
  , axs_0_aruser
  , axs_0_ruser
  ) slave_0;

endinterface

endpackage
