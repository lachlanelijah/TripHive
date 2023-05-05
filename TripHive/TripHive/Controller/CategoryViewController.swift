//
//  CategoryViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 5/5/2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var selectedTrip: Int = 0
    var selectedLocation: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAccommodationItemView" {
            let VC = segue.destination as? ItemTableViewController
            VC!.selectedTrip = selectedTrip
            VC!.category = .accommodation
            VC!.selectedLocation = selectedLocation
        }
        
        if segue.identifier == "goToActivitiesItemView" {
            let VC = segue.destination as? ItemTableViewController
            VC!.selectedTrip = selectedTrip
            VC!.category = .activities
            VC!.selectedLocation = selectedLocation
        }
    }
}
