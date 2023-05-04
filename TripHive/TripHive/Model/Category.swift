//
//  Category.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import Foundation
import UIKit

enum categoryType {
    case accomodation, place
}

class Category {
    
    var categoryName: String
    var categoryType: categoryType
    
    init() {
        categoryName = "Category"
        categoryType = .place
    }
}
