//
//  AppDelegate.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

  internal var window: UIWindow?
  private var coordinator: CoordinatorProtocol?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    setupRootView()
    return true
  }
  
  private func setupRootView() {
    let navController = UINavigationController()
    navController.showLargeTitle(true)
    coordinator = Coordinator(navigationController: navController)
    coordinator?.start()
    setupWindow(for: navController)
  }
  
  private func setupWindow(for navController: UINavigationController) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
  }
}

