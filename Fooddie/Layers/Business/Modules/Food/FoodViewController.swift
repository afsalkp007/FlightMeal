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
    
    adapter.configure = { [weak self] item, cell, index in
      self?.configure(cell, for: item, at: index)
    }
    
    adapter.select = { [weak self] viewModel in
      self?.coordinator?.start(viewModel)
    }
  }
  
  private func configure(_ cell: FoodCollectionViewCell, for item: FoodCellViewModel, at index: Int) {
    cell.titleLabel.text = item.name
    cell.stepper.count = item.quantity
    guard let url = item.imageUrl else { return }
    cell.foodImageView.setUpLoader()
    cell.foodImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFill)
    cell.stepper.subtractionButton.tag = index
    cell.stepper.additionButton.tag = index
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
  func stepperDidAddValues(_ stepper: Stepper) {
    MultiPeer.instance.stopSearching()
    
    defer {
        MultiPeer.instance.autoConnect()
    }
    
    MultiPeer.instance.send(stepper: stepper)
  }

  func stepperDidSubtractValues(_ stepper: Stepper) {
    print("Count: \(stepper.count) at index: \(stepper.index)")
  }
}

extension FoodViewController: MultiPeerDelegate {
  func multiPeer(didReceiveData stepper: Stepper) {
    print("Received count: \(stepper.count), at: \(stepper.index)")
  }
  
  func multiPeer(connectedDevicesChanged devices: [String]) {
    print("Connected devices changed: \(devices)")
  }
}
