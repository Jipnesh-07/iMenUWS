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
    var foodItems: [OrderItem]
    var totalPrice: Double
    var address: String
}

struct OrderItem: Identifiable {
    var id: Int // Assuming each food item has a unique id
    var foodItem: FoodItem
    var quantity: Int
}



// Sample orders using the new Order and OrderItem models
let sampleOrders: [Order] = [
    Order(
        id: 1,
        restaurantId: 1,
        foodItems: [
            OrderItem(id: 1, foodItem: FoodItem(id: 1, name: "Burger", restaurantId: 1, ingredients: "Beef, Lettuce", price: 60.0, image: "r2"), quantity: 1),
            OrderItem(id: 2, foodItem: FoodItem(id: 2, name: "Pizza", restaurantId: 1, ingredients: "Cheese, Tomato", price: 80.0, image: "r4"), quantity: 2)
        ],
        totalPrice: 220.0, // Update totalPrice to reflect the quantities
        address: "123 Street, City"
    )
]


//class OrderManager: ObservableObject {
//    @Published var currentOrder: [OrderItem] = []
//
//    func addFoodItem(_ foodItem: FoodItem, quantity: Int) {
//        if let index = currentOrder.firstIndex(where: { $0.foodItem.id == foodItem.id }) {
//            currentOrder[index].quantity += quantity
//        } else {
//            currentOrder.append(OrderItem(id: foodItem.id, foodItem: foodItem, quantity: quantity))
//        }
//    }
//}


class OrderManager: ObservableObject {
    @Published var currentOrder: [OrderItem] = [] // Current items in the order
    var deliveryAddress: String = "123 Example St." // Example address

    func addFoodItem(_ foodItem: FoodItem, quantity: Int) {
        // Check if the food item already exists in the current order
        if let index = currentOrder.firstIndex(where: { $0.foodItem.id == foodItem.id }) {
            // If it does, just update the quantity
            currentOrder[index].quantity += quantity
        } else {
            // If not, append it to the order
            currentOrder.append(OrderItem(id: foodItem.id, foodItem: foodItem, quantity: quantity))
        }
    }

    
    func updateOrder(item: OrderItem, quantity: Int) {
            if let index = currentOrder.firstIndex(where: { $0.id == item.id }) {
                currentOrder[index].quantity = quantity
            }
            objectWillChange.send() // Trigger a UI update
        }

        // Remove an order item
        func removeItem(orderItem: OrderItem) {
            currentOrder.removeAll { $0.id == orderItem.id }
            objectWillChange.send() // Trigger a UI update
        }
    
    // Calculate total price of the current order
    var totalPrice: Double {
        currentOrder.reduce(0) { $0 + ($1.foodItem.price * Double($1.quantity)) }
    }
}

