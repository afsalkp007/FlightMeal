//
//  Data+Ext.swift
//  FlightMeal
//
//  Created by Afsal on 30/12/2023.
//

import Foundation

// MARK: - Data extension for conversion
extension Data {
  internal func toObjects<T: Decodable>() -> [T]? {
    return try? JSONDecoder().decode([T].self, from: self)
  }
  
  internal func toObject<T: Decodable>() -> T? {
    return try? JSONDecoder().decode(T.self, from: self)
  }
}
