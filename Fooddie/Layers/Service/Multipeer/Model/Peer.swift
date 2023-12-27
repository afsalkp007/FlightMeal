//
//  Peer.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import MultipeerConnectivity

/// Class containing peerID and session state
public class Peer {
  
  var peerID: MCPeerID
  var state: MCSessionState
  
  init(peerID: MCPeerID, state: MCSessionState) {
    self.peerID = peerID
    self.state = state
  }
}
