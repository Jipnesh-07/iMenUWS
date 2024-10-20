//
//  Restaurant.swift
//  iMenUWS
//
//  Created by iOS on 15/10/24.
//

import Foundation

struct Restaurant: Identifiable {
    var id: Int
    var name: String
    var cuisine: [String]
    var location: String // City or address
    var minimumOrderCharge: Double
    var image: String? // Optional image URL or name
    var rating: Double
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
    Restaurant(id: 1, name: "Sydney Harbor Dine", cuisine: ["Seafood"], location: "Sydney, Australia", minimumOrderCharge: 45.0, image: "r1", rating: 4.7),
    Restaurant(id: 2, name: "Outback Grill", cuisine: ["BBQ"], location: "Melbourne, Australia", minimumOrderCharge: 55.0, image: "r2", rating: 4.6),
    Restaurant(id: 3, name: "Coastal Breeze", cuisine: ["Mediterranean"], location: "Gold Coast, Australia", minimumOrderCharge: 50.0, image: "r3", rating: 4.8 )
]

