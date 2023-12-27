//
//  FoodViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewController: UIViewController, Storyboarded {
  
  internal var coordinator: FoodDetailCoordinator?
  internal var viewModel: FoodViewModel?
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var loaderView = UIActivityIndicatorView()
  private let adapter = Adapter<FoodCellViewModel, FoodCollectionViewCell>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupData()
    setupConnectivity()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    MultiPeer.instance.disconnect()
    super.viewWillDisappear(animated)
  }

  private func setupUI() {
    setUpLoader()
    collectionView.register(cellType: FoodCollectionViewCell.self)
  }
  
  private func setupConnectivity() {
    MultiPeer.instance.delegate = self

    MultiPeer.instance.initialize(serviceType: "fooddie-mpc")
    MultiPeer.instance.autoConnect()
  }

  private func setupData() {
    guard let viewModel = self.viewModel else { return }
    self.title = viewModel.title
    self.adapter.items = viewModel.viewModels
    self.configureCollectionView()
    self.loaderView.stopAnimating()
  }
  
  private func configureCollectionView() {
    collectionView.delegate = adapter
    collectionView.dataSource = adapter
    collectionView.layer.cornerRadius = 0
    collectionView.backgroundColor = UIColor.clear
    collectionView.reloadData()
    
    adapter.configure = { [weak self] cellVM, cell, indexPath in
      self?.configure(cell, for: cellVM, at: indexPath)
    }
    
    adapter.select = { [weak self] viewModel in
      self?.coordinator?.start(viewModel)
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
  func stepperDidAddValues(_ items: [FoodItem]) {
    MultiPeer.instance.stopSearching()

    defer {
        MultiPeer.instance.autoConnect()
    }
    
    MultiPeer.instance.send(items)
  }

  func stepperDidSubtractValues(_ items: [FoodItem]) {
    MultiPeer.instance.stopSearching()

    defer {
        MultiPeer.instance.autoConnect()
    }
    
    MultiPeer.instance.send(items)
  }
}

extension FoodViewController: MultiPeerDelegate {
  func multiPeer(didReceiveData items: [FoodItem]) {
    adapter.items = items.map(FoodCellViewModel.init)
    collectionView.reloadData()
  }
  
  func multiPeer(connectedDevicesChanged devices: [String]) {
    print("Connected devices changed: \(devices)")
  }
}
