//
//  Trip.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation
import UIKit

var config = UIImage.SymbolConfiguration(paletteColors: [.systemMint])

var defaultLocation1 = Location(
    locationName: "Tokyo",
    arrivalDate: Date(), departureDate: Date(),
    categories: [
        Category(categoryName: "Accommodation", categoryType: .accommodation, items: defaultAccommodation1),
        Category(categoryName: "Activities", categoryType: .activities, items: defaultActivities1)]
)

var defaultAccommodation1 = [Item(itemName: "Tokyo Motel", itemPrice: 50), Item(itemName: "Tokyo Luxury Hotel", itemPrice: 75)]
var defaultActivities1 = [Item(itemName: "Theme Park", itemPrice: 40), Item(itemName: "Art Museum", itemPrice: 30)]

var defaultLocation2 = Location(
    locationName: "Seoul",
    arrivalDate: Date(), departureDate: Date(),
    categories: [
        Category(categoryName: "Accommodation", categoryType: .accommodation, items: defaultAccommodation2),
        Category(categoryName: "Activities", categoryType: .activities, items: defaultActivities2)
    ]
)

var defaultAccommodation2 = [Item(itemName: "Seoul Motel", itemPrice: 30), Item(itemName: "Seoul Luxury Hotel", itemPrice: 100)]
var defaultActivities2 = [Item(itemName: "Coastal Walk", itemPrice: 0), Item(itemName: "Parliament House", itemPrice: 5)]

enum categoryType: Codable {
    case accommodation, activities
}

struct Category: Codable {
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

class Trip: Codable {
    var tripName: String
    var numberOfPeople: Int
    var tripYear: Int;
    var locations: [Location]
    var id = UUID()
    
    init(people: Int, name: String, year: Int) {
        numberOfPeople = people;
        tripName = name;
        tripYear = year;
        locations = []
    }
    
    init(people: Int, name: String, year: Int, locations: [Location]) {
        numberOfPeople = people
        tripName = name
        tripYear = year;
        self.locations = locations
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
    
//    func writeToStorage() {
//        let toWrite = self
//        let defaults = UserDefaults.standard
//        defaults.set(try? PropertyListEncoder().encode(toWrite), forKey: "\(self.id)")
//    }
//
//    func readFromStorage(uuid: UUID) -> [Trip] {
//        let defaults = UserDefaults.standard
//        if let savedData = defaults.value(forKey: "\(uuid)") as? Data {
//            if let savedTrips = try? PropertyListDecoder().decode(Array<Trip>.self, from: savedData) {
//                print("Trips read from storage: \(savedTrips)")
//                return savedTrips
//            }
//        }
//        return []
//    }
    
    static func getDefaults() -> [Trip] {
        return [
            Trip(people: 2, name: "Japan", year: 2024, locations: [defaultLocation1]),
            Trip(people: 3, name: "Korea", year: 2025, locations: [defaultLocation2])
        ]
    }
}
