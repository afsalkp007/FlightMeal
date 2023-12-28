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
    navigationController.navigationBar.prefersLargeTitles = true
    vc.coordinator = FoodDetailCoordinator(navigationController: navigationController)
    let mpc = MultiPeer()
    mpc.delegate = vc
    vc.viewModel = FoodViewModel(multipeer: mpc)
    navigationController.pushViewController(vc, animated: false)
  }
}
