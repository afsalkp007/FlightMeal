//
//  AppData.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct AppData {

  private let defaults: UserDefaults

  func value<T>(forKey key: String) -> T? {
    defaults.value(forKey: key) as? T
  }

  func set<T>(_ value: T?, forKey key: String) {
    defaults.set(value, forKey: key)
  }

  func remove(_ settings: AppDataType...) {
    settings.forEach {
      defaults.removeObject(forKey: $0.rawValue)
    }
  }

  func removeAll() {
    AppDataType.allCases.forEach {
      defaults.removeObject(forKey: $0.rawValue)
    }
  }
}

extension AppData {

  static let `default` = AppData(defaults: .standard)

}
