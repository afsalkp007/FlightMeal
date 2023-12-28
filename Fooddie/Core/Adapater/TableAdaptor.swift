//
//  TableAdaptor.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

class TableAdapter<T, Cell: UITableViewCell>:
  NSObject,
  UITableViewDelegate,
  UITableViewDataSource {
  
  var items: [T] = []
  var configure: ((T, Cell) -> Void)?
  var select: ((T) -> Void)?
  var height: CGFloat!
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: Cell = tableView.dequeue(indexPath)
    let item = items[indexPath.row]
    configure?(item, cell)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    select?(item)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return height
  }
}
