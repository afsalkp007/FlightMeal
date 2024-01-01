//
//  APIServiceProtocol.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

typealias MealResponseHandler = (Result<MealResponse?>) -> Void

protocol APIServiceProtocol {
  func fetchMeals(_ completion: @escaping MealResponseHandler)
}

extension APIServiceProtocol {
  func fetchMeals(_ completion: @escaping MealResponseHandler) {}
}
