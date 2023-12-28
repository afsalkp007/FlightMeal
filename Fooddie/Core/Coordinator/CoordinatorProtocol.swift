//
//  Coordinator.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
  var navigationController: UINavigationController { get set }
  func start()
  func start(_ model: FoodItem, from fc: FoodViewController?)
  func dismiss()
}

extension CoordinatorProtocol {
  func start() {}
  func start(_ model: FoodItem, from fc: FoodViewController?) {}
  func dismiss() {}
}
