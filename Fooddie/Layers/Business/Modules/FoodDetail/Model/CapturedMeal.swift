//
//  CapturedMeal.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import Foundation

public struct CapturedMeal: Codable {
  let meal: FoodItem
  let name: String
  
  static var items: [CapturedMeal] = []
}

extension Array where Element == CapturedMeal {
  var data: Data? {
    return try? JSONEncoder().encode(self)
  }
}
