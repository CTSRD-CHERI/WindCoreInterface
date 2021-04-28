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

import WindCoreLo  :: *;
import WindCoreMid :: *;
import WindCoreHi  :: *;

import FIFOF      :: *;
import Vector     :: *;
import GetPut     :: *;
import SourceSink :: *;
import AXI4Lite   :: *;
import Routable   :: *;

// Convert a WindCoreLo into a WindCoreMid
module windCoreLo2Mid #(
  WindCoreLo #( // AXI manager 0 port parameters
                t_axm_0_id
              , t_axm_0_addr
              , t_axm_0_data
              , t_axm_0_awuser
              , t_axm_0_wuser
              , t_axm_0_buser
              , t_axm_0_aruser
              , t_axm_0_ruser
              // AXI manager 1 port parameters
              , t_axm_1_id
              , t_axm_1_addr
              , t_axm_1_data
              , t_axm_1_awuser
              , t_axm_1_wuser
              , t_axm_1_buser
              , t_axm_1_aruser
              , t_axm_1_ruser
              // AXI subordinate 0 port parameters
              , t_axs_0_id
              , t_axs_0_addr
              , t_axs_0_data
              , t_axs_0_awuser
              , t_axs_0_wuser
              , t_axs_0_buser
              , t_axs_0_aruser
              , t_axs_0_ruse) lo
              // PLIC ?
              // Debug Module ?
              )
  (WindCoreMid #( // AXI manager 0 port parameters
                  t_axm_0_id
                , t_axm_0_addr
                , t_axm_0_data
                , t_axm_0_awuser
                , t_axm_0_wuser
                , t_axm_0_buser
                , t_axm_0_aruser
                , t_axm_0_ruser
                // AXI manager 1 port parameters
                , t_axm_1_id
                , t_axm_1_addr
                , t_axm_1_data
                , t_axm_1_awuser
                , t_axm_1_wuser
                , t_axm_1_buser
                , t_axm_1_aruser
                , t_axm_1_ruser
                // AXI subordinate 0 port parameters
                , t_axs_0_id
                , t_axs_0_addr
                , t_axs_0_data
                , t_axs_0_awuser
                , t_axs_0_wuser
                , t_axs_0_buser
                , t_axs_0_aruser
                , t_axs_0_ruser
                // Number of interrupt lines
                , t_n_irq));
  // TODO
  return ?;
endmodule

