//
//  APIService.swift
//  FlightMeal
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
  
  /// Fetch meal data
  /// - Parameter completion: Called when operation finishes
  /// https://yummie.glitch.me/dishes/cat1
  func fetchMeals(_ completion: @escaping (Result<MealResponse?>) -> Void) {
    let resource = Resource(
      url: Constants.Urls.mealUrl,
      path: "dishes/cat1")
    _ = networking.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(.success(data.flatMap({ MealResponse.make(data: $0) }) ))
      }
    })
  }
}
