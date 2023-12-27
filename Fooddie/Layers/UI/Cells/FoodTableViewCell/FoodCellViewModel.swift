//
//  FoodCellViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation
import UIKit

struct FoodCellViewModel {
  let name: String
  var quantity: CGFloat
  let imageUrl: URL?
  
  init(item: FoodItem) {
    self.name = item.name
    self.quantity = CGFloat(item.quantity)
    self.imageUrl = URL(string: item.imageUrl ?? "")
  }
}
