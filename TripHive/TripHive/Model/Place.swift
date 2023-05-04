//
//  Place.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation

class Place {
    
    var placeName: String
    var price: Int
    
    init() {
        placeName = "Place"
        price = 0
    }
    
    func setPlaceName(_ place: String) {
        placeName = place
    }
    
    func getPlaceName() -> String {
        return placeName
    }
    
    func setPrice(_ cost: Int) {
        price = cost
    }
    
    func getPrice() -> Int {
        return price
    }
    
}
