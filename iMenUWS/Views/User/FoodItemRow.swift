//
//  FoodItemRow.swift
//  iMenUWS
//
//  Created by student on 16/10/24.
//
import SwiftUI

struct FoodItemRow: View {
    var foodItem: FoodItem
    @State private var quantity: Int = 0
    @State private var isAdded: Bool = false 
    @EnvironmentObject var orderManager: OrderManager 

    var body: some View {
        HStack {
            // Food Item Image
            Image(foodItem.image ?? "bur1")
                .resizable()
                .scaledToFit()
                .padding(4)
                .frame(width: 100, height: 100)
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                // Food Item Name
                Text(foodItem.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                // Ingredients
                Text(foodItem.ingredients)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Price
                Text("Price: $\(foodItem.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            // For Managing Quantity
            HStack {
                if isAdded {
                    HStack {
                        // Decrease Quantity
                        Button(action: {
                            if quantity > 0 {
                                quantity -= 1
                                orderManager.updateOrder(item: OrderItem(id: foodItem.id, foodItem: foodItem, quantity: quantity), quantity: quantity)
                                
                                if quantity == 0 {
                                    isAdded = false
                                    orderManager.removeItem(orderItem: OrderItem(id: foodItem.id, foodItem: foodItem, quantity: quantity))
                                }
                            }
                        }) {
                            Text("-")
                                .foregroundStyle(.white)
                                .font(.body)
                                .bold()
                        }
                        
                        Text("\(quantity)")
                            .foregroundStyle(.white)
                            .font(.body)
                            .bold()
                        
                        // Increase Quantity
                        Button(action: {
                            quantity += 1
                            orderManager.updateOrder(item: OrderItem(id: foodItem.id, foodItem: foodItem, quantity: quantity), quantity: quantity)
                        }) {
                            Text("+")
                                .foregroundStyle(.white)
                                .font(.body)
                                .bold()
                        }
                    }
                } else {
                    // Add Button
                    Button(action: {
                        quantity = 1 // Set initial quantity
                        isAdded = true // Change to quantity management
                        orderManager.addFoodItem(foodItem, quantity: quantity) // Add item to the order
                    }) {
                        Text("Add")
                            .foregroundStyle(.white)
                            .font(.body)
                            .bold()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(.pink)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal)
        .onAppear {
            // Check if this food item is already in the order and update the state
            if let existingOrderItem = orderManager.currentOrder.first(where: { $0.foodItem.id == foodItem.id }) {
                isAdded = true
                quantity = existingOrderItem.quantity
            }
        }
    }
}
