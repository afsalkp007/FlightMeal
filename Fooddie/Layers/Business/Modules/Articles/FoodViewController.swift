//
//  FoodViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

final class FoodViewController: UIViewController, Storyboarded {
  
  var coordinator: FoodDetailCoordinator?
  var viewModel: FoodViewModel?
  
  @IBOutlet weak var tableView: UITableView!
  var loaderView = UIActivityIndicatorView()
  private let adapter = Adapter<FoodCellViewModel, FoodTableViewCell>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupData()
  }

  private func setupUI() {
    setUpLoader()
    tableView.register(cellType: FoodTableViewCell.self)
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
    adapter.cellHeight = 110
    tableView.delegate = adapter
    tableView.dataSource = adapter
    tableView.layer.cornerRadius = 0
    tableView.backgroundColor = UIColor.clear
    tableView.tableFooterView = UIView()
    tableView.reloadData()
    
    adapter.configure = { item, cell in
      cell.titleLabel.text = item.name
      cell.descLabel.text = "\(item.description ?? "")"
      guard let url = item.imageUrl else { return }
      cell.foodImageView.setUpLoader()
      cell.foodImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFit)
    }
    
    adapter.select = { [weak self] viewModel in
      self?.coordinator?.start(viewModel)
    }
  }
  
  private func setUpLoader() {
    tableView.addSubview(loaderView)
    loaderView.hidesWhenStopped = true
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    loaderView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    loaderView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    loaderView.startAnimating()
  }
}
