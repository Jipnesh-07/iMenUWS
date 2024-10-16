//
//  Restaurant.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import Foundation

//struct Restaurant: Identifiable {
//    var id: Int
//    var name: String
//    var cuisine: String
//    var location: String
//    var minimumOrderCharge: Double
//    var image: String? // Optional image URL or name
//}
//
//let restaurants: [Restaurant] = [
//    Restaurant(id: 1, name: "The WonderInn Riverside Retreat", cuisine: "Thai", location: "Norway", minimumOrderCharge: 50.0, image: "r1"),
//    Restaurant(id: 2, name: "La Piazza", cuisine: "Italian", location: "Rome, Italy", minimumOrderCharge: 80.0, image: "r2"),
//    Restaurant(id: 3, name: "The Gourmet Garden", cuisine: "Vegetarian", location: "San Francisco, USA", minimumOrderCharge: 60.0, image: "r3"),
//    Restaurant(id: 4, name: "Sushi Master", cuisine: "Japanese", location: "Tokyo, Japan", minimumOrderCharge: 120.0, image: "r4"),
//    Restaurant(id: 5, name: "El Asador", cuisine: "Argentinian", location: "Buenos Aires, Argentina", minimumOrderCharge: 75.0, image: "r1"),
//    Restaurant(id: 6, name: "Le Petit Bistro", cuisine: "French", location: "Paris, France", minimumOrderCharge: 100.0, image: "r2"),
//    Restaurant(id: 7, name: "Spicy India", cuisine: "Indian", location: "Mumbai, India", minimumOrderCharge: 40.0, image: "r3"),
//    Restaurant(id: 8, name: "Café del Mar", cuisine: "Mediterranean", location: "Barcelona, Spain", minimumOrderCharge: 90.0, image: "r4"),
//]


// Model for Restaurant
struct Restaurant: Identifiable {
    var id: Int
    var name: String
    var cuisine: String
    var location: String
    var minimumOrderCharge: Double
    var image: String? // Optional image URL or name
    var rating: Double
    var reviewCount: Int
    var amenities: [String]
    var cuisines: [String]
    var pricePerPerson: Double
}


// Sample Restaurant Data
let sampleRestaurants: [Restaurant] = [
    Restaurant(id: 1, name: "The Gourmet House", cuisine: "Italian", location: "Rome, Italy", minimumOrderCharge: 50.0, image: "r1", rating: 4.8, reviewCount: 200, amenities: ["Wi-Fi", "Parking", "Air Conditioning", "Outdoor Seating"], cuisines: ["Italian", "Vegetarian"], pricePerPerson: 100.0),
    Restaurant(id: 2, name: "Mountain View Lodge", cuisine: "Chinese", location: "Beijing, China", minimumOrderCharge: 60.0, image: "r2", rating: 4.5, reviewCount: 150, amenities: ["Wi-Fi", "Outdoor Seating"], cuisines: ["Chinese", "Vegetarian"], pricePerPerson: 80.0),
    // Add more restaurants...
]
