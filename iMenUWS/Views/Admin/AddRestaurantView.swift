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
    
    var onSave: (Restaurant) -> Void // Completion handler for saving a restaurant
    
    var body: some View {
        NavigationView {
            Form {
                Button(action: {
                    showingImagePicker = true
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                        
                        if let selectedImage = image {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
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
                    TextField("Rating (0.0 - 5.0)", text: $rating)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Restaurant")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: saveRestaurantDetails) {
                Text("Save")
                    .foregroundColor(.blue)
            })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $image)
            }
        }
    }
    
    func saveRestaurantDetails() {
        guard let minOrderCharge = Double(minimumOrderCharge), let restaurantRating = Double(rating) else {
            return // Handle invalid input
        }
        
        // Save the image to local storage
        let imageName = ImageAdditionToDocumentsDirectory(image: image)
        
        // New Restaurant Instance will ne created
        let newRestaurant = Restaurant(
            id: UUID().hashValue,
            name: name,
            location: location,
            cuisine: cuisines,
            minimumOrderCharge: minOrderCharge,
            image: imageName,
            rating: restaurantRating
        )
        
        // appending to restaurant list
        onSave(newRestaurant)
    }
    
    // Helper function to save image to documents directory
    func ImageAdditionToDocumentsDirectory(image: UIImage?) -> String? {
        guard let image = image else { return nil }
        
        let fileManager = FileManager.default
        let imageName = UUID().uuidString + ".jpg" // Unique name for the image
        if let data = image.jpegData(compressionQuality: 0.8) {
            if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let imagePath = directory.appendingPathComponent(imageName)
                do {
                    try data.write(to: imagePath)
                    return imageName // Return the image file name
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }
        return nil
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

