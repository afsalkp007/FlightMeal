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
      setTitle()
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
        self?.viewModels = Self.getFoodCellViewModels(from: results)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private static func getFoodCellViewModels(from response: FoodResponse?) -> [FoodCellViewModel] {
    guard let foodItems = response?.foodItems else { return [] }
    return foodItems.compactMap(FoodCellViewModel.init)
  }
  
  func setTitle() {
    title = "Menu"
  }
  
  func modelFor(indexPath: IndexPath) -> FoodCellViewModel {
    return viewModels[indexPath.row]
  }
}
