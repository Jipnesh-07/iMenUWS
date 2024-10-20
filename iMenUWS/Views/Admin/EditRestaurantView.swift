//
//  EditRestaurantView.swift
//  iMenUWS
//
//  Created by STUDENT on 20/10/24.
//

import SwiftUI
import UIKit

struct EditRestaurantView: View {
    @Binding var restaurant: Restaurant
    @State private var minimumOrderCharge: String = ""
    @State private var showingDeleteConfirmation = false
    @Environment(\.presentationMode) var presentationMode // Add this line
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Restaurant Details")) {
                    TextField("Restaurant Name", text: $restaurant.name)
                    TextField("Location", text: $restaurant.location)
                    
                    TextField("Cuisines (comma separated)", text: Binding(
                        get: { restaurant.cuisine.joined(separator: ", ") },
                        set: { restaurant.cuisine = $0.components(separatedBy: ", ").map { $0.trimmingCharacters(in: .whitespaces) } }
                    ))
                    
                    TextField("Minimum Order Charge", text: $minimumOrderCharge)
                        .keyboardType(.decimalPad)
                }
                
                // Add delete button
                Button(action: {
                    showingDeleteConfirmation = true
                }) {
                    Text("Delete Restaurant")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Edit Restaurant")
            .navigationBarItems(trailing: Button("Save") {
                saveChanges()
            })
            .alert(isPresented: $showingDeleteConfirmation) {
                Alert(title: Text("Delete Restaurant"),
                      message: Text("Are you sure you want to delete \(restaurant.name)?"),
                      primaryButton: .destructive(Text("Delete")) {
                    deleteRestaurant()
                },
                      secondaryButton: .cancel())
            }
        }
        .onAppear {
            minimumOrderCharge = "\(restaurant.minimumOrderCharge)"
        }
    }
    
    private func saveChanges() {
        // Update the minimum order charge
        if let charge = Double(minimumOrderCharge) {
            restaurant.minimumOrderCharge = charge
        }
        
        // Add your save logic here (e.g., database update)
        
        // Dismiss the view after saving
        dismiss()
    }
    
    private func deleteRestaurant() {
        // Implement the logic to delete the restaurant from the database
        _ = "DELETE FROM Restaurant WHERE id = \(restaurant.id)"
        // DatabaseManager.shared.executeQuery(query: query)
        
        // Dismiss the view after deletion
        dismiss()
    }
    
    private func dismiss() {
        // You can dismiss the view using presentation mode or a binding
        presentationMode.wrappedValue.dismiss()
    }
}

// Preview
#Preview {
    EditRestaurantView(restaurant: .constant(sampleRestaurants[0]))
}
