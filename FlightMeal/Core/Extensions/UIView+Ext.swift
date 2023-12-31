//
//  UIView+Ext.swift
//  FlightMeal
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
  
  func placeCenter(of view:UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
