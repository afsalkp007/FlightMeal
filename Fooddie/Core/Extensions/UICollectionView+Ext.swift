//
//  UITableView+Ext.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

extension UICollectionView {
  func dequeue<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
    return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
  }
  
  func register(cellType: UICollectionViewCell.Type) {
    let nib = UINib(nibName: String(describing: cellType), bundle: nil)
    register(nib, forCellWithReuseIdentifier: String(describing: cellType))
  }
}
