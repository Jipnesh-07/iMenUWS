//
//  Restaurant.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import Foundation

import Foundation

class Restaurant: ObservableObject, Identifiable {
    let id: Int
    @Published var name: String
    @Published var location: String
    @Published var cuisine: [String]
    @Published var minimumOrderCharge: Double
    var image: String?
    var rating: Double
    
    init(id: Int, name: String, location: String, cuisine: [String], minimumOrderCharge: Double, image: String?, rating: Double) {
        self.id = id
        self.name = name
        self.location = location
        self.cuisine = cuisine
        self.minimumOrderCharge = minimumOrderCharge
        self.image = image
        self.rating = rating
    }
}


import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let geocoder = CLGeocoder()

    @Published var locationCoordinates: CLLocationCoordinate2D? = nil
    @Published var errorMessage: String? = nil

    func fetchCoordinates(for address: String) {
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                self.errorMessage = "Error getting location: \(error.localizedDescription)"
            } else if let placemark = placemarks?.first, let location = placemark.location {
                self.locationCoordinates = location.coordinate
            }
        }
    }
}




let sampleRestaurants: [Restaurant] = [
    Restaurant(id: 1, name: "Sydney Harbor Dine", location: "Sydney, Australia", cuisine: ["Seafood"], minimumOrderCharge: 45.0, image: "r1", rating: 4.7),
    Restaurant(id: 2, name: "Outback Grill", location: "Melbourne, Australia", cuisine: ["BBQ"], minimumOrderCharge: 55.0, image: "r2", rating: 4.6),
    Restaurant(id: 3, name: "Coastal Breeze", location: "Gold Coast, Australia", cuisine: ["Mediterranean"], minimumOrderCharge: 50.0, image: "r3", rating: 4.8 )
]

