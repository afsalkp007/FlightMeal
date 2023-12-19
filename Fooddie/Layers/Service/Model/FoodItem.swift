//
//  FoodItem.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodItem {
  var id: String
  var name: String
  var description: String?
  var imageUrl: String?
}

extension FoodItem: Codable {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case imageUrl = "image"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeValue(forKey: .id)
    name = try container.decodeValue(forKey: .name)
    description = try container.decodeValueIfPresent(forKey: .description)
    imageUrl = try container.decodeValueIfPresent(forKey: .imageUrl)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .name)
    try container.encode(description, forKey: .imageUrl)
    try container.encode(id, forKey: .name)
    try container.encode(description, forKey: .imageUrl)
  }
}
