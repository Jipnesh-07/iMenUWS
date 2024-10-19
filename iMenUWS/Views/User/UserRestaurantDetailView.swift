//
//  UserRestaurantDetailView.swift
//  iMenUWS
//
//  Created by student on 16/10/24.
//

import SwiftUI
import MapKit

struct RestaurantDetailsView: View {
    var restaurant: Restaurant
    @State private var region: MKCoordinateRegion

    // Initialize the view and set up the map region
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                // Restaurant Image
                if let imageName = restaurant.image {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                }
                
                // Restaurant Details
                RestaurantInfoView(restaurant: restaurant)
              
                Divider()
                
                // List of Food Items
                RestaurantFoodItemsView(restaurantId: restaurant.id)
                
                Divider()
                
                // Restaurant Location Map
                RestaurantLocationView(region: $region, locationName: restaurant.location)
            }
            .navigationTitle(restaurant.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RestaurantFoodItemsView: View {
    var restaurantId: Int
    
    var body: some View {
    
          
            ForEach(foodList.filter { $0.restaurantId == restaurantId }) { foodItem in
                FoodItemRow(foodItem: foodItem)
            }
    
    }
}

struct RestaurantInfoView: View {
    var restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Restaurant Name
            Text(restaurant.name)
                .font(.title)
                .bold()
            

            HStack {
                // Restaurant Location
                Text(restaurant.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\(restaurant.rating, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }

            // Cuisines
            Text("Cuisines: \(restaurant.cuisines.joined(separator: ", "))")
                .font(.subheadline)

            // Price per Person
            HStack {
                Text("Minimum order range:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("$\(restaurant.pricePerPerson, specifier: "%.2f")")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct RestaurantLocationView: View {
    @Binding var region: MKCoordinateRegion
    var locationName: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Where you'll find us")
                .font(.headline)
                .padding(.bottom, 8)

            Map(coordinateRegion: $region)
                .frame(height: 200)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 0.5)
                )

            Text(locationName)
                .font(.caption)
                .padding(.top, 4)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct RestaurantFeaturesView: View {
    var amenities: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Amenities")
                .font(.headline)

            ForEach(amenities, id: \.self) { amenity in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text(amenity)
                }
                .padding(.vertical, 2)
            }
        }
        .padding()
    }
}

#Preview {
    RestaurantDetailsView(restaurant: sampleRestaurants[0])
}
