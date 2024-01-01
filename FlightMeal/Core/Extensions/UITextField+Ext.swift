//
//  UITextField+Ext.swift
//  FlightMeal
//
//  Created by Afsal on 01/01/2024.
//

import UIKit

extension UITextField {
  func border() {
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = 4.0
  }
}
