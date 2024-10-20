//
//  UserHomeView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//
import SwiftUI

struct UserHomeView: View {
    @State private var searchText: String = ""

    // Filtered list of restaurants based on search text
    var filteredRestaurants: [Restaurant] {
        if searchText.isEmpty {
            return sampleRestaurants
        } else {
            return sampleRestaurants.filter { $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.location.contains(searchText.lowercased())
                
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    // Top Picks Text
                    Text("Top Picks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    // Restaurant rows displayed in a VStack
                    ForEach(filteredRestaurants) { restaurant in
                        NavigationLink(destination: UserRestaurantDetailsView(restaurant: restaurant)) {
                            UserRestaurantRow(restaurant: restaurant)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                    }
                }
                .navigationTitle("Home")
                .searchable(text: $searchText, prompt: "Search Restaurants")
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the back button

    }
}


#Preview {
    UserHomeView()
}
