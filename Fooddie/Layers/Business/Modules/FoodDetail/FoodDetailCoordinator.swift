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
  
  func start(_ model: FoodCellViewModel) {
    let vc = FoodDetailViewController.instantiate()
    vc.coordinator = self
    vc.viewModel = FoodDetailViewModel(cellViewModel: model)
    navigationController.present(vc, animated: true)
  }
  
  func dismiss() {
    self.navigationController.dismiss(animated: true)
  }
}
