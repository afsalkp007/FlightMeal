//
//  KeyedDecodingContainer+Convenience.swift
//  FlightMeal
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

extension KeyedDecodingContainer {
  func decodeValue<T: Decodable>(forKey key: Key) throws -> T {
    try decode(T.self, forKey: key)
  }

  func decodeValueIfPresent<T: Decodable>(forKey key: Key) throws -> T? {
    try decodeIfPresent(T.self, forKey: key)
  }
}
