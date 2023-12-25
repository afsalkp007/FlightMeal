//
//  FoodDetailViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

final class FoodDetailViewController: UIViewController, Storyboarded {
  
  var viewModel: FoodDetailViewModel?
  
  @IBOutlet private weak var foodImageView: CacheableImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var nameTextField: UITextField!
  @IBOutlet private weak var descLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  private func configureView() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.name
    descLabel.text = "\(viewModel.quantity)"
    guard let url = viewModel.imageUrl else { return }
    foodImageView.setUpLoader()
    foodImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFill)
    createDismissKeyboardGesture()
  }
  
  private func createDismissKeyboardGesture(){
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tap)
  }
  
  @IBAction func placeOrder(_ sender: UIButton) {
    let isNameEntered = !nameTextField.text!.isEmpty
    guard isNameEntered else {
        showAlert(title: "Oops, No name!", message: "Please Enter your name", buttonTitle: "OK")
        return
    }
    guard let _ = nameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
    nameTextField.resignFirstResponder()
    showAlert(title: "Success", message: "Your order has been received 😋😋😋", buttonTitle: "OK")
  }
}

extension FoodDetailViewController {
  func getKeyboardHeight(_ notification : Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardHeight = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    return keyboardHeight.cgRectValue.height
  }
  
  @objc func keyboardWillShow(_ notification:Notification) {
    if nameTextField.isFirstResponder && view.frame.origin.y == 0 {
      view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillHide(_ notification: Notification){
    if view.frame.origin.y != 0{
      view.frame.origin.y = 0
    }
  }
}
