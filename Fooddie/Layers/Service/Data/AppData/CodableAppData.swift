//
//  JSONAppData.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

@propertyWrapper
final class CodableAppData<Value: Codable>: BaseAppData<Value> {

  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()

  override var wrappedValue: Value {
    get { super.wrappedValue }
    set { super.wrappedValue = newValue }
  }

  override func decodeValue() -> Value? {
    guard let data: Data = settings.value(forKey: type.rawValue) else {
      return nil
    }
    do {
      return try decoder.decode(Value.self, from: data)
    } catch {
      return nil
    }
  }

  override func encodeValue(_ value: Value?) {
    guard let value = value else {
      settings.remove(type)
      return
    }
    do {
      let data = try encoder.encode(value)
      settings.set(data, forKey: type.rawValue)
    } catch {
    }
  }
}

// MARK: - Array
extension CodableAppData {

  convenience init<T: Codable>(
    _ type: DataServiceType,
    settings: DataService = .default
  ) where Value == [T] {
    self.init(type, settings: settings, defaultValue: [])
  }
}
