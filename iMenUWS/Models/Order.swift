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
