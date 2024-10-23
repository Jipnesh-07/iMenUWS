//
//  EditRestaurantView.swift
//  iMenUWS
//
//  Created by STUDENT on 20/10/24.
//

import SwiftUI
import UIKit

struct AdminEditRestaurantView: View {
    @Binding var restaurant: Restaurant // Binding to the restaurant being edited
    
    @State private var name: String
    @State private var location: String
    @State private var minimumOrderCharge: Double
    
    init(restaurant: Binding<Restaurant>) {
        self._restaurant = restaurant
        self._name = State(initialValue: restaurant.wrappedValue.name)
        self._location = State(initialValue: restaurant.wrappedValue.location)
        self._minimumOrderCharge = State(initialValue: restaurant.wrappedValue.minimumOrderCharge)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Restaurant Details")) {
                TextField("Restaurant Name", text: $restaurant.name)
                TextField("Location", text: $restaurant.location)
                TextField("Minimum Order Charge", value: $minimumOrderCharge, formatter: NumberFormatter())
            }
            
            Button("Save") {
                // Update the restaurant with new values
                restaurant.name = name
                restaurant.location = location
                restaurant.minimumOrderCharge = minimumOrderCharge
            }
            
        }
        .navigationTitle("Edit Restaurant")
        .navigationBarTitleDisplayMode(.inline)
    }
}
