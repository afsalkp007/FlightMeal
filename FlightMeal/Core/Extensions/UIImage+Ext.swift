//
//  UIImage+Ext.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

extension UIImage {
  static let cartImage: UIImage? = {
    let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold, scale: .default)
    let image = UIImage(systemName: "cart", withConfiguration: config)
    return image
  }()
  
  func resizeImage(with size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    draw(in: CGRect(origin: .zero, size: size))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
