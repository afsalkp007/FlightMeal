//
//  UIImage+Ext.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

extension UIImage {
  func resizeImage(with size: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    draw(in: CGRect(origin: .zero, size: size))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
