//
//  Trip.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation
import UIKit

var config = UIImage.SymbolConfiguration(paletteColors: [.systemMint, .systemOrange])
var defaultLocation = Location(
    locationName: "Default Location",
    categories: [
        Category(categoryName: "Accommodation", categoryType: .accommodation, items: defaultAccommodation),
        Category(categoryName: "Places", categoryType: .places, items: defaultPlaces)]
)
var defaultAccommodation = [Item(itemName: "Hotel 1", itemPrice: 50), Item(itemName: "Hotel 2", itemPrice: 75)]
var defaultPlaces = [Item(itemName: "Theme Park", itemPrice: 40), Item(itemName: "Art Museum", itemPrice: 30)]

enum categoryType {
    case accommodation, places
}

struct Location {
    var locationName: String
    var categories: [Category]
    
    mutating func setLocationName(name: String) {
        locationName = name
    }
}

struct Category {
    var categoryName: String
    var categoryType: categoryType
    var items: [Item]
    
    mutating func addItem(name: String, price: Int) {
        items.append(Item(itemName: name, itemPrice: price))
    }
    
    mutating func removeItem(index: Int) {
        items.remove(at: index)
    }
    
}

struct Item {
    var itemName: String
    var itemPrice: Int
}

class Trip {
    
    var numberOfPeople: Int
    var tripName: String
    var tripIcon: UIImage
    var locations: [Location]
    
    init(people: Int, name: String, icon: UIImage) {
        numberOfPeople = people
        tripName = name
        tripIcon = icon
        locations = [defaultLocation]
    }
    
    func addLocation(_ name: String) {
        locations.append(defaultLocation)
        locations[locations.count-1].setLocationName(name: name)
    }
    
    func removeLocation(index: Int) {
        locations.remove(at: index)
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
    
    func getLocationCount() -> Int {
        return locations.count
    }
}