// Convert a WindCoreMid into a WindCoreHi
module windCoreMid2Hi #(
  WindCoreMid #( // AXI manager 0 port parameters
                 t_axm_0_id
               , t_axm_0_addr
               , t_axm_0_data
               , t_axm_0_awuser
               , t_axm_0_wuser
               , t_axm_0_buser
               , t_axm_0_aruser
               , t_axm_0_ruser
               // AXI manager 1 port parameters
               , t_axm_1_id
               , t_axm_1_addr
               , t_axm_1_data
               , t_axm_1_awuser
               , t_axm_1_wuser
               , t_axm_1_buser
               , t_axm_1_aruser
               , t_axm_1_ruser
               // AXI subordinate 0 port parameters
               , t_axs_0_id
               , t_axs_0_addr
               , t_axs_0_data
               , t_axs_0_awuser
               , t_axs_0_wuser
               , t_axs_0_buser
               , t_axs_0_aruser
               , t_axs_0_ruser
               // Number of interrupt lines
               , t_n_irq) mid)
  (WindCoreHi #( // AXI lite subordinate control port parameters
                 t_axls_control_addr
               , t_axls_control_data
               , t_axls_control_awuser
               , t_axls_control_wuser
               , t_axls_control_buser
               , t_axls_control_aruser
               , t_axls_control_ruser
               // AXI manager 0 port parameters
               , t_axm_0_id
               , t_axm_0_addr
               , t_axm_0_data
               , t_axm_0_awuser
               , t_axm_0_wuser
               , t_axm_0_buser
               , t_axm_0_aruser
               , t_axm_0_ruser
               // AXI manager 1 port parameters
               , t_axm_1_id
               , t_axm_1_addr
               , t_axm_1_data
               , t_axm_1_awuser
               , t_axm_1_wuser
               , t_axm_1_buser
               , t_axm_1_aruser
               , t_axm_1_ruser
               // AXI subordinate 0 port parameters
               , t_axs_0_id
               , t_axs_0_addr
               , t_axs_0_data
               , t_axs_0_awuser
               , t_axs_0_wuser
               , t_axs_0_buser
               , t_axs_0_aruser
               , t_axs_0_ruser))
  provisos ( Add #(7, t0_, t_axls_control_addr)
           , Add #(32, 0, t_axls_control_data)
           , Add #(t_n_irq, t1_, 32) );
  // TODO
  // here, discuss a standard map of the axilite requests received over the
  // WindCoreHi axi lite control port into the debug module interface, the irq
  // port and other methods of the WindCoreLo interface
  // This is currently done in the gfe repo / awsteria
  // Ask Nikhil about this...

  // setup the demuxing of the AXI lite control traffic
  // --------------------------------------------------
  let ctrlShim <- mkAXI4LiteShim;
  Vector #(1, AXI4Lite_Master #( t_axls_control_addr
                               , t_axls_control_data
                               , t_axls_control_awuser
                               , t_axls_control_wuser
                               , t_axls_control_buser
                               , t_axls_control_aruser
                               , t_axls_control_ruser ))
    managers = cons (ctrlShim.master, nil);
  Vector #(3, AXI4Lite_Slave #( t_axls_control_addr
                              , t_axls_control_data
                              , t_axls_control_awuser
                              , t_axls_control_wuser
                              , t_axls_control_buser
                              , t_axls_control_aruser
                              , t_axls_control_ruser ))
    subordinates = newVector;
  Vector #(3, Range #(t_axls_control_addr)) ranges = newVector;
  // debug traffic
  // -------------
  subordinates[0] = compose ( zeroUserFields_AXI4Lite_Slave
                            , fmapAddress_AXI4Lite_Slave (truncate) )
                            (mid.debug_subordinate);
  ranges[0] = Range { base: 'h0000_0000, size: 'h0000_0000 };
  // irq traffic
  // -----------
  FIFOF #(AXI4Lite_BFlit #(t_axls_control_buser)) bff <- mkFIFOF;
  Tuple2 #( Sink #(AXI4Lite_AWFlit #( t_axls_control_addr
                                    , t_axls_control_awuser))
          , Sink #(AXI4Lite_WFlit #( t_axls_control_data
                                   , t_axls_control_wuser)) )
    writeSinks <- splitSink (interface Sink;
    method canPut = True;
    method put (writeflit) = action
      match {.awflit, .wflit} = writeflit;
      Vector #(t_n_irq, Bool) irqBitField = unpack ( truncate (wflit.wdata));
      function Action setIrq (Put #(Bool) irqIfc, Bool doSet) = action
        if (doSet) irqIfc.put (True);
      endaction;
      function Action clearIrq (Put #(Bool) irqIfc, Bool doClear) = action
        if (doClear) irqIfc.put (False);
      endaction;
      case (awflit.awaddr[3:2])
        // first 32-bits: set irq bitfield
        0: zipWithM (setIrq, mid.irq, irqBitField);
        // second 32-bits: clear irq bitfield
        1: zipWithM (clearIrq, mid.irq, irqBitField);
        // third 32-bits: set nmirq in lsb
        2: setIrq (mid.nmirq, irqBitField[0]);
        // fourth 32-bits: clear nmirq in lsb
        3: clearIrq (mid.nmirq, irqBitField[0]);
      endcase
      bff.enq (AXI4Lite_BFlit { bresp: OKAY, buser: ? });
    endaction;
  endinterface);
  match {.awIfc, .wIfc} = writeSinks;
  match {.arIfc, .rIfc} <-
    mkReqRspPost (mkFIFOF, constFn (AXI4Lite_RFlit { rdata: ?
                                                   , rresp: SLVERR
                                                   , ruser: ? }));
  subordinates[1] = interface AXI4Lite_Slave;
    interface aw = awIfc;
    interface  w = wIfc;
    interface  b = toSource (bff);
    interface ar = arIfc;
    interface  r = rIfc;
  endinterface;
  ranges[1] = Range { base: 'h0000_0000, size: 'h0000_0000 };
  // other traffic
  // -------------
  subordinates[2] = culDeSac;
  ranges[2] = Range { base: 'h0000_0000, size: 'h0000_0000 };
  // wire it all up
  // --------------
  mkAXI4LiteBus ( routeFromMappingTable (ranges)
                , managers, subordinates );
  // exported interface
  // ------------------
  interface control_subordinate = ctrlShim.slave;
  interface manager_0 = mid.manager_0;
  interface manager_1 = mid.manager_1;
  interface subordinate_0 = mid.subordinate_0;
endmodule

endpackage
