//
//  UIView+Ext.swift
//  Fooddie
//
//  Created by Afsal on 30/12/2023.
//

import UIKit

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
