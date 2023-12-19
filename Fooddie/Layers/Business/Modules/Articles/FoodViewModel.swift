//
//  FoodViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

final class FoodViewModel {
  
  let foodService: APIServiceProtocol
  var updateUI: () -> Void = { }
  var title = ""
  
  var viewModels = [FoodCellViewModel]() {
    didSet {
      updateView()
      updateUI()
    }
  }
  
  init(
    foodService: APIServiceProtocol = APIService()
  ) {
    self.foodService = foodService
    getFoodItems()
  }

  func getFoodItems() {
    foodService.fetchFoodItems { [weak self] result in
      switch result {
      case .success(let results):
        guard let self = self, let foodItems = results?.foodItems else { return }
        self.viewModels = foodItems.compactMap(FoodCellViewModel.init)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  func updateView() {
    title = "Menu"
  }
  
  func modelFor(indexPath: IndexPath) -> FoodCellViewModel {
    return viewModels[indexPath.row]
  }
}
