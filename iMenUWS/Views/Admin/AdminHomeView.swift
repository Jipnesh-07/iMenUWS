//
//  AdminHomeView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct AdminHomeView: View {
    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    @State private var restaurants: [Restaurant] = sampleRestaurants // Manage restaurants as state
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: -10) {
                    Text("Top Picks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.horizontal, .bottom])
                    
                    // Display the list of restaurants
                    ForEach(filteredRestaurants.indices, id: \.self) { index in
                        let restaurant = filteredRestaurants[index]
                        NavigationLink(destination: AdminRestaurantDetailView(restaurant: $restaurants[index])) {
                            AdminRestaurantRow(restaurant: restaurant)
                                .contextMenu {
                                    Button(action: {
                                        // Set the selected restaurant for editing
                                        selectedRestaurant = restaurant
                                    }) {
                                        Text("Edit")
                                        Image(systemName: "pencil")
                                    }
                                    
                                    Button(action: {
                                        deleteRestaurant(restaurant: restaurant)
                                    }) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                AddRestaurantView(onSave: { newRestaurant in
                    // Add the new restaurant to the list and dismiss the sheet
                    restaurants.append(newRestaurant)
                    isPresented = false
                })
            }
            .sheet(item: $selectedRestaurant) { restaurant in
                AdminEditRestaurantView(restaurant: Binding(
                    get: { restaurant },
                    set: { updatedRestaurant in
                        if let index = restaurants.firstIndex(where: { $0.id == updatedRestaurant.id }) {
                            restaurants[index] = updatedRestaurant // Update restaurant in the list
                        }
                    }
                ))
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func deleteRestaurant(restaurant: Restaurant) {
        // Remove the restaurant from the list
        restaurants.removeAll { $0.id == restaurant.id }
    }
    
    // Computed property for filtered restaurants
    var filteredRestaurants: [Restaurant] {
        if searchText.isEmpty {
            return restaurants
        } else {
            return restaurants.filter { restaurant in
                restaurant.name.lowercased().contains(searchText.lowercased()) ||
                restaurant.location.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    AdminHomeView()
}
