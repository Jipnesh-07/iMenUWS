//
//  EditFoodItemView.swift
//  iMenUWS
//
//  Created by STUDENT on 22/10/24.
//

import SwiftUI

struct EditFoodItemView: View {
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
    @Binding var foodItem: FoodItem // Use Binding to allow edits
    var onSave: (FoodItem) -> Void // Closure to handle save action

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Item Details")) {
                    TextField("Name", text: $foodItem.name)
                    TextField("Ingredients", text: $foodItem.ingredients)
                    TextField("Price", value: $foodItem.price, formatter: NumberFormatter()) // Ensure correct number input
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button(action: {
                        onSave(foodItem) // Call save closure with updated item
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }) {
                        Text("Save Changes")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Edit Food Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

