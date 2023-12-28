//
//  CapturedMealViewController.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

class CapturedMealViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  private let adapter = TableAdapter<CapturedMeal, CapturedMealTableViewCell>()
  
  internal var viewModel: CapturedMealViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupData()
  }
  
  private func setupUI() {
    tableView.register(cellType: CapturedMealTableViewCell.self)
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

extension CapturedMealViewController: Storyboarded {}
