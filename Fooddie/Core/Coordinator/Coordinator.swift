//
//  Coordinator.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation
import UIKit

protocol Coordinator {
  var navigationController: UINavigationController { get set }
  func start()
  func start(_ model: FoodItem, from fc: FoodViewController?)
}

extension Coordinator {
  func start() { }
  func start(_ model: FoodItem, from fc: FoodViewController?) { }
}
