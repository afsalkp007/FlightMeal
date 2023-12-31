//
//  Peer.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import MultipeerConnectivity

/// Class containing peerID and session state
internal class PeerDevice {
  internal let peerID: MCPeerID
  internal var state: MCSessionState
  internal let uuid: String?
  internal let connectionTime: Date?
  
  init(peerID: MCPeerID, state: MCSessionState) {
    self.peerID = peerID
    self.state = state
    self.uuid = UUID().uuidString
    self.connectionTime = Date()
  }
}

extension Array where Element == PeerDevice {
  var peers: [MCPeerID] {
    map(\.peerID)
  }
}
