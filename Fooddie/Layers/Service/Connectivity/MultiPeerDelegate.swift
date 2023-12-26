//
//  MultiPeerDelegate.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

/// MultiPeerDelegate
///
/// - Delegate for MultiPeer. Conform to this interface to recieve data and be notified when connection/disconnection events occur
///
/// multiPeer(didRecieveData: Data, ofType: UInt32)
/// multiPeer(connectedDevicesChanged: [String])

public protocol MultiPeerDelegate: AnyObject {
  
  /// didReceiveData: delegate runs on receiving data from another peer
  func multiPeer(didReceiveData data: Data)
  
  /// connectedDevicesChanged: delegate runs on connection/disconnection event in session
  func multiPeer(connectedDevicesChanged devices: [String])
  
}
