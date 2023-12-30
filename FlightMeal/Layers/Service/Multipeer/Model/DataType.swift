//
//  DataType.swift
//  FlightMeal
//
//  Created by Afsal on 30/12/2023.
//

import Foundation

enum DataType {
  case rawFood([FoodItem])
  case mealCaptured(Order)
}
