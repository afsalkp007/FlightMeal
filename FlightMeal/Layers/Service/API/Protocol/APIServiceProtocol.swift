//
//  APIServiceProtocol.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

protocol APIServiceProtocol {
  func fetchMeals(_ completion: @escaping (Result<MealResponse?>) -> Void)
}

extension APIServiceProtocol {
  func fetchMeals(_ completion: @escaping (Result<MealResponse?>) -> Void) {}
}
