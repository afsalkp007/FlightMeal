//
//  FoodCellViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation
import UIKit

struct FoodCellViewModel {
  var name: String?
  var quantity: Int?
  var imageUrl: URL?
  
  init(item: FoodItem) {
    self.name = item.name
    self.quantity = item.quantity
    self.imageUrl = URL(string: item.imageUrl ?? "")
  }
}
