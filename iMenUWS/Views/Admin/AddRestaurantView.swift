//
//  AddRestaurantView.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI
import UIKit

struct AddRestaurantView: View {
    @State private var name = ""
    @State private var cuisines: [String] = []
    @State private var cuisineInput = "" // For adding multiple cuisines
    @State private var location = ""
    @State private var minimumOrderCharge = ""
    @State private var rating = "" // Added field for rating
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Button(action: {
                    showingImagePicker = true
                }) {
                    // Square box for image selection
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100) // Square dimensions
                            .cornerRadius(10)
                        
                        if let selectedImage = image {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100) // Same dimensions for consistency
                                .cornerRadius(10)
                                .clipped()
                        } else {
                            Text("Select Image")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .multilineTextAlignment(.center)
                .padding(.leading, 100)
                
                Section(header: Text("Restaurant Details")) {
                    TextField("Restaurant Name", text: $name)
                    
                    TextField("Location", text: $location)
                }
                
                Section(header: Text("Cuisines")) {
                    HStack {
                        TextField("Cuisine", text: $cuisineInput)
                        Button(action: {
                            if !cuisineInput.isEmpty {
                                cuisines.append(cuisineInput)
                                cuisineInput = ""
                            }
                        }) {
                            Text("Add")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    ForEach(cuisines, id: \.self) { cuisine in
                        Text(cuisine)
                    }
                }
                
                Section(header: Text("Order Details")) {
                    TextField("Minimum Order Charge", text: $minimumOrderCharge)
                        .keyboardType(.decimalPad)
                    
                }
                
                Section(header: Text("Ratings")) {
                    
                    TextField("Rating (0.0 - 5.0)", text: $rating) // Added field for rating
                        .keyboardType(.decimalPad) // Assuming rating is a decimal
                }
            }
            .navigationTitle("Add Restaurant")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: saveRestaurant) {
                Text("Save")
                    .foregroundColor(.blue)
            })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $image) {
                    // Optionally do something after image selection
                }
            }
        }
    }
    
    func saveRestaurant() {
        guard let minOrderCharge = Double(minimumOrderCharge), let restaurantRating = Double(rating) else {
            // Handle invalid minimum order charge or rating
            return
        }
        
        // You can handle image saving to your database here
        // Convert `image` to Data and save it, or upload it to a server
        
        let cuisinesString = cuisines.joined(separator: ", ") // Convert array to a string
        
        _ = """
            INSERT INTO Restaurant (name, cuisine, location, minimumOrderCharge, image, rating)
            VALUES ('\(name)', '\(cuisinesString)', '\(location)', \(minOrderCharge), '\(image?.description ?? "")', \(restaurantRating))
        """
        // DatabaseManager.shared.executeQuery(query: query)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var completion: (() -> Void)?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true) {
                self.parent.completion?()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.parent.completion?()
            }
        }
    }
}

#Preview {
    AddRestaurantView()
}
