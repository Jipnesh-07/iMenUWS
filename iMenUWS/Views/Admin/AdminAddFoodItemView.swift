//
//  AdminAddFoodItemView.swift
//  iMenUWS
//
//  Created by STUDENT on 21/10/24.
//

import SwiftUI

struct AdminAddFoodItemView: View {
    @State private var name: String = ""
    @State private var ingredients: String = ""
    @State private var price: String = ""
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Item Details")) {
                    // Text field for Food Name
                    TextField("Food Name", text: $name)
                    
                    // Text field for Ingredients
                    TextField("Ingredients", text: $ingredients)
                    
                    // Text field for Price
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad) // Make it easy to input a decimal number
                    
                    // Image Picker button
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        HStack {
                            Text("Select Image")
                            Spacer()
                            if let selectedImage = image {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                
                // Add Item Button
                Button(action: {
                    // Placeholder action
                }) {
                    Text("Add Food Item")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Add New Food Item")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showingImagePicker) {
                // Add ImagePicker when implemented
                // For now, this is just a placeholder
            }
        }
    }
}

struct AdminAddFoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAddFoodItemView()
    }
}
