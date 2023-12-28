//
//  FoodDetailCoordinator.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

final class FoodDetailCoordinator: Coordinator {
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start(_ model: FoodItem, from fc: FoodViewController?) {
    let vc = FoodDetailViewController.instantiate()
    vc.coordinator = self
    vc.dismissDelegate = fc
    vc.viewModel = FoodDetailViewModel(model: model)
    navigationController.present(vc, animated: true)
  }
  
  func dismiss() {
    self.navigationController.dismiss(animated: true)
  }
}
