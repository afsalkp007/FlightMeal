//
//  FoodCellViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation
import UIKit

struct FoodCellViewModel {
  var id: String
  var name: String?
  var description: String?
  var imageUrl: URL?
  
  init(item: FoodItem) {
    self.id = item.id
    self.name = item.name
    self.description = item.description
    self.imageUrl = URL(string: item.imageUrl ?? "")
  }
}
