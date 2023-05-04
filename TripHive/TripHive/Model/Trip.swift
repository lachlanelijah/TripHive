//
//  Trip.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation
import UIKit

var config = UIImage.SymbolConfiguration(paletteColors: [.systemMint, .systemOrange])

class Trip {
    
    var numberOfPeople: Int
    var tripName: String
    var tripIcon: UIImage
    
    init(people: Int, name: String, icon: UIImage) {
        numberOfPeople = people
        tripName = name
        tripIcon = icon
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
    
    func setIcon(_ name: UIImage) {
        tripIcon = name
    }
    
    func getIcon() -> UIImage {
        return tripIcon
    }
}
