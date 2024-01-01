//
//  MockNetworkService.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import XCTest
@testable import FlightMeal

final class MockNetworkService: Networking {
  let data: Data
  init(fileName: String) {
    let bundle = Bundle(for: MockNetworkService.self)
    let url = bundle.url(forResource: fileName, withExtension: "json")!
    self.data = try! Data(contentsOf: url)
  }

  func fetch(resource: Resource, completion: @escaping DataHandler) -> URLSessionTask? {
    completion(data)
    return nil
  }
}
