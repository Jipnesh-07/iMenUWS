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
                    
//                    // Cuisines
//                    Text(restaurant.cuisines.joined(separator: ", "))
//                        .font(.subheadline)
//                        .foregroundStyle(.gray)
//                    
                    // Price per person
                    HStack(spacing: 4) {
                        Text("$\(restaurant.pricePerPerson, specifier: "%.2f")")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        
                        Text("per person")
                            .foregroundStyle(.gray)
                    }
                }
                
                Spacer()
                
                // Ratings and reviews
                VStack {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        
                        Text("\(restaurant.rating, specifier: "%.1f")")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                    }
                    
                    Text("(\(restaurant.reviewCount) reviews)")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            .font(.footnote)
        }
        .padding(.horizontal)
    }
}

#Preview {
    UserRestaurantRow(restaurant: sampleRestaurants[0])
}
