//
//  APIService.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

final class APIService: APIServiceProtocol {
  private let networking: Networking
  
  init(networking: Networking = NetworkService()) {
    self.networking = networking
  }
  
  /// Fetch food data
  /// - Parameter completion: Called when operation finishes
  func fetchFoodItems(_ completion: @escaping (Result<FoodResponse?>) -> Void) {
    let resource = Resource(
      url: Constants.Urls.foddieUrl,
      path: "v3/800eb16c-a248-4780-aedf-36a34a7f42c9")
    _ = networking.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(.success(data.flatMap({ FoodResponse.make(data: $0) }) ))
      }
    })
  }
}
