//
//  FoodViewCoordinator.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = FoodViewController.instantiate()
    vc.coordinator = FoodDetailCoordinator(navigationController: navigationController)
    vc.viewModel = FoodViewModel()
    navigationController.pushViewController(vc, animated: false)
  }
}
