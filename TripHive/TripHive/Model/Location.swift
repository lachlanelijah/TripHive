//
//  Location.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation

class Location {
    
    var locationName: String
    
    init() {
        locationName = "Location"
    }
    
    func setLocationName(_ location: String) {
        locationName = location
    }
    
    func getLocationName() -> String {
        return locationName
    }
    
}
