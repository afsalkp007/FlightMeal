//
//  HTTPMethod.swift
//  FlightMeal
//
//  Created by Afsal on 30/12/2023.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  
  var value: String {
    rawValue
  }
}
