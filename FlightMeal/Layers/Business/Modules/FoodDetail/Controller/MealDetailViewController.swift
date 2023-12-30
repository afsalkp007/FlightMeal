//
//  MealDetailViewController.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

protocol DismissCallBackDelegate: AnyObject {
  func getCapturedMeal(meal: Order, indexPath: IndexPath)
}

final class MealDetailViewController: UIViewController {
  
  internal var viewModel: MealDetailViewModel!
  internal var coordinator: Coordinatable!
  
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet private weak var foodImageView: CacheableImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var nameTextField: UITextField!
  
  weak var dismissDelegate: DismissCallBackDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  private func configureView() {
    guard let viewModel = viewModel else { return }
    titleLabel.text = viewModel.model.name
    foodImageView.setUpLoader()
    foodImageView.downloadImageFrom(url: viewModel.url, imageMode: .scaleAspectFill)
    createDismissKeyboardGesture()
    containerView.shadow()
    nameTextField.border()
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
    
    guard let meal = getMealOrder() else { return }
    self.coordinator?.dismiss()
    self.dismissDelegate?.getCapturedMeal(meal: meal, indexPath: viewModel.indexPath)
  }
  
  private func getMealOrder() -> Order? {
    nameTextField.resignFirstResponder()
    guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces) else { return nil }
    return Order(meal: viewModel.model, name: name)
  }
}

extension MealDetailViewController: Storyboarded {}

extension MealDetailViewController {
  func getKeyboardHeight(_ notification : Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardHeight = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    return keyboardHeight.cgRectValue.height
  }
  
  @objc func keyboardWillShow(_ notification:Notification) {
    if nameTextField.isFirstResponder && view.frame.origin.y == 0 {
      view.frame.origin.y -= 0
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

extension UITextField {
  func border() {
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = 4.0
  }
}
