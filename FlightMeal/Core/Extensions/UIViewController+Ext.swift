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

