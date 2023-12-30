//
//  Coordinatable.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
  var navigationController: UINavigationController { get set }
  func start()
  func start(_ model: Meal, at indexPath: IndexPath, from fc: MealViewController?)
  func start(_ items: [Order])
  func dismiss()
}

extension CoordinatorProtocol {
  func start() {}
  func start(_ model: Meal, at indexPath: IndexPath, from fc: MealViewController?) {}
  func start(_ items: [Order]) {}
  func dismiss() {}
}
