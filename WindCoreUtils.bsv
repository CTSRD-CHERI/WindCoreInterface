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

package WindCoreUtils;

import WindCoreLo :: *;
import WindCoreHi :: *;

// Convert a WindCoreLo into a WindCoreHi
module windCoreLo2Hi #(
  WindCoreLo #( // AXI master 0 port parameters
                axm_0_id
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
              , axs_0_ruser) lo)
  (WindCoreHi #( // AXI lite slave control port parameters
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
  // TODO
  // here, discuss a standard map of the axilite requests received over the
  // WindCoreHi axi lite control port into the debug module interface, the irq
  // port and other methods of the WindCoreLo interface
  // This is currently done in the gfe repo / awsteria
  // Ask Nikhil about this...
  interface control_slave = ?; // use an internal axi lite shim
  interface master_0 = lo.master_0;
  interface master_1 = lo.master_1;
  interface slave_0 = lo.slave_0;
endmodule

endpackage
