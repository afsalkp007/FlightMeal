//
//  UIViewController+Ext.swift
//  Fooddie
//
//  Created by Afsal on 19/12/2023.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String, buttonTitle: String){
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let alertAction = UIAlertAction(title: buttonTitle, style: .default)
      alertVC.addAction(alertAction)
      present(alertVC, animated: true)
  }
}

