//
//  FoodDataTest.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import XCTest
@testable import Fooddie

class FoodDataTest: XCTestCase {
  
  func testParsing() throws {
    let json: [String: Any] = [
      "name": "Pommes frites",
      "image": "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;height=420",
      "calories": 120
    ]
    
    let data = try JSONSerialization.data(withJSONObject: json, options: [])
    let decoder = JSONDecoder()
    let foodItem = try decoder.decode(FoodItem.self, from: data)
    
    XCTAssertEqual(foodItem.name, "Pommes frites")
    XCTAssertEqual(foodItem.quantity, 120)
    XCTAssertEqual(foodItem.imageUrl, "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;height=420")
  }
}
