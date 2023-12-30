//
//  MealViewModel.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class MealViewModel {
  let multipeerService: MultiPeer
  let apiService: APIServiceProtocol
  
  var meals: [Meal]!
  var updateUI: (([Meal]) -> Void)?
  
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
    apiService.fetchMeals { [weak self] result in
      switch result {
      case let .success(response):
        guard let items = response?.meals else { return }
        self?.meals = items
        self?.updateUI?(items)
        self?.sendMeals(items)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
  
  internal func setupConnectivity() {
    multipeerService.initialize(serviceType: "FlightMeal-mpc")
    multipeerService.autoConnect()
  }
  
  internal func send(type: DataType) {
    
    switch type {
    case let .typeOrder(item):
      guard let data = item.data else { return }
      multipeerService.send(data)
    case let .typeMeal(items):
      meals = items
      updateUI?(items)
      sendMeals(items)
    }
  }
  
  private func sendMeals(_ items: [Meal]) {
    guard let data = items.data else { return }
    multipeerService.send(data)
  }
  
  internal func getUpdatedMeals(_ stepper: Stepper) {
    meals = meals.enumerated().map { index, item in
      var newItem = item
      if stepper.index == index {
        newItem.quantity = stepper.quantity
      }
      return newItem
    }
  }
}
