//
//  Networking.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

protocol Networking {

  /// Fetch data from url and parameters query
  ///
  /// - Parameters:
  ///   - url: The url
  ///   - parameters: Parameters as query items
  ///   - completion: Called when operation finishes
  /// - Returns: The data task
  @discardableResult func fetch(
    resource: Resource,
    completion: @escaping (Data?) -> Void
  ) -> URLSessionTask?
}
