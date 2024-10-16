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
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading,spacing: -10){
                    
                    Text("Top Picks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.horizontal,.bottom])
                    // Restaurant rows displayed in a VStack
                    ForEach(filteredRestaurants) { restaurant in
                        NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                            RestaurantRow(restaurant: restaurant)
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
                AddRestaurantView()
            }
        }
    }
    
    // Computed property for filtered restaurants
    var filteredRestaurants: [Restaurant] {
        if searchText.isEmpty {
            return sampleRestaurants
        } else {
            return sampleRestaurants.filter { restaurant in
                restaurant.name.lowercased().contains(searchText.lowercased()) ||
                restaurant.location.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    AdminHomeView()
}
