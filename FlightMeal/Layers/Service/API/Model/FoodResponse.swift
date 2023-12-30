//
//  FoodResponse.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodResponse {
  var foodItems: [FoodItem]?
}

extension FoodResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case foodItems = "data"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    foodItems = try container.decodeValueIfPresent(forKey: .foodItems)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(foodItems, forKey: .foodItems)
  }
  
  static func make(data: Data) -> FoodResponse? {
    return try? JSONDecoder().decode(FoodResponse.self, from: data)
  }
}
