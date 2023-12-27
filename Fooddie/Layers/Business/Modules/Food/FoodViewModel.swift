//
//  FoodViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

final class FoodViewModel {
  let multipeerService: MultiPeer
  
  init(multipeer: MultiPeer) {
    self.multipeerService = multipeer
  }
  
  var foodItems: [FoodCellViewModel] {
    return FoodItem.items.map(FoodCellViewModel.init)
  }
  
  internal func viewWillDisappear() {
    multipeerService.end()
  }
  
  internal func setupConnectivity() {
    multipeerService.initialize(serviceType: "fooddie-mpc")
    multipeerService.autoConnect()
  }
  
  internal func send(_ items: [FoodCellViewModel]) {
    multipeerService.send(items.foodItems)
  }
}
