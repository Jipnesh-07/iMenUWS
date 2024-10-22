//
//  AdminFoodItemRow.swift
//  iMenUWS
//
//  Created by STUDENT on 20/10/24.
//
import SwiftUI

struct AdminFoodItemRow: View {
    var foodItem: FoodItem
    var onEdit: (FoodItem) -> Void // Closure to handle editing with updated food item
    var onDelete: () -> Void // Closure to handle deletion

    @State private var isEditing: Bool = false
    @State private var editedFoodItem: FoodItem

    init(foodItem: FoodItem, onEdit: @escaping (FoodItem) -> Void, onDelete: @escaping () -> Void) {
        self.foodItem = foodItem
        self.onEdit = onEdit
        self.onDelete = onDelete
        self._editedFoodItem = State(initialValue: foodItem) // Initialize with current food item
    }

    var body: some View {
        HStack {
            // Food Item Image
            if let imageName = editedFoodItem.image, !imageName.isEmpty {
                if imageExistsInDocumentsDirectory(imageName) {
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
                    .scaledToFit()
                    .padding(4)
                    .frame(width: 100, height: 100)
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(10)
                    .clipped()
            }

            VStack(alignment: .leading, spacing: 4) {
                if isEditing {
                    TextField("Name", text: $editedFoodItem.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Ingredients", text: $editedFoodItem.ingredients)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Price", value: $editedFoodItem.price, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    // Food Item Name
                    Text(editedFoodItem.name)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    // Ingredients
                    Text(editedFoodItem.ingredients)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Price
                    Text("Price: $\(editedFoodItem.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                }
            }
            .padding(.leading, 10)

            Spacer() // Pushes the content to the left

            // Action Buttons for Edit and Delete
            HStack {
                if isEditing {
                    Button(action: {
                        onEdit(editedFoodItem) // Call the edit action with updated food item
                        isEditing.toggle() // Exit edit mode
                    }) {
                        Image(systemName: "checkmark")
                            .font(.headline)
                            .foregroundColor(.green)
                            .frame(width: 30, height: 30)
                    }
                } else {
                    Button(action: {
                        isEditing.toggle() // Toggle to edit mode
                    }) {
                        Image(systemName: "pencil")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(width: 30, height: 30)
                    }
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
