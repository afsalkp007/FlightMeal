//
//  Coordinatable.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import UIKit

protocol Coordinatable {
  var navigationController: UINavigationController { get set }
  func start()
  func start(_ model: FoodItem, at indexPath: IndexPath, from fc: MealViewController?)
  func start(_ items: [Order])
  func dismiss()
}

extension Coordinatable {
  func start() {}
  func start(_ model: FoodItem, at indexPath: IndexPath, from fc: MealViewController?) {}
  func start(_ items: [Order]) {}
  func dismiss() {}
}
