//
//  OrderTableViewCell.swift
//  FlightMeal
//
//  Created by Afsal on 28/12/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
  var model: Order! {
    didSet {
      nameLabel.text = model.name
      mealLabel.text = model.meal.name
    }
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var mealLabel: UILabel!
}
