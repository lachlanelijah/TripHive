//
//  Location.swift
//  TripHive
//
//  Created by Mostafa Rahinuzzaman on 25/5/2023.
//

import Foundation

class Location: Codable {
    var locationName: String;
    var arrivalDate: Date;
    var departureDate: Date;
    var categories: [Category];
    
    init() {
        self.locationName = ""
        self.arrivalDate = Date()
        self.departureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        self.categories = [
            Category(categoryName: "Accommodation", categoryType: .accommodation, items: defaultAccommodation2),
            Category(categoryName: "Activities", categoryType: .activities, items: defaultActivities2)
        ];
    }
    
    init(locationName: String, arrivalDate: Date, departureDate: Date, categories: [Category]) {
        self.locationName = locationName
        self.arrivalDate = arrivalDate
        self.departureDate = departureDate
        self.categories = categories
    }
    
    func isValid() -> Bool {
        return !locationName.isEmpty;
    }
}
