//
//  FoodDetailViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodDetailViewModel {
  let name: String
  let quantity: CGFloat
  let imageUrl: URL?
  
  init?(model: FoodItem) {
    self.name = model.name
    self.quantity = model.quantity
    guard let imageUrl = model.imageUrl else { return nil }
    self.imageUrl = URL(string: imageUrl)
  }
}
