//
//  FoodItemRow.swift
//  iMenUWS
//
//  Created by student on 16/10/24.
//
import SwiftUI
struct FoodItemRow: View {
    var foodItem: FoodItem
    @State private var quantity: Int = 0 // Start with 0 quantity
    @State private var isAdded: Bool = false // State variable to track if the item is added
    @EnvironmentObject var orderManager: OrderManager // Access to order manager

    var body: some View {
        HStack {
            // Food Item Image
            Image(foodItem.image)
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
            
            Spacer() // Pushes the content to the left
            
            // Quantity Management
            HStack {
                if isAdded {
                    HStack {
                        Button(action: {
                            if quantity > 0 { // Prevent quantity from going below 0
                                quantity -= 1
                                if quantity == 0 {
                                    isAdded = false // Revert to "Add" button when quantity is 0
                                }
                            }
                        }) {
                            Text("-")
                                .foregroundStyle(.white)
                                .font(.body)
                                .bold()
                        }
                        
                        Text("\(quantity)") // Display current quantity
                            .foregroundStyle(.white)
                            .font(.body)
                            .bold()
                        
                        Button(action: {
                            quantity += 1 // Increase quantity
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
                        quantity = 1 // Start with a quantity of 1 when adding
                        isAdded = true // Change the state to added
                        orderManager.addFoodItem(foodItem, quantity: quantity) // Add food item to order
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
        .background(Color.white) // Background color for the row
        .cornerRadius(10) // Rounded corners for the row
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Shadow effect
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Light border
        )
        .padding(.horizontal)
    }
}
