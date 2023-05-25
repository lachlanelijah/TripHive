//
//  Item.swift
//  TripHive
//
//  Created by Mostafa Rahinuzzaman on 25/5/2023.
//

import Foundation

// An Activity or Accoommodation item
class Item: Codable {
    var itemName: String
    var itemPrice: Int
    var pointsFromEachPerson: [Int] = []
    var totalPoints: Int = 0
    var shortlisted: Int = 0
    
    init(itemName: String, itemPrice: Int) {
        self.itemName = itemName
        self.itemPrice = itemPrice
    }
    
    init(itemName: String, itemPrice: Int, pointsFromEachPerson: [Int], totalPoints: Int, shortlisted: Int) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.pointsFromEachPerson = pointsFromEachPerson
        self.totalPoints = totalPoints
        self.shortlisted = shortlisted
    }
    
    func isValid() -> Bool {
        return !itemName.isEmpty && itemPrice >= 0;
    }
}
