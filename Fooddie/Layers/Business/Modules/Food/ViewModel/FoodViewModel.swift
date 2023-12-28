//
//  FoodViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewModel {
  let multipeerService: MultiPeer
  let apiService: APIServiceProtocol
  
  var foodItems: [FoodItem]!
  var updateUI: (([FoodItem]) -> Void)?
  
  var cellSize: CGSize {
    let screenSize = UIScreen.main.bounds
    let sWidth = screenSize.width * 0.4
    let width = sWidth > 280 ? sWidth : 280
    return CGSize(width: screenSize.width / 2 - 24, height: width)
  }
  
  init(multipeer: MultiPeer,
       apiService: APIServiceProtocol = APIService()) {
    self.multipeerService = multipeer
    self.apiService = apiService
    
    fetchItems()
    setupConnectivity()
  }
  
  private func fetchItems() {
    apiService.fetchFoodItems { [weak self] result in
      switch result {
      case let .success(response):
        guard let items = response?.foodItems else { return }
        self?.foodItems = items
        self?.updateUI?(items)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
  
  internal func setupConnectivity() {
    multipeerService.initialize(serviceType: "fooddie-mpc")
    multipeerService.autoConnect()
  }
  
  internal func send(
    stepper: Stepper = Stepper(count: 0, index: 0),
    items: [CapturedMeal] = [] ,
    type: DataType) {
    
    switch type {
    case .mealCaptured:
      guard let data = items.data else { return }
      multipeerService.send(data)
    case .rawFood:
      foodItems = getUpdatedFoodItems(stepper)
      guard let data = foodItems.data else { return }
      multipeerService.send(data)
    }
  }
  
  private func getUpdatedFoodItems(_ stepper: Stepper) -> [FoodItem] {
    return foodItems.enumerated().map { index, item in
      var newItem = item
      if stepper.index == index {
        newItem.quantity = stepper.count
      }
      return newItem
    }
  }
}
