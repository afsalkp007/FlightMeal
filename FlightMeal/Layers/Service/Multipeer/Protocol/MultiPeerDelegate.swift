//
//  MultiPeerDelegate.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

internal protocol MultiPeerDelegate: AnyObject {
  func multiPeer(didReceiveData data: Data)
  func multiPeer(connectedDevicesChanged devices: [String])
}

extension MultiPeerDelegate {
  func multiPeer(didReceiveData data: Data) {}
  func multiPeer(connectedDevicesChanged devices: [String]) {}
}
