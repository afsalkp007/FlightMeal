//
//  FoodItem.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

public struct FoodItem {
  var name: String
  var quantity: CGFloat
  var imageUrl: String?
  
  static var items: [FoodItem] = [
    FoodItem(name: "Pommes frites", quantity: 5, imageUrl: "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;;amp;;amp;height=420"),
    FoodItem(name: "Gyoza", quantity: 5, imageUrl: "https://cdn.tasteatlas.com//Images/Dishes/3c16ad904018488f8c363413d356cacc.jpg?width=660&;amp;;amp;;amp;height=420"),
    FoodItem(name: "Nachos", quantity: 5, imageUrl: "https://cdn.tasteatlas.com//images/dishes/a29fe2d3d9c54547a9e49c49f5cf22cd.jpg?width=660&;amp;;amp;;amp;height=420")
  ]
}

extension FoodItem: Codable {
  enum CodingKeys: String, CodingKey {
    case name
    case quantity
    case imageUrl = "image"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeValue(forKey: .name)
    quantity = try container.decodeValue(forKey: .quantity)
    imageUrl = try container.decodeValueIfPresent(forKey: .imageUrl)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(quantity, forKey: .quantity)
    try container.encode(imageUrl, forKey: .imageUrl)
  }
}

extension Array where Element == FoodItem {
  var data: Data? {
    return try? JSONEncoder().encode(self)
  }
  
  var models: [FoodCellViewModel] {
    return map(FoodCellViewModel.init)
  }
}
