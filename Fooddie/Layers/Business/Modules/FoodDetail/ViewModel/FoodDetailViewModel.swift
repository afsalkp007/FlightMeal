//
//  FoodDetailViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodDetailViewModel {
  let model: FoodItem
  
  init(model: FoodItem) {
    self.model = model
  }
  
  var url: URL {
    let imageUrl = model.imageUrl ?? ""
    return URL(string: imageUrl)!
  }
}
