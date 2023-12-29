//
//  MultiPeer.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import MultipeerConnectivity

enum DataType {
  case rawFood([FoodItem])
  case mealCaptured([CapturedMeal])
}

/// Main Class for MultiPeer
internal class MultiPeer: NSObject, MCAdvertiserAssistantDelegate {
  
  // MARK: Properties
  
  /** Conforms to MultiPeerDelegate: Handles receiving data and changes in connections */
  internal weak var delegate: MultiPeerDelegate?
  
  /** Name of MultiPeer session: Up to one hyphen (-) and 15 characters */
  private var serviceType: String!
  
  /** Device's name */
  private var devicePeerID: MCPeerID!
  
  /** Advertises session */
  private var serviceAdvertiser: MCNearbyServiceAdvertiser!
  
  /** Browses for sessions */
  private var serviceBrowser: MCNearbyServiceBrowser!
  
  /// Amount of time to spend connecting before timeout
  private var connectionTimeout = 30.0
  
  /// Peers available to connect to
  private var availablePeers: [Peer] = []
  
  /// Peers connected to
  private var connectedPeers: [Peer] = []
  
  /// Names of all connected devices
  private var connectedDeviceNames: [String] {
    return session.connectedPeers.map({$0.displayName})
  }
  
  /// Prints out all errors and status updates
  private var debugMode = false
  
  /** Main session object that manages the current connections */
  private lazy var session: MCSession = {
    let session = MCSession(peer: self.devicePeerID, securityIdentity: nil, encryptionPreference: .none)
    session.delegate = self
    return session
  }()
  
  // MARK: - Initializers
  
  /// Initializes the MultiPeer service with a serviceType and the default deviceName
  /// - Parameters:
  ///     - serviceType: String with name of MultiPeer service. Up to one hyphen (-) and 15 characters.
  /// Uses default device name
  internal func initialize(serviceType: String) {
    initialize(serviceType: serviceType, deviceName: UIDevice.current.name)
  }
  
  /// Initializes the MultiPeer service with a serviceType and a custom deviceName
  /// - Parameters:
  ///     - serviceType: String with name of MultiPeer service. Up to one hyphen (-) and 15 characters.
  ///     - deviceName: String containing custom name for device
  private func initialize(serviceType: String, deviceName: String) {
    // Setup device/session properties
    self.serviceType = serviceType
    self.devicePeerID = MCPeerID(displayName: deviceName)
    
    // Setup the service advertiser
    self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: devicePeerID,
                                                       discoveryInfo: nil,
                                                       serviceType: serviceType)
    
    self.serviceAdvertiser.delegate = self
    
    // Setup the service browser
    self.serviceBrowser = MCNearbyServiceBrowser(peer: self.devicePeerID,
                                                 serviceType: serviceType)
    self.serviceBrowser.delegate = self
  }
  
  // deinit: stop advertising and browsing services
  deinit {
    disconnect()
  }
  
  // MARK: - Methods
  
  /// HOST: Automatically browses and invites all found devices
  private func startInviting() {
    self.serviceBrowser.startBrowsingForPeers()
  }
  
  /// JOIN: Automatically advertises and accepts all invites
  private func startAccepting() {
    self.serviceAdvertiser.startAdvertisingPeer()
  }
  
  /// HOST and JOIN: Uses both advertising and browsing to connect.
  internal func autoConnect() {
    startInviting()
    startAccepting()
  }
  
  /// Stops the invitation process
  private func stopInviting() {
    self.serviceBrowser.stopBrowsingForPeers()
  }
  
  /// Stops accepting invites and becomes invisible on the network
  private func stopAccepting() {
    self.serviceAdvertiser.stopAdvertisingPeer()
  }
  
  /// Stops all invite/accept services
  private func stopSearching() {
    stopAccepting()
    stopInviting()
  }
  
  /// Disconnects from the current session and stops all searching activity
  private func disconnect() {
    session.disconnect()
    connectedPeers.removeAll()
    availablePeers.removeAll()
  }
  
  /// Stops all invite/accept services, disconnects from the current session, and stops all searching activity
  private func end() {
    stopSearching()
    disconnect()
  }
  
  /// Returns true if there are any connected peers
  private var isConnected: Bool {
    return connectedPeers.count > 0
  }
  
  /// Sends Data (and type) to all connected peers.
  /// - Parameters:
  ///     - data: Data (Data) to send to all connected peers.
  /// After sending the data, you can use the extension for Data, to convert it back into data.
  internal func send(_ data: Data) {
    if isConnected {
      try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
    }
  }
  
  /** Prints only if in debug mode */
  fileprivate func printDebug(_ string: String) {
    if debugMode {
      print(string)
    }
  }
}

// MARK: - Advertiser Delegate
extension MultiPeer: MCNearbyServiceAdvertiserDelegate {
  
  /// Received invitation
  internal func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    
    OperationQueue.main.addOperation { [unowned self] in
      invitationHandler(true, self.session)
    }
  }
  
  /// Error, could not start advertising
  internal func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
    printDebug("Could not start advertising due to error: \(error)")
  }
  
}

// MARK: - Browser Delegate
extension MultiPeer: MCNearbyServiceBrowserDelegate {
  
  /// Found a peer, update the list of available peers
  internal func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
    printDebug("Found peer: \(peerID)")
    
    // Update the list of available peers
    availablePeers.append(Peer(peerID: peerID, state: .notConnected))
    
    browser.invitePeer(peerID, to: session, withContext: nil, timeout: connectionTimeout)
  }
  
  /// Lost a peer, update the list of available peers
  internal func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    printDebug("Lost peer: \(peerID)")
    
    // Update the lost peer
    availablePeers = availablePeers.filter { $0.peerID != peerID }
  }
  
  /// Error, could not start browsing
  internal func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    printDebug("Could not start browsing due to error: \(error)")
  }
  
}

// MARK: - Session Delegate
extension MultiPeer: MCSessionDelegate {
  
  /// Peer changed state, update all connected peers and send new connection list to delegate connectedDevicesChanged
  internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    // If the new state is connected, then remove it from the available peers
    // Otherwise, update the state
    if state == .connected {
      availablePeers = availablePeers.filter { $0.peerID != peerID }
      printDebug("Peer \(peerID.displayName) changed to connected.")
    } else {
      availablePeers.filter { $0.peerID == peerID }.first?.state = state
      printDebug("Peer \(peerID.displayName) changed to not connected.")
    }
    
    // Update all connected peers
    connectedPeers = session.connectedPeers.map { Peer(peerID: $0, state: .connected) }
    
    // Send new connection list to delegate
    OperationQueue.main.addOperation { [unowned self] in
      self.delegate?.multiPeer(connectedDevicesChanged: session.connectedPeers.map({$0.displayName}))
    }
  }
  
  /// Received data, update delegate didRecieveData
  internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    printDebug("Received data: \(data.count) bytes")
    
    OperationQueue.main.addOperation { [unowned self] in
      self.delegate?.multiPeer(didReceiveData: data)
    }
  }
  
  /// Received stream
  internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
  
  /// Started receiving resource
  internal func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
  
  /// Finished receiving resource
  internal func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
  
}

// MARK: - Data extension for conversion
extension Data {
  public func toFoodItem() -> [FoodItem]? {
    return try? JSONDecoder().decode([FoodItem].self, from: self)
  }
  
  public func toCapturedMeal() -> [CapturedMeal]? {
    return try? JSONDecoder().decode([CapturedMeal].self, from: self)
  }
}
