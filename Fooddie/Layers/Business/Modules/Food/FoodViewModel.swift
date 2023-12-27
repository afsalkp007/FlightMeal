//
//  FoodViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

final class FoodViewModel {
  
  var title = "Menu"
  
  var viewModels = FoodItem.items.map(FoodCellViewModel.init)
}
