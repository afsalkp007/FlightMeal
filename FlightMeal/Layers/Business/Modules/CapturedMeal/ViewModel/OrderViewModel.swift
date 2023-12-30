//
//  OrderViewModel.swift
//  FlightMeal
//
//  Created by Afsal on 28/12/2023.
//

import Foundation

struct OrderViewModel {
  internal let items: [Order]
  
  var hegith: CGFloat {
    return 65.0
  }
  
  init(items: [Order]) {
    self.items = items
  }
}
