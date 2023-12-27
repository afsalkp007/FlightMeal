//
//  FoodViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewController: UIViewController, Storyboarded {
  
  internal var coordinator: FoodDetailCoordinator!
  internal var viewModel: FoodViewModel!
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var loaderView = UIActivityIndicatorView()
  private let adapter = Adapter<FoodCellViewModel, FoodCollectionViewCell>()
  
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

  private func setupCollectionView() {
    setUpLoader()
    collectionView.register(cellType: FoodCollectionViewCell.self)
    collectionView.delegate = adapter
    collectionView.dataSource = adapter
    collectionView.layer.cornerRadius = 0
    collectionView.backgroundColor = UIColor.clear
  }

  private func setupData(with items: [FoodCellViewModel]) {
    title = "Menu"
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
      self?.coordinator.start(viewModel)
    }
  }
  
  private func configure(_ cell: FoodCollectionViewCell, for cellVM: FoodCellViewModel, at indexPath: IndexPath) {
    cell.viewModel = cellVM
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
    setupData(with: items.models)
  }
  
  func multiPeer(connectedDevicesChanged devices: [String]) {
    print("Connected devices changed: \(devices)")
  }
}
