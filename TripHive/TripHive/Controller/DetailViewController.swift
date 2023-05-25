//
//  DetailViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 24/5/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedTrip = 0
    //test commit
    var selectedLocation = 0
    var selectedItem = 0
    var category: categoryType = .activities
    var propertyArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        if category == .accommodation {
            propertyArray.append("Accommodation name: \(trips[selectedTrip].locations[selectedLocation].categories[0].items[selectedItem].itemName)")
            propertyArray.append("Price per night: \(trips[selectedTrip].locations[selectedLocation].categories[0].items[selectedItem].itemPrice)")
        } else {
            propertyArray.append("Activity name: \(trips[selectedTrip].locations[selectedLocation].categories[1].items[selectedItem].itemName)")
            propertyArray.append("Activity cost: \(trips[selectedTrip].locations[selectedLocation].categories[1].items[selectedItem].itemPrice)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if category == .accommodation {
            return 2
        } else {
            return 2
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            let text = propertyArray[indexPath.row]
            cell.textLabel!.text = text
            return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//    }
}
