//
//  UIViewController+Ext.swift
//  FlightMeal
//
//  Created by Afsal on 19/12/2023.
//

import UIKit

typealias alertHandler = ((UIAlertAction) -> Void)?

extension UIViewController {
  func showAlert(title: String, message: String, buttonTitle: String, completion: alertHandler = { _ in }) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
      alertVC.addAction(alertAction)
      present(alertVC, animated: true)
  }
}

extension UINavigationController {
  func removeSubViews() {
    navigationBar.subviews.forEach {
      $0.removeFromSuperview()
    }
  }
  
  func showLargeTitle(_ show: Bool) {
    navigationBar.prefersLargeTitles = show
    navigationItem.largeTitleDisplayMode = show ? .always : .never
  }
  
  func addCartButton() {
    guard let UINavigationBarLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView") else {
      return
    }
    navigationBar.subviews.forEach { subview in
      if subview.isKind(of: UINavigationBarLargeTitleView.self) {
        subview.addSubview(UIButton.cartButton)
        
        NSLayoutConstraint.activate([
          UIButton.cartButton.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: -8),
          UIButton.cartButton.trailingAnchor.constraint(
            equalTo: subview.trailingAnchor, constant: -16
          )
        ])
      }
    }
  }
}
