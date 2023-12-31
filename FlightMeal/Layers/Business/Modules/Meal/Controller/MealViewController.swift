//
//  MealViewController.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class MealViewController: UIViewController {
  
  internal var coordinator: CoordinatorProtocol!
  internal var viewModel: MealViewModel!
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var loaderView = UIActivityIndicatorView()
  private let adapter = CollectionAdapter<Meal, MealCollectionViewCell>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.showLargeTitle(true)
  }
  
  @objc func orderDidTap() {
    coordinator.start(Order.items)
  }
  
  private func setupUI() {
    setUpLoader()
    collectionView.register(cellType: MealCollectionViewCell.self)
    collectionView.delegate = adapter
    collectionView.dataSource = adapter
    
    navigationController?.addCartButton()
    UIButton.cartButton.addTarget(self, action: #selector(orderDidTap), for: .touchUpInside)
    title = viewModel.title
  }
  
  private func setupData(with items: [Meal]) {
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
    loaderView.placeCenter(of: collectionView)
    loaderView.startAnimating()
  }
}

extension MealViewController: UpdateMealViewDelegate {
  func updateView(for meals: [Meal]) {
    setupData(with: meals)
  }
}

extension MealViewController: DismissCallBackDelegate {
  func getOrders(order: Order, indexPath: IndexPath) {
    Order.items.append(order)
    viewModel.send(type: .typeOrder(order))
    
    let quantity = order.meal.quantity - 1
    let stepper = Stepper(quantity: quantity, index: indexPath.item)
    viewModel.getUpdatedMeals(stepper)
    viewModel.send(type: .typeMeal(viewModel.meals))
  }
}

extension MealViewController: UIStepperControllerDelegate {
  func stepperDidAddValues(_ stepper: Stepper) {
    viewModel.getUpdatedMeals(stepper)
    viewModel.send(type: .typeMeal(viewModel.meals))
  }

  func stepperDidSubtractValues(_ stepper: Stepper) {
    viewModel.getUpdatedMeals(stepper)
    viewModel.send(type: .typeMeal(viewModel.meals))
  }
}

extension MealViewController: MultiPeerDelegate {
  func multiPeer(didReceiveData data: Data) {
    
    if let meals: [Meal] = data.toObjects(), !meals.isEmpty {
      viewModel.meals = meals
      setupData(with: meals)
    } else if let order: Order = data.toObject() {
      Order.items.append(order)
    }
  }
  
  func multiPeer(connectedDevicesChanged devices: [String]) {
    print("Connected devices changed: \(devices)")
  }
}
