//
//  Order.swift
//  FlightMeal
//
//  Created by Afsal on 28/12/2023.
//

import Foundation

public struct Order: Codable {
  let meal: Meal
  let name: String
  
  @CodableAppData(.orders)
  static var items: [Order]
}

extension Order {
  var data: Data? {
    return try? JSONEncoder().encode(self)
  }
}
