//
//  MultiPeerDelegate.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

internal protocol MultiPeerDelegate: AnyObject {
  func multiPeer(didReceiveData items: [FoodItem])
  func multiPeer(connectedDevicesChanged devices: [String])
}

extension MultiPeerDelegate {
  func multiPeer(didReceiveData items: [FoodItem]) {}
  func multiPeer(connectedDevicesChanged devices: [String]) {}
}
