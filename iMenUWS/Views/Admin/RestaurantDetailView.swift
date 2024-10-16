//
//  RestaurantDetailedView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                // Image Carousel
                TabView {
                    if let imageName = restaurant.image {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 300)
                    }
                }
                .frame(height: 300)
                .tabViewStyle(PageTabViewStyle())
                
                // Restaurant Name and Rating
                VStack(alignment: .leading, spacing: 10) {
                    Text(restaurant.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        
                        Text(restaurant.location)
                            .font(.callout)
                    }
                    
                    Divider()
                    
                    
                    // Cuisines
                    Text("Cuisines")
                        .font(.headline)
                    
                    HStack(spacing: 10) {
                        ForEach(restaurant.cuisines, id: \.self) { cuisine in
                            CuisineTagView(cuisine: cuisine)
                        }
                    }
                    
                    Divider()
                    
                    // Self-Check-in and Special Features
                    Text("Minimum Order: €\(restaurant.minimumOrderCharge, specifier: "%.2f")")
                        .font(.headline)
                    
                    Text("Check yourself in easily with the lockbox.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Check-in Experience
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                        Text("Great check-in experience")
                            .font(.subheadline)
                    }
                }
                .padding()
                
                Spacer()
                
                // Book Now Button
                HStack {
                    Text("€\(restaurant.pricePerPerson, specifier: "%.2f")")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        // Booking action
                    }) {
                        Text("Book Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationBarTitle(restaurant.name, displayMode: .inline)
        }
    }
    
    // A function to map amenity names to system icons (example)
    func amenityIcon(for amenity: String) -> String {
        switch amenity {
        case "Wi-Fi": return "wifi"
        case "Parking": return "car"
        case "Air Conditioning": return "snow"
        case "Outdoor Seating": return "leaf"
        default: return "questionmark"
        }
    }
}

#Preview {
    RestaurantDetailView(restaurant: sampleRestaurants[0])
}


// Helper Views for Amenities and Cuisines
struct AmenityIconView: View {
    var iconName: String
    var label: String
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 24))
            Text(label)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct CuisineTagView: View {
    var cuisine: String
    
    var body: some View {
        Text(cuisine)
            .font(.footnote)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
    }
}
