//
//  MealDetailViewModel.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct MealDetailViewModel {
  let model: FoodItem
  let indexPath: IndexPath
  
  init(model: FoodItem,
       indexPath: IndexPath) {
    self.model = model
    self.indexPath = indexPath
  }
  
  var url: URL {
    let imageUrl = model.imageUrl ?? ""
    return URL(string: imageUrl)!
  }
}
