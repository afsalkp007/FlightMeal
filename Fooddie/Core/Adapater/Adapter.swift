//
//  Adapter.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

class Adapter<T, Cell: UICollectionViewCell>:
  NSObject,
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout {
  
  var items: [T] = []
  var configure: ((T, Cell) -> Void)?
  var select: ((T) -> Void)?
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return items.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell: Cell = collectionView.dequeue(indexPath)
    let item = items[indexPath.row]
    configure?(item, cell)
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let item = items[indexPath.row]
    select?(item)
  }
  
//  func collectionView(
//    _ collectionView: UICollectionView,
//    layout collectionViewLayout: UICollectionViewLayout,
//    sizeForItemAt indexPath: IndexPath
//  ) -> CGSize {
//    
//  }
}
