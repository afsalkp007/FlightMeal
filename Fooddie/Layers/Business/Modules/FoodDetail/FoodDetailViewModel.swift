//
//  FoodDetailViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodDetailViewModel {
  
  let cellViewModel: FoodCellViewModel
  
  let id: String
  let name: String
  let description: String
  let imageUrl: URL?
  
  init(cellViewModel: FoodCellViewModel) {
    self.cellViewModel = cellViewModel
    self.id = cellViewModel.id
    self.name = cellViewModel.name ?? ""
    self.description = cellViewModel.description ?? ""
    self.imageUrl = cellViewModel.imageUrl
  }
}
