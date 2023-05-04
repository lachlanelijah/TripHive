//
//  Trip.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation
import UIKit

var config = UIImage.SymbolConfiguration(paletteColors: [.systemMint, .systemBlue])

class Trip {
    
    var numberOfPeople: Int
    var tripName: String
    var tripIcon: UIImage
    
    init() {
        numberOfPeople = 1
        tripName = "Trip"
        tripIcon = UIImage(systemName: "airplane.departure", withConfiguration: config)!
    }
    
    func setNumberOfPeople(_ people: Int) {
        numberOfPeople = people
    }
    
    func getNumberOfPeople() -> Int {
        return numberOfPeople
    }
    
    func setTripName(_ name: String) {
        tripName = name
    }
    
    func getTripName() -> String {
        return tripName
    }
}
