//
//  OrderViewController.swift
//  FlightMeal
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

class OrderViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  private let adapter = TableAdapter<Order, OrderTableViewCell>()
  internal var coordinator: CoordinatorProtocol!
  
  internal var viewModel: OrderViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.showLargeTitle(false)
    navigationController?.removeSubViews()
  }
  
  private func setupUI() {
    tableView.register(cellType: OrderTableViewCell.self)
    tableView.delegate = adapter
    tableView.dataSource = adapter
  }
  
  private func setupData() {
    adapter.height = viewModel.hegith
    adapter.items = viewModel.items
    
    adapter.configure = { model, cell in
      cell.model = model
    }
    
    tableView.reloadData()
  }
}
