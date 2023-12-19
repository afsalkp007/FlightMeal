//
//  FoodDataServiceTests.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import XCTest
@testable import Fooddie

class FoodDataServiceTests: XCTestCase {
  
  func testFetchWeatherData() {
    let expectation = self.expectation(description: #function)
    let mockNetworkService = MockNetworkService(fileName: "food")
    let foodService = APIService(networking: mockNetworkService)
    
    foodService.fetchFoodItems { result in
      switch result {
      case .success(let response):
        let foodItem = response?.foodItems?.first ?? nil
        XCTAssertEqual(foodItem?.name, "Pommes frites")
        XCTAssertEqual(foodItem?.description, "There are not many dishes in the world that have risen to the popularity of pommes frites. Originally invented in Belgium, this simple dish is made out of potatoes that are cut into lengthwise strips and deep-fried in hot oil. Although there is some rivalry between France and Belgium concerning the exact origin of pommes frites, the fact is that there is no nation in the world which celebrates and enjoys this dish more than the Belgians.")
        XCTAssertEqual(foodItem?.imageUrl, "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;height=420")
        expectation.fulfill()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: 1)
  }
}
