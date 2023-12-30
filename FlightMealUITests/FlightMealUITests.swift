//
//  FlightMealUITests.swift
//  FlightMealUITests
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import XCTest

@testable import FlightMeal

class FlightMealUITests: XCTestCase {
  
  func testExample() throws {
            let app = XCUIApplication()
    app.launch()
  }
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
