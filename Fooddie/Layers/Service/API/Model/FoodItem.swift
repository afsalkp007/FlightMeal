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
}
