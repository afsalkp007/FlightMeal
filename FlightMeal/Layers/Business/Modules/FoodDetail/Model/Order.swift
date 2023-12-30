//
//  Order.swift
//  FlightMeal
//
//  Created by Afsal on 28/12/2023.
//

import Foundation

public struct Order: Codable {
  let meal: FoodItem
  let name: String
  
  @CodableAppData(.capturedItems)
  static var items: [Order]
}

extension Order {
  var data: Data? {
    return try? JSONEncoder().encode(self)
  }
}
