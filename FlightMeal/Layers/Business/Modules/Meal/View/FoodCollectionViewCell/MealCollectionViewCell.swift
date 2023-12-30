//
//  MealCollectionViewCell.swift
//  FlightMeal
//
//  Created by Afsal on 25/12/2023.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mealImageView: CacheableImageView!
  @IBOutlet var stepper: UIStepperController!
  
  internal var model: Meal? {
    didSet {
      guard let model = model else { return }
      titleLabel.text = model.name
      stepper.quantity = model.quantity
      guard let imageUrl = model.imageUrl, let url = URL(string: imageUrl) else { return }
      mealImageView.setUpLoader()
      mealImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFill)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    shadow()
  }
}
