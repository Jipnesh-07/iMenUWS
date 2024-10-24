import SwiftUI
import MapKit
import CoreLocation

struct UserRestaurantDetailsView: View {
    var restaurant: Restaurant
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var locationManager = LocationManager() // Geocoding helper
    @EnvironmentObject var orderManager: OrderManager // Access to order manager
    @State private var showOrderView = false // State to control Navigation for the ordersView
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
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
                    UserRestaurantInfoView(restaurant: restaurant)
                    
                    Divider()
                    
                    Text("Top Rated Food Items: ")
                        .font(.headline)
                        .padding([.horizontal, .bottom], 10)
                    
                    // List of Food Items
                    UserRestaurantFoodItemsView(restaurantId: restaurant.id)
                    
                    Divider()
                    
                    // Restaurant Location Map
                    if let coordinates = locationManager.locationCoordinates {
                        UserRestaurantLocationView(region: $region, locationName: restaurant.location)
                            .onAppear {
                                updateMapRegion(coordinates: coordinates)
                            }
                    } else if let errorMessage = locationManager.errorMessage {
                        Text(errorMessage).foregroundColor(.red)
                    } else {
                        Text("Fetching location for \(restaurant.location)...")
                    }
                }
                .navigationTitle(restaurant.name)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    locationManager.fetchCoordinates(for: restaurant.location)
                }
            }
            
            // ZStack for floating button
            if totalItemsInOrder() > 0 {
                Button(action: {
                    showOrderView = true
                }) {
                    HStack {
                        Text("\(totalItemsInOrder()) items") // Show total quantity of items
                            .font(.headline)
                            .foregroundColor(.white)
                        Image(systemName: "cart.fill")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                }
                .padding()
                .fullScreenCover(isPresented: $showOrderView) {
                    UserOrdersView().environmentObject(orderManager) // Redirect to UserOrdersView
                }
            }
        }
    }
    
    // Function for Calculating Total Items in the view
    private func totalItemsInOrder() -> Int {
        return orderManager.totalQuantity
    }
    
    // updating the map view
    private func updateMapRegion(coordinates: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}

// user restaurant food items view
struct UserRestaurantFoodItemsView: View {
    @EnvironmentObject var orderManager: OrderManager // Access to order manager
    var restaurantId: Int
    
    var body: some View {
        ForEach(foodList.filter { $0.restaurantId == restaurantId }) { foodItem in
            FoodItemRow(foodItem: foodItem)
                .environmentObject(orderManager) // Passing value -> the orderManager to FoodItemRow
        }
    }
}

// user restaurant info view
struct UserRestaurantInfoView: View {
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
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.footnote)
                    
                    Text("\(restaurant.rating, specifier: "%.1f")")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.footnote)
                    
                }
            }
            
            // Cuisines
            Text("Cuisines: \(restaurant.cuisine.joined(separator: ", "))")
                .font(.subheadline)
            
            // Price per Person
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

// view for showing location in the restaurant view
struct UserRestaurantLocationView: View {
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

#Preview {
    UserRestaurantDetailsView(restaurant: sampleRestaurants[0])
}
