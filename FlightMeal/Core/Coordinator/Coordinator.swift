//
//  Coordinator.swift
//  FlightMeal
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

final class Coordinator: CoordinatorProtocol {
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = MealViewController()
    vc.coordinator = self
    let mpc = MultiPeer()
    mpc.delegate = vc
    vc.viewModel = MealViewModel(multipeer: mpc)
    navigationController.pushViewController(vc, animated: false)
  }
  
  func start(_ model: Meal, at indexPath: IndexPath, from fc: MealViewController?) {
    let vc = MealDetailViewController()
    vc.coordinator = self
    vc.dismissDelegate = fc
    vc.viewModel = MealDetailViewModel(model: model, indexPath: indexPath)
    navigationController.present(vc, animated: true)
  }
  
  func start(_ items: [Order]) {
    let vc = OrderViewController()
    vc.coordinator = self
    vc.viewModel = OrderViewModel(items: items)
    navigationController.pushViewController(vc, animated: true)
  }
  
  func dismiss() {
    self.navigationController.dismiss(animated: true)
  }
}
