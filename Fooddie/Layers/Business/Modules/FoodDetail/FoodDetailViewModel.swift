//
//  FoodDetailViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodDetailViewModel {
  
  let cellViewModel: FoodCellViewModel
  
  let name: String
  let quantity: Int
  let imageUrl: URL?
  
  init(cellViewModel: FoodCellViewModel) {
    self.cellViewModel = cellViewModel
    self.name = cellViewModel.name ?? ""
    self.quantity = cellViewModel.quantity ?? 0
    self.imageUrl = cellViewModel.imageUrl
  }
}
