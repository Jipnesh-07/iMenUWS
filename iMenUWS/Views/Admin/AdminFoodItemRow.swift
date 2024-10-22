//
//  AdminFoodItemRow.swift
//  iMenUWS
//
//  Created by STUDENT on 20/10/24.
//
import SwiftUI

struct AdminFoodItemRow: View {
    var foodItem: FoodItem
    var onEdit: () -> Void // Closure to handle editing
    var onDelete: () -> Void // Closure to handle deletion

    var body: some View {
        HStack {
            // Food Item Image
            if let imageName = foodItem.image, !imageName.isEmpty {
                if imageExistsInDocumentsDirectory(imageName) {
                    // Image is from the documents directory
                    if let imagePath = getImagePath(from: imageName) {
                        Image(uiImage: UIImage(contentsOfFile: imagePath) ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .padding(4)
                            .frame(width: 100, height: 100)
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(10)
                            .clipped()
                    }
                } else {
                    // Image is from the app's asset catalog
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(4)
                        .frame(width: 100, height: 100)
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                        .clipped()
                }
            } else {
                Rectangle() // Placeholder if image is missing
//                    .resizable()
                    .scaledToFit()
                    .padding(4)
                    .frame(width: 100, height: 100)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                // Food Item Name
                Text(foodItem.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                // Ingredients
                Text(foodItem.ingredients)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Price
                Text("Price: $\(foodItem.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
            .padding(.leading, 10)
            
            Spacer() // Pushes the content to the left
            
            // Action Buttons for Edit and Delete
            HStack {
                Button(action: {
                    onEdit() // Call the edit action
                }) {
                    Image(systemName: "pencil")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(width: 30, height: 30)
                }
                
                Button(action: {
                    onDelete() // Call the delete action
                }) {
                    Image(systemName: "trash")
                        .font(.headline)
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.leading, 10)
        }
        .padding()
        .background(Color.white) // Background color for the row
        .cornerRadius(10) // Rounded corners for the row
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Shadow effect
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1) // Light border
        )
        .padding(.horizontal)
    }
    
    // Helper function to get the full image path
    func getImagePath(from imageName: String) -> String? {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return directory.appendingPathComponent(imageName).path
        }
        return nil
    }
    
    // Helper function to check if the image exists in the documents directory
    func imageExistsInDocumentsDirectory(_ imageName: String) -> Bool {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imagePath = directory.appendingPathComponent(imageName)
            return fileManager.fileExists(atPath: imagePath.path)
        }
        return false
    }
}



