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

package WindCoreHi;

import AXI4 :: *;
import AXI4Lite :: *;

// This package defines the "hi level" WindCore interfaces.
// It defines both a "non-synth" and a "synth" version of the hi level interface
// for easy bluespec component composition and for clean verilog generation.
// This interface aims to factor the control signals from the WindCoreLo
// interface into a single AXILite slave port, and re export the other memory
// ports.

// NOTE: typically, these two versions of the same interface would be defined
// via a macro, but it seams the verilog preprocessor used by bsc is not
// powerful enough to express this. For this reason interface is defined twice,
// and should be maintained accordingly.

///////////////////////////////////////
// "non synth in-bluespec" interface //
////////////////////////////////////////////////////////////////////////////////

interface WindCoreHi #(
// AXI lite slave control port parameters
  numeric type axls_control_addr
, numeric type axls_control_data
, numeric type axls_control_awuser
, numeric type axls_control_wuser
, numeric type axls_control_buser
, numeric type axls_control_aruser
, numeric type axls_control_ruser
// AXI master 0 port parameters
, numeric type axm_0_id
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

  // Control interface
  ////////////////////

  // AXI lite slave control port
  interface AXI4Lite_Slave #(
    axls_control_addr
  , axls_control_data
  , axls_control_awuser
  , axls_control_wuser
  , axls_control_buser
  , axls_control_aruser
  , axls_control_ruser
  ) control_slave;

  // Memory interfaces
  ////////////////////

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

//////////////////////////////////
// Replicated "synth" interface //
////////////////////////////////////////////////////////////////////////////////

interface WindCoreHi_Synth #(
// AXI lite slave control port parameters
  numeric type axls_control_addr
, numeric type axls_control_data
, numeric type axls_control_awuser
, numeric type axls_control_wuser
, numeric type axls_control_buser
, numeric type axls_control_aruser
, numeric type axls_control_ruser
// AXI master 0 port parameters
, numeric type axm_0_id
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

  // Control interface
  ////////////////////

  // AXI lite slave control port
  interface AXI4Lite_Slave_Synth #(
    axls_control_addr
  , axls_control_data
  , axls_control_awuser
  , axls_control_wuser
  , axls_control_buser
  , axls_control_aruser
  , axls_control_ruser
  ) control_slave;

  // Memory interfaces
  ////////////////////

  // AXI master 0 port parameters
  interface AXI4_Master_Synth #(
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
  interface AXI4_Master_Synth #(
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
  interface AXI4_Slave_Synth #(
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

////////////////////////////////////
// convert "non-synth" to "synth" //
////////////////////////////////////////////////////////////////////////////////

module toWindCoreHi_Synth #(
  WindCoreHi #( // AXI lite slave control port parameters
                axls_control_addr
              , axls_control_data
              , axls_control_awuser
              , axls_control_wuser
              , axls_control_buser
              , axls_control_aruser
              , axls_control_ruser
              // AXI master 0 port parameters
              , axm_0_id
              , axm_0_addr
              , axm_0_data
              , axm_0_awuser
              , axm_0_wuser
              , axm_0_buser
              , axm_0_aruser
              , axm_0_ruser
              // AXI master 1 port parameters
              , axm_1_id
              , axm_1_addr
              , axm_1_data
              , axm_1_awuser
              , axm_1_wuser
              , axm_1_buser
              , axm_1_aruser
              , axm_1_ruser
              // AXI slave 0 port parameters
              , axs_0_id
              , axs_0_addr
              , axs_0_data
              , axs_0_awuser
              , axs_0_wuser
              , axs_0_buser
              , axs_0_aruser
              , axs_0_ruser) ifc)
  (WindCoreHi_Synth #( // AXI lite slave control port parameters
                       axls_control_addr
                     , axls_control_data
                     , axls_control_awuser
                     , axls_control_wuser
                     , axls_control_buser
                     , axls_control_aruser
                     , axls_control_ruser
                     // AXI master 0 port parameters
                     , axm_0_id
                     , axm_0_addr
                     , axm_0_data
                     , axm_0_awuser
                     , axm_0_wuser
                     , axm_0_buser
                     , axm_0_aruser
                     , axm_0_ruser
                     // AXI master 1 port parameters
                     , axm_1_id
                     , axm_1_addr
                     , axm_1_data
                     , axm_1_awuser
                     , axm_1_wuser
                     , axm_1_buser
                     , axm_1_aruser
                     , axm_1_ruser
                     // AXI slave 0 port parameters
                     , axs_0_id
                     , axs_0_addr
                     , axs_0_data
                     , axs_0_awuser
                     , axs_0_wuser
                     , axs_0_buser
                     , axs_0_aruser
                     , axs_0_ruser));
  let control_slave_synth <- toAXI4Lite_Slave_Synth (ifc.control_slave);
  let master_0_synth <- toAXI4_Master_Synth (ifc.master_0);
  let master_1_synth <- toAXI4_Master_Synth (ifc.master_1);
  let slave_0_synth <- toAXI4_Slave_Synth (ifc.slave_0);
  interface control_slave = control_slave_synth;
  interface master_0 = master_0_synth;
  interface master_1 = master_1_synth;
  interface slave_0 = slave_0_synth;
endmodule

endpackage
