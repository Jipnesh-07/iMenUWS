//
//  RestaurantDetailedView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//


import SwiftUI
import MapKit
import CoreLocation

struct AdminRestaurantDetailView: View {
    @Binding var restaurant: Restaurant // Keep this as Binding
        @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        @State private var locationManager = LocationManager() // Geocoding helper
        @State private var isAddingFoodItem = false // State to control showing AddFoodItemView

        var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    // Restaurant Image
                    if let imageName = restaurant.image, !imageName.isEmpty {
                        if imageExistsInDocumentsDirectory(imageName) {
                            if let imagePath = getImagePath(from: imageName) {
                                Image(uiImage: UIImage(contentsOfFile: imagePath) ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 250)
                                    .clipped()
                            }
                        } else {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipped()
                        }
                    } else {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 250)
                    }
                    
                    // Restaurant Details
                    AdminRestaurantInfoView(restaurant: restaurant)
                    
                    Divider()
                    
                    HStack {
                        Text("Top Food Items:")
                            .font(.headline)
                            .padding([.horizontal, .bottom], 10)
                        
                        Spacer()
                        
                        Button(action: {
                            isAddingFoodItem = true // Show the AddFoodItemView
                        }) {
                            Text("Add more")
                                .font(.headline)
                                .padding([.horizontal, .bottom], 10)
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $isAddingFoodItem) {
                            AdminAddFoodItemView() // Present the add food item view
                        }
                    }
                    .padding()
                    
                    AdminRestaurantFoodItemsView(restaurantId: restaurant.id) // Pass restaurant ID
                    
                    Divider()
                    
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
                .onAppear {
                    locationManager.fetchCoordinates(for: restaurant.location)
                }
            }
        }
    
    private func updateMapRegion(coordinates: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    // Helper function to check if the image exists in the documents directory
    func imageExistsInDocumentsDirectory(_ imageName: String) -> Bool {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imagePath = directory.appendingPathComponent(imageName)
            return fileManager.fileExists(atPath: imagePath.path)
        }
        return false
    }
    
    // Helper function to get the full path of the image in the documents directory
    func getImagePath(from imageName: String) -> String? {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return directory.appendingPathComponent(imageName).path
        }
        return nil
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


struct AdminRestaurantFoodItemsView: View {
    @EnvironmentObject var orderManager: OrderManager // Access to order manager
    var restaurantId: Int
    
    var body: some View {
        VStack {
            ForEach(foodList.filter { $0.restaurantId == restaurantId }) { foodItem in
                AdminFoodItemRow(foodItem: foodItem,
                                 onEdit: {
                    // Handle edit action here, e.g., present edit view
                    print("Editing \(foodItem.name)")
                },
                                 onDelete: {
                    // Handle delete action here
                    print("Deleting \(foodItem.name)")
                })
            }
        }
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
//// Preview
//#Preview {
//    AdminRestaurantDetailView(restaurant: sampleRestaurants[0])
//}




