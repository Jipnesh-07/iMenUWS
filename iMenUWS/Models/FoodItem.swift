//
//  FoodItem.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import Foundation

struct FoodItem: Identifiable {
    var id: Int // Change from UUID to Int
    var name: String
    var restaurantId: Int
    var ingredients: String
    var price: Double
    var image: String?
}


let foodList: [FoodItem] = [
    FoodItem(id: 1, name: "Burger", restaurantId: 1, ingredients: "Bread and cheese", price: 60, image: "bur1"),
    FoodItem(id: 2, name: "Pizza", restaurantId: 1, ingredients: "Bread and cheese", price: 180, image: "pizza1"),
    FoodItem(id: 3, name: "Pizza", restaurantId: 1, ingredients: "Bread and cheese", price: 180, image: "pizza1"),
    FoodItem(id: 4, name: "Pizza", restaurantId: 2, ingredients: "Bread and cheese", price: 180, image: "pizza1")
]
