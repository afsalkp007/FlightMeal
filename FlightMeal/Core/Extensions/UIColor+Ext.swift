//
//  UIColor+Ext.swift
//  FlightMeal
//
//  Created by Afsal on 31/12/2023.
//

import UIKit

extension UIColor {
  static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/256, green: green/256, blue: blue/256, alpha: 1.0)
  }
}
