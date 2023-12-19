//
//  APIServiceProtocol.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

protocol APIServiceProtocol {
  func fetchFoodItems(_ completion: @escaping (Result<FoodResponse?>) -> Void)
}

extension APIServiceProtocol {
  func fetchFoodItems(_ completion: @escaping (Result<FoodResponse?>) -> Void) { }
}
