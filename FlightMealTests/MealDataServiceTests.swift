//
//  MealDataServiceTests.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import XCTest
@testable import FlightMeal

class MealDataServiceTests: XCTestCase {
  
  func testFetchWeatherData() {
    let expectation = self.expectation(description: #function)
    let mockNetworkService = MockNetworkService(fileName: "meal")
    let foodService = APIService(networking: mockNetworkService)
    
    foodService.fetchFoodItems { result in
      switch result {
      case .success(let response):
        let foodItem = response?.foodItems?.first ?? nil
        XCTAssertEqual(foodItem?.name, "Pommes frites")
        XCTAssertEqual(foodItem?.imageUrl, "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;height=420")
        expectation.fulfill()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    wait(for: [expectation], timeout: 1)
  }
}
