//
//  RestaurantRow.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct RestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            // Restaurant Image
            if let imageName = restaurant.image {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(restaurant.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(restaurant.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Min Order: $\(restaurant.minimumOrderCharge, specifier: "%.2f")")
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

//#Preview {
//    RestaurantRow(restaurant: Restaurant(id: 1, name: "The WonderInn Riverside Retreat", cuisine: "Thai", location: "Norway", minimumOrderCharge: 50.0, image: "r1"))
//}
