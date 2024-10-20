//
//  UserRestaurantRow.swift
//  iMenUWS
//
//  Created by student on 16/10/24.
//

import SwiftUI

struct UserRestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack(spacing: 8) {
            // Restaurant image
            if let imageName = restaurant.image {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
            }
            
            // Restaurant info
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    // Restaurant name and location
                    Text(restaurant.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text(restaurant.location)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    // Minimum Order Charge
                    HStack(spacing: 4) {
                        Text("$\(restaurant.minimumOrderCharge, specifier: "%.2f")")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("per person")
                            .foregroundStyle(.gray)
                    }
                }
                
                Spacer()
                
                // Ratings
                VStack {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        
                        Text("\(restaurant.rating, specifier: "%.1f")")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
            }
            .font(.footnote)
        }
        .padding()
        .background(Color.white) // White background
        .cornerRadius(10) // Rounded corners
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2) // Minimal shadow
        .overlay(
            RoundedRectangle(cornerRadius: 10) // Border with same corner radius
                .stroke(Color.gray.opacity(0.2), lineWidth: 1) // Light gray border
        )
//        .padding(.horizontal) 
    }
}

#Preview {
    UserRestaurantRow(restaurant: sampleRestaurants[0])
}
