//
//  FoodItemRow.swift
//  iMenUWS
//
//  Created by student on 16/10/24.
//
import SwiftUI

struct FoodItemRow: View {
    var foodItem: FoodItem
    
    var body: some View {
        HStack {
            // Food Item Image
            Image(foodItem.image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
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
        }
        .padding()
        .background(Color.white) // Background color for the row
        .cornerRadius(10) // Rounded corners for the row
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Shadow effect
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Light border
        )
        .padding() // Vertical padding between rows
    }
}

#Preview {
    FoodItemRow(foodItem: foodList[0]) // Preview with a sample food item
}
