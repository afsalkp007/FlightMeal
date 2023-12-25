//
//  FoodCollectionViewCell.swift
//  Fooddie
//
//  Created by Afsal on 25/12/2023.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var cardViewitem: UIView!

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var foodImageView: CacheableImageView!
}
