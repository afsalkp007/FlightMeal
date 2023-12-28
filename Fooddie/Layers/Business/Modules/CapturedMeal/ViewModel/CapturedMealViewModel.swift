//
//  CapturedMealViewModel.swift
//  Fooddie
//
//  Created by Afsal on 28/12/2023.
//

import Foundation

struct CapturedMealViewModel {
  let items: [CapturedMeal]
  
  var hegith: CGFloat {
    return 65.0
  }
  
  init(items: [CapturedMeal]) {
    self.items = items
  }
}
