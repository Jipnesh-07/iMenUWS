//
//  FoodItem.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import Foundation

struct FoodItem: Identifiable {
    var id: Int
    var name: String
    var restaurantId: Int
    var ingredients: String
    var price: Double
    var image: String? // Optional image URL or name
}
