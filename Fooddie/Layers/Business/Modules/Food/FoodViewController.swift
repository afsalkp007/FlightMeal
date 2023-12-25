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
  private let serviceType = "fooddie-mpc"
  
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
    MultiPeer.instance.initialize(serviceType: serviceType)
    MultiPeer.instance.autoConnect()
  }

  private func setupData() {
    viewModel?.updateUI = { [weak self] in
      guard let self = self, let viewModel = self.viewModel else { return }
      self.title = viewModel.title
      self.adapter.items = viewModel.viewModels
      self.configureTableView()
      self.loaderView.stopAnimating()
    }
  }
  
  private func configureTableView() {
    collectionView.delegate = adapter
    collectionView.dataSource = adapter
    collectionView.layer.cornerRadius = 0
    collectionView.backgroundColor = UIColor.clear
    collectionView.reloadData()
    
    adapter.configure = { [weak self] item, cell in
      self?.configure(cell, for: item)
    }
    
    adapter.select = { [weak self] viewModel in
      self?.coordinator?.start(viewModel)
    }
  }
  
  private func configure(_ cell: FoodCollectionViewCell, for item: FoodCellViewModel) {
    cell.titleLabel.text = item.name
    cell.descLabel.text = item.quantity
    guard let url = item.imageUrl else { return }
    cell.foodImageView.setUpLoader()
    cell.foodImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFit)
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

extension FoodViewController: MultiPeerDelegate {

    func multiPeer(didReceiveData data: Data, ofType type: UInt32) {
        
    }

    func multiPeer(connectedDevicesChanged devices: [String]) {
        print("Connected devices changed: \(devices)")
    }
}
