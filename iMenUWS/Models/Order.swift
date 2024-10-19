//
//  Order.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import Foundation

struct Order: Identifiable {
    var id: Int
    var restaurantId: Int
    var foodItems: [FoodItem]
    var totalPrice: Double
    var address: String
}


// Sample orders using the FoodItem model
let sampleOrders: [Order] = [
    Order(id: 1, restaurantId: 101, foodItems: [
        FoodItem(id: 1, name: "Burger", restaurantId: 101, ingredients: "Beef, Lettuce", price: 60.0, image: "r2", description: "Our juicy burger with lettuce."),
        FoodItem(id: 2, name: "Pizza", restaurantId: 101, ingredients: "Cheese, Tomato", price: 80.0, image: "r4", description: "A cheesy pizza topped with fresh tomatoes.")
    ], totalPrice: 140.0, address: "123 Street, City")
]
