//
//  FoodDetailViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

struct FoodDetailViewModel {
  
  let cellViewModel: FoodCellViewModel
  
  var id: String
  var name: String
  var description: String
  var imageUrl: URL?
  
  init(cellViewModel: FoodCellViewModel) {
    self.cellViewModel = cellViewModel
    self.id = cellViewModel.id
    self.name = cellViewModel.name ?? ""
    self.description = cellViewModel.description ?? ""
    self.imageUrl = cellViewModel.imageUrl
  }
}
