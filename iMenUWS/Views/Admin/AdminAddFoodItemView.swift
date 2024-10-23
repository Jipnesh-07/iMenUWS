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
    
    var restaurantId: Int
    var onAddFoodItem: (FoodItem) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Item Details")) {
                    TextField("Food Name", text: $name)
                    TextField("Ingredients", text: $ingredients)
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                    
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
                            } else {
                                Text("No image selected")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker3(image: $image)
                    }
                }
                
                Button(action: {
                    if let foodPrice = Double(price), let imageName = AddingImagetoDocumentsDirectory(image: image) {
                        let newFoodItem = FoodItem(
                            id: UUID().hashValue, // Generate a unique ID using UUID
                            name: name,
                            restaurantId: restaurantId,
                            ingredients: ingredients,
                            price: foodPrice,
                            image: imageName
                        )
                        onAddFoodItem(newFoodItem)
                        presentationMode.wrappedValue.dismiss()
                    }
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
        }
    }
    
    private func AddingImagetoDocumentsDirectory(image: UIImage?) -> String? {
        guard let image = image else { return nil }
        if let data = image.jpegData(compressionQuality: 1.0) {
            let fileManager = FileManager.default
            if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let imageName = "\(UUID().uuidString).jpg"
                let fileURL = directory.appendingPathComponent(imageName)
                
                do {
                    try data.write(to: fileURL)
                    return imageName
                } catch {
                    print("Error saving image: \(error)")
                }
            }
        }
        return nil
    }
}





import SwiftUI

struct ImagePicker3: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?
        var parent: ImagePicker3
        
        init(image: Binding<UIImage?>, parent: ImagePicker3) {
            _image = image
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                print("Image selected: \(selectedImage)") // Debugging line
                image = selectedImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
