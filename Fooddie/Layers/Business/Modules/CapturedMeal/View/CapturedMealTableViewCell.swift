//
//  CapturedMealTableViewCell.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

class CapturedMealTableViewCell: UITableViewCell {
    
  var model: CapturedMeal! {
    didSet {
      nameLabel.text = model.name
      mealLabel.text = model.meal.name
    }
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var mealLabel: UILabel!
}
