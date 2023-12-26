//
//  FoodViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

final class FoodViewModel {
  
  var title = "Menu"
  
  var viewModels = [
    FoodCellViewModel(item: FoodItem(name: "Pommes frites", quantity: 3, imageUrl: "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&;amp;;amp;;amp;height=420")),
    FoodCellViewModel(item: FoodItem(name: "Gyoza", quantity: 3, imageUrl: "https://cdn.tasteatlas.com//Images/Dishes/3c16ad904018488f8c363413d356cacc.jpg?width=660&;amp;;amp;;amp;height=420")),
    FoodCellViewModel(item: FoodItem(name: "Nachos", quantity: 3, imageUrl: "https://cdn.tasteatlas.com//images/dishes/a29fe2d3d9c54547a9e49c49f5cf22cd.jpg?width=660&;amp;;amp;;amp;height=420"))
  ]
}
