import SwiftUI
import MapKit
import CoreLocation

struct UserRestaurantDetailsView: View {
    var restaurant: Restaurant
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var locationManager = LocationManager() // Geocoding helper
    @EnvironmentObject var orderManager: OrderManager // Access to order manager


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
                UserRestaurantInfoView(restaurant: restaurant)
              
                Divider()
                
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
    }
    
    private func updateMapRegion(coordinates: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}

struct UserRestaurantFoodItemsView: View {
    @EnvironmentObject var orderManager: OrderManager // Access to order manager
    var restaurantId: Int
    
    var body: some View {
        ForEach(foodList.filter { $0.restaurantId == restaurantId }) { foodItem in
            FoodItemRow(foodItem: foodItem, orderManager: _orderManager)
        }
    }
}

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
                
                Text("\(restaurant.rating, specifier: "%.1f")")
                    .font(.subheadline)
                    .foregroundColor(.black)
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
