//
//  RestaurantDetailedView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct RestaurantDetailView: View {
    @State private var isEditing = false
    @State var restaurant: Restaurant
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var locationManager = LocationManager() // Geocoding helper
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                // Restaurant Image
                if let imageName = restaurant.image {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 250)
                }
                
                // Restaurant Details
                AdminRestaurantInfoView(restaurant: restaurant)
                
                Divider()
                
                // Restaurant Location Map
                if let coordinates = locationManager.locationCoordinates {
                    RestaurantLocationView(region: $region, locationName: restaurant.location)
                        .onAppear {
                            updateMapRegion(coordinates: coordinates)
                        }
                } else if let errorMessage = locationManager.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                } else {
                    Text("Fetching location for \(restaurant.location)...")
                }
                
                
                
                
            }
            .navigationBarTitle(restaurant.name, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isEditing = true // Present the edit modal
            }) {
                Text("Edit")
            })
            .sheet(isPresented: $isEditing) {
                EditRestaurantView(restaurant: $restaurant) // Bind the restaurant to edit
            }
            .onAppear {
                locationManager.fetchCoordinates(for: restaurant.location)
            }
        }
    }
    
    private func updateMapRegion(coordinates: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}

// User Restaurant Info View remains the same
struct AdminRestaurantInfoView: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text(restaurant.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\(restaurant.rating, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            
            Text("Cuisines: \(restaurant.cuisine.joined(separator: ", "))")
                .font(.subheadline)
            
            HStack {
                Text("Minimum order range:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("$\(restaurant.minimumOrderCharge, specifier: "%.2f")")
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

// Preview
#Preview {
    RestaurantDetailView(restaurant: sampleRestaurants[0])
}




