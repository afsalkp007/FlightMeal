//
//  UITableView+Ext.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

extension UITableView {
  func dequeue<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
    return dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
  }
  
  func register(cellType: UITableViewCell.Type) {
    let nib = UINib(nibName: String(describing: cellType), bundle: nil)
    register(nib, forCellReuseIdentifier: String(describing: cellType))
  }
}
