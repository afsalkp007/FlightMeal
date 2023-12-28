//
//  FoodViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewController: UIViewController, Storyboarded {
  
  internal var coordinator: CoordinatorProtocol!
  internal var viewModel: FoodViewModel!
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var loaderView = UIActivityIndicatorView()
  private let adapter = Adapter<FoodItem, FoodCollectionViewCell>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    
    viewModel.updateUI = { [weak self] models in
      self?.setupData(with: models)
    }
    
    viewModel?.setupConnectivity()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    viewModel?.viewWillDisappear()
    super.viewWillDisappear(animated)
  }
  
  @IBAction func showCapturedMeals(_ sender: UIButton) {
    
  }
  
  private func setupCollectionView() {
    setUpLoader()
    collectionView.register(cellType: FoodCollectionViewCell.self)
    collectionView.delegate = adapter
    collectionView.dataSource = adapter
    collectionView.layer.cornerRadius = 0
    collectionView.backgroundColor = UIColor.clear
  }

  private func setupData(with items: [FoodItem]) {
    adapter.items = items
    configureCollectionView()
    loaderView.stopAnimating()
  }
  
  private func configureCollectionView() {
    collectionView.reloadData()
    
    adapter.configure = { [weak self] cellVM, cell, indexPath in
      self?.configure(cell, for: cellVM, at: indexPath)
    }
    
    adapter.select = { [weak self] viewModel in
      self?.coordinator.start(viewModel, from: self)
    }
  }
  
  private func configure(_ cell: FoodCollectionViewCell, for model: FoodItem, at indexPath: IndexPath) {
    cell.model = model
    cell.stepper.subtractionButton.tag = indexPath.item
    cell.stepper.additionButton.tag = indexPath.item
    cell.stepper.delegate = self
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

extension FoodViewController: DismissCallBackDelegate {
  func getCapturedMeal(meal: CapturedMeal) {
    viewModel.capturedItems.append(meal)
  }
}

extension FoodViewController: UIStepperControllerDelegate {
  func stepperDidAddValues(_ value: CGFloat, at index: Int) {
    viewModel.send(value, at: index)
  }

  func stepperDidSubtractValues(_ value: CGFloat, at index: Int) {
    viewModel.send(value, at: index)
  }
}

extension FoodViewController: MultiPeerDelegate {
  func multiPeer(didReceiveData items: [FoodItem]) {
    viewModel.foodItems = items
    setupData(with: items)
  }
  
  func multiPeer(connectedDevicesChanged devices: [String]) {
    print("Connected devices changed: \(devices)")
  }
}
