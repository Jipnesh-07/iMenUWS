//
//  AdminFoodItemRow.swift
//  iMenUWS
//
//  Created by STUDENT on 20/10/24.
//
import SwiftUI

struct AdminFoodItemRow: View {
    var foodItem: FoodItem
    var onEdit: () -> Void // Closure to handle editing
    var onDelete: () -> Void // Closure to handle deletion
    
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
            
            // Action Buttons for Edit and Delete
            HStack {
                Button(action: {
                    onEdit() // Call the edit action
                }) {
                    Image(systemName: "pencil")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(width: 30, height: 30)
                }
                
                Button(action: {
                    onDelete() // Call the delete action
                }) {
                    Image(systemName: "trash")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.leading, 10)
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
