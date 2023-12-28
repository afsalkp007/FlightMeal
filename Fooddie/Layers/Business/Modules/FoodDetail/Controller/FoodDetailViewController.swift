//
//  FoodDetailViewController.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import UIKit

protocol DismissCallBackDelegate: AnyObject {
  func getCapturedMeal(meal: CapturedMeal)
}

final class FoodDetailViewController: UIViewController {
  
  internal var viewModel: FoodDetailViewModel!
  internal var coordinator: Coordinatable!
  
  @IBOutlet private weak var foodImageView: CacheableImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var nameTextField: UITextField!
  
  weak var dismissDelegate: DismissCallBackDelegate?
  
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
    titleLabel.text = viewModel.model.name
    foodImageView.setUpLoader()
    foodImageView.downloadImageFrom(url: viewModel.url, imageMode: .scaleAspectFill)
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
    
    guard let meal = getMealOrder() else { return }
    self.coordinator?.dismiss()
    self.dismissDelegate?.getCapturedMeal(meal: meal)
  }
  
  private func getMealOrder() -> CapturedMeal? {
    nameTextField.resignFirstResponder()
    guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces) else { return nil }
    let passenger = Passenger(name: name)
    return CapturedMeal(meal: viewModel.model, passenger: passenger)
  }
}

extension FoodDetailViewController: Storyboarded {}

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
