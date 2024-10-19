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
    var cuisine: String
    var location: String // City or address
    var minimumOrderCharge: Double
    var image: String? // Optional image URL or name
    var rating: Double
    var reviewCount: Int
    var amenities: [String]
    var cuisines: [String]
    var pricePerPerson: Double
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
    Restaurant(id: 1, name: "The Gourmet House", cuisine: "Italian", location: "Rome, Italy", minimumOrderCharge: 50.0, image: "r1", rating: 4.8, reviewCount: 200, amenities: ["Wi-Fi", "Parking", "Air Conditioning", "Outdoor Seating"], cuisines: ["Italian", "Vegetarian"], pricePerPerson: 100.0),
    Restaurant(id: 2, name: "Mountain View Lodge", cuisine: "Chinese", location: "Beijing, China", minimumOrderCharge: 60.0, image: "r2", rating: 4.5, reviewCount: 150, amenities: ["Wi-Fi", "Outdoor Seating"], cuisines: ["Chinese", "Vegetarian"], pricePerPerson: 80.0)
]
