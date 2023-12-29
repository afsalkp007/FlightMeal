//
//  Coordinator.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

final class Coordinator: Coordinatable {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = FoodViewController.instantiate()
    vc.coordinator = self
    let mpc = MultiPeer()
    mpc.delegate = vc
    vc.viewModel = FoodViewModel(multipeer: mpc)
    navigationController.pushViewController(vc, animated: false)
  }
  
  func start(_ model: FoodItem, at indexPath: IndexPath, from fc: FoodViewController?) {
    let vc = FoodDetailViewController.instantiate()
    vc.coordinator = self
    vc.dismissDelegate = fc
    vc.viewModel = FoodDetailViewModel(model: model, indexPath: indexPath)
    navigationController.present(vc, animated: true)
  }
  
  func start(_ items: [CapturedMeal]) {
    let vc = CapturedMealViewController.instantiate()
    vc.viewModel = CapturedMealViewModel(items: items)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func dismiss() {
    self.navigationController.dismiss(animated: true)
  }
}
