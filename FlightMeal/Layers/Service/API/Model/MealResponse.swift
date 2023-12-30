//
//  MealResponse.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct MealResponse {
  var meals: [Meal]?
}

extension MealResponse: Codable {
  enum CodingKeys: String, CodingKey {
    case meals = "data"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    meals = try container.decodeValueIfPresent(forKey: .meals)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(meals, forKey: .meals)
  }
  
  static func make(data: Data) -> MealResponse? {
    return try? JSONDecoder().decode(MealResponse.self, from: data)
  }
}
