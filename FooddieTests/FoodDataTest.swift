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
      "id": "item1",
      "name": "Pommes frites",
      "description": "There are not many dishes in the world that have risen to the popularity of pommes frites. Originally invented in Belgium, this simple dish is made out of potatoes that are cut into lengthwise strips and deep-fried in hot oil. Although there is some rivalry between France and Belgium concerning the exact origin of pommes frites, the fact is that there is no nation in the world which celebrates and enjoys this dish more than the Belgians.",
      "image": "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;height=420",
    ]
    
    let data = try JSONSerialization.data(withJSONObject: json, options: [])
    let decoder = JSONDecoder()
    let foodItem = try decoder.decode(FoodItem.self, from: data)
    
    XCTAssertEqual(foodItem.name, "Pommes frites")
    XCTAssertEqual(foodItem.description, "There are not many dishes in the world that have risen to the popularity of pommes frites. Originally invented in Belgium, this simple dish is made out of potatoes that are cut into lengthwise strips and deep-fried in hot oil. Although there is some rivalry between France and Belgium concerning the exact origin of pommes frites, the fact is that there is no nation in the world which celebrates and enjoys this dish more than the Belgians.")
    XCTAssertEqual(foodItem.imageUrl, "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;height=420")
  }
}
