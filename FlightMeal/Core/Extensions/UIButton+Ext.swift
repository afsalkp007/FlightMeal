//
//  UIButton+Ext.swift
//  FlightMeal
//
//  Created by Afsal on 31/12/2023.
//

import UIKit

extension UIButton {
  static let cartButton: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.imageView?.tintColor = UIColor.rgb(red: 25, green: 138, blue: 214)
    button.setImage(UIImage.cartImage, for: .normal)
    return button
  }()
}
