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
    var image: String // Optional image URL or name
    var description: String
    
}

let foodList: [FoodItem] = [
    FoodItem(id: 1, name: "Burger", restaurantId: 1, ingredients: "Bread and cheese", price: 60, image: "bur1", description: "Our juicy burger is made with a succulent, hand-formed patty that is grilled to perfection. It is served on a toasty bun with a crisp lettuce leaf, ripe tomato slices, and a heaping helping of creamy, melted cheese. To finish it off, we add a generous dollop of zesty sauce that perfectly complements the flavors of the patty and vegetables."),
    
    FoodItem(id: 2, name: "Pizza", restaurantId: 1, ingredients: "Bread and cheese", price: 180, image: "pizza1", description: "Our juicy burger is made with a succulent, hand-formed patty that is grilled to perfection. It is served on a toasty bun with a crisp lettuce leaf, ripe tomato slices, and a heaping helping of creamy, melted cheese. To finish it off, we add a generous dollop of zesty sauce that perfectly complements the flavors of the patty and vegetables."),
    
    
    FoodItem(id: 3, name: "Pizza", restaurantId: 1, ingredients: "Bread and cheese", price: 180, image: "pizza1", description: "Our juicy burger is made with a succulent, hand-formed patty that is grilled to perfection. It is served on a toasty bun with a crisp lettuce leaf, ripe tomato slices, and a heaping helping of creamy, melted cheese. To finish it off, we add a generous dollop of zesty sauce that perfectly complements the flavors of the patty and vegetables."),
    
    FoodItem(id: 4, name: "Pizza", restaurantId: 2, ingredients: "Bread and cheese", price: 180, image: "pizza1", description: "Our juicy burger is made with a succulent, hand-formed patty that is grilled to perfection. It is served on a toasty bun with a crisp lettuce leaf, ripe tomato slices, and a heaping helping of creamy, melted cheese. To finish it off, we add a generous dollop of zesty sauce that perfectly complements the flavors of the patty and vegetables.")
    
]
