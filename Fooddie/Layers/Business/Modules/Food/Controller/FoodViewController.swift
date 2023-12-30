//
//  FoodViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewController: UIViewController {
  
  internal var coordinator: Coordinatable!
  internal var viewModel: FoodViewModel!
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var loaderView = UIActivityIndicatorView()
  private let adapter = CollectionAdapter<FoodItem, FoodCollectionViewCell>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    viewModel.updateUI = { [weak self] models in
      self?.setupData(with: models)
    }
  }
  
  @IBAction func showCapturedMeals(_ sender: UIButton) {
    coordinator.start(CapturedMeal.items)
  }
  
  private func setupUI() {
    setUpLoader()
    collectionView.register(cellType: FoodCollectionViewCell.self)
    collectionView.delegate = adapter
    collectionView.dataSource = adapter
  }

  private func setupData(with items: [FoodItem]) {
    adapter.size = viewModel.cellSize
    adapter.items = items
    configureCollectionView()
    loaderView.stopAnimating()
  }
  
  private func configureCollectionView() {
    adapter.configure = { model, cell, indexPath in
      cell.model = model
      cell.stepper.subtractionButton.tag = indexPath.item
      cell.stepper.additionButton.tag = indexPath.item
      cell.stepper.delegate = self
    }
    
    adapter.select = { [weak self] item, indexPath in
      self?.coordinator.start(item, at: indexPath, from: self)
    }
    
    collectionView.reloadData()
  }
  
  private func setUpLoader() {
    collectionView.addSubview(loaderView)
    loaderView.hidesWhenStopped = true
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    loaderView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
    loaderView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    loaderView.startAnimating()
  }
}

extension FoodViewController: Storyboarded {}

extension FoodViewController: DismissCallBackDelegate {
  func getCapturedMeal(meal: CapturedMeal, indexPath: IndexPath) {
    CapturedMeal.items.append(meal)
    viewModel.send(type: .mealCaptured(meal))
    
    let quantity = meal.meal.quantity - 1
    let stepper = Stepper(quantity: quantity, index: indexPath.item)
    viewModel.getUpdatedFoodItems(stepper)
    viewModel.send(type: .rawFood(viewModel.foodItems))
  }
}

extension FoodViewController: UIStepperControllerDelegate {
  func stepperDidAddValues(_ stepper: Stepper) {
    viewModel.getUpdatedFoodItems(stepper)
    viewModel.send(type: .rawFood(viewModel.foodItems))
  }

  func stepperDidSubtractValues(_ stepper: Stepper) {
    viewModel.getUpdatedFoodItems(stepper)
    viewModel.send(type: .rawFood(viewModel.foodItems))
  }
}

extension FoodViewController: MultiPeerDelegate {
  func multiPeer(didReceiveData data: Data) {
    
    if let foodItems: [FoodItem] = data.toObjects(), !foodItems.isEmpty {
      viewModel.foodItems = foodItems
      setupData(with: foodItems)
    } else if let capturedItem: CapturedMeal = data.toObject() {
      CapturedMeal.items.append(capturedItem)
    }
  }
  
  func multiPeer(connectedDevicesChanged devices: [String]) {
    print("Connected devices changed: \(devices)")
  }
}
