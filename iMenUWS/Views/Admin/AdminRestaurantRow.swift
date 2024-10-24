//
//  RestaurantRow.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import SwiftUI

struct AdminRestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            // Restaurant Image
            if let imageName = restaurant.image, !imageName.isEmpty {
                if CheckIfImageExistsInDocumentsDirectory(imageName) {
                    // Image is from the documents directory
                    if let imagePath = getImagePath(from: imageName) {
                        Image(uiImage: UIImage(contentsOfFile: imagePath) ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .clipped()
                    }
                } else {
                    // Image is from the app's asset catalog
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .clipped()
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(restaurant.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(restaurant.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Min Order: $\(restaurant.minimumOrderCharge, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.primary)
            }
            .padding(.leading, 10)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .padding()
    }
    
    // Helper function to get the full image path
    func getImagePath(from imageName: String) -> String? {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imagePath = directory.appendingPathComponent(imageName)
            return imagePath.path
        }
        return nil
    }
    
    // Helper function to check if the image exists in the documents directory
    func CheckIfImageExistsInDocumentsDirectory(_ imageName: String) -> Bool {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imagePath = directory.appendingPathComponent(imageName)
            return fileManager.fileExists(atPath: imagePath.path)
        }
        return false
    }
    
}
