//
//  Trip.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation
import UIKit

var config = UIImage.SymbolConfiguration(paletteColors: [.systemMint, .systemOrange])
var defaultLocation1 = Location(
    locationName: "Default Location 1",
    arrivalDate: Date(), departureDate: Date(),
    categories: [
        Category(categoryName: "Accommodation", categoryType: .accommodation, items: defaultAccommodation1),
        Category(categoryName: "Activities", categoryType: .activities, items: defaultActivities1)]
)

var defaultAccommodation1 = [Item(itemName: "Hotel 1", itemPrice: 50), Item(itemName: "Hotel 2", itemPrice: 75)]
var defaultActivities1 = [Item(itemName: "Theme Park", itemPrice: 40), Item(itemName: "Art Museum", itemPrice: 30)]

var defaultLocation2 = Location(
    locationName: "Default Location 2",
    arrivalDate: Date(), departureDate: Date(),
    categories: [
        Category(categoryName: "Accommodation", categoryType: .accommodation, items: defaultAccommodation2),
        Category(categoryName: "Activities", categoryType: .activities, items: defaultActivities2)
    ]
)

var defaultAccommodation2 = [Item(itemName: "Hotel 3", itemPrice: 30), Item(itemName: "Hotel 4", itemPrice: 100)]
var defaultActivities2 = [Item(itemName: "Coastal Walk", itemPrice: 0), Item(itemName: "Parliament House", itemPrice: 5)]

enum categoryType {
    case accommodation, activities
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
    
    func getItemCount() -> Int {
        return items.count
    }
    
}

struct Item {
    var itemName: String
    var itemPrice: Int
    var pointsFromEachPerson: [Int] = []
    var totalPoints: Int = 0
    var shortlisted: Bool = false
}

class Trip {
    var id = UUID();
    var tripName: String
    var numberOfPeople: Int
    var tripYear: Int;
    var tripIcon: UIImage
    var locations: [Location]
    
    init(people: Int, name: String, year: Int) {
        numberOfPeople = people;
        tripName = name;
        tripYear = year;
        tripIcon = UIImage(systemName: "airplane.arrival", withConfiguration: config)!
        locations = [defaultLocation1, defaultLocation2]
    }
    
    // Parameterised constructor
    init(people: Int, name: String, year: Int, icon: UIImage) {
        numberOfPeople = people
        tripName = name
        tripYear = year;
        tripIcon = icon
        locations = [defaultLocation1, defaultLocation2]
    }
    
    func isValid() -> Bool {
        return !tripName.isEmpty && numberOfPeople > 0 && tripYear > 0;
    }
    
    func addLocation(_ location: Location) {
        locations.append(location);
    }
    
    func setLocations(locations: [Location]) {
        self.locations = locations;
    }
    
    func removeLocation(index: Int) {
        locations.remove(at: index)
    }
    
    func getLocationCount() -> Int {
        return locations.count
    }
    
    func getItemCount(selectedTrip: Int, selectedLocation: Int, category: categoryType) -> Int {
        //Gets the item count of the selected trip, so the ItemTableViewController can set the right amount of rows
        if category == .accommodation {
            return trips[selectedTrip].locations[selectedLocation].categories[0].getItemCount()
        } else {
            return trips[selectedTrip].locations[selectedLocation].categories[1].getItemCount()
        }
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
    
    func setTripYear(_ year: Int) {
        tripYear = year;
    }
    
    func getTripYear() -> Int {
        return tripYear;
    }
    
    func setIcon(_ name: UIImage) {
        tripIcon = name
    }
    
    func getIcon() -> UIImage {
        return tripIcon
    }
}
