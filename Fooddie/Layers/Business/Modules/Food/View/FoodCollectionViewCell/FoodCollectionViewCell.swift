//
//  FoodCollectionViewCell.swift
//  Fooddie
//
//  Created by Afsal on 25/12/2023.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var foodImageView: CacheableImageView!
  @IBOutlet var stepper: UIStepperController!
  
  internal var model: FoodItem? {
    didSet {
      guard let model = model else { return }
      titleLabel.text = model.name
      stepper.quantity = model.quantity
      guard let imageUrl = model.imageUrl, let url = URL(string: imageUrl) else { return }
      foodImageView.setUpLoader()
      foodImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFill)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    shadow()
  }
}

extension UIView {
  func shadow() {
    layer.cornerRadius = 0
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 3, height: 3)
    layer.shadowOpacity = 0.7
    layer.shadowRadius = 4.0
    clipsToBounds = false
  }
}
