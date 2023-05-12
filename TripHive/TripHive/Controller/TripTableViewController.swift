//
//  TripTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import UIKit

var trips: [Trip] = []

class TripTableViewController: UITableViewController, TripDelegate, UINavigationControllerDelegate {
    
    func passTripInformation(tripName: String, tripPeople: Int) {
//        print("trip name is \(tripName) and number of people is \(tripPeople)")
        addTrip(tripName: tripName, tripPeople: tripPeople)
    }
    
    func addTrip(tripName: String, tripPeople: Int) {
        trips.append(Trip(people: tripPeople, name: tripName, icon: UIImage(systemName: "airplane.arrival", withConfiguration: config)!))
        self.tableView.reloadData()
    }
    
    @IBAction func goToAddTripViewButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddTripView", sender: nil)
    }
    
    var tripName = "Trip"
    var tripPeople = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        
        trips.append(Trip(people: 2, name: "Japan", icon: UIImage(systemName: "airplane.arrival", withConfiguration: config)!))
        trips.append(Trip(people: 3, name: "Korea", icon: UIImage(systemName: "airplane.arrival", withConfiguration: config)!))
         
        navigationController?.navigationBar.prefersLargeTitles = true
//      navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
        let trip = trips[indexPath.row]
        cell.tripNameLabel?.text = trip.getTripName()
        cell.tripIcon.image = trip.getIcon()
        cell.peopleNumberLabel.text = "People: \(trip.getNumberOfPeople())"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToLocationView", sender: self)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            let alert = UIAlertController(title: "Are you sure you want to delete this trip?", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(
//                title: "Delete",
//                style: .destructive,
//                handler: { _ in
//                    tableView.deleteRows(at: [indexPath], with: .fade)
//                    trips.remove(at: indexPath.row)
//            }))
//            alert.addAction(UIAlertAction(
//                title: "Cancel",
//                style: .cancel,
//                handler: { _ in
//                // cancel action
//            }))
//            present(alert,
//                    animated: true,
//                    completion: nil
//            )
//
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            trips.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
//                trips.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            let alert = UIAlertController(title: "Are you sure you want to delete this trip?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { _ in
                    trips.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { _ in
            }))
            self.present(alert,
                    animated: true,
                    completion: nil
            )
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
              print("Test")
              completionHandler(true)
       }
        
        editAction.backgroundColor = .systemMint
        
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, editAction])
            return swipeActions
    }
    
//    @objc func addTapped() {
//        let ac = UIAlertController(title: "Add new trip", message: nil, preferredStyle: .alert)
////        ac.addTextField()
////        ac.addTextField()
//        ac.addTextField { field in
//            field.placeholder = "Trip name"
//        }
//
//        ac.addTextField { field in
//            field.placeholder = "Number of people"
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
//            var name = "Trip"
//            if ac.textFields![0].text != "" {
//                name = ac.textFields![0].text!
//            }
//            let count = ac.textFields![1].text
//
//            trips.append(Trip(people: Int(count!) ?? 1, name: name , icon: UIImage(systemName: "airplane.arrival", withConfiguration: config)!))
//            self.tableView.reloadData()
//
//        }
//        ac.addAction(cancelAction)
//        ac.addAction(submitAction)
//
//        present(ac, animated: true)
//    }
//
    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)

                if tableView.isEditing {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
                }
                else {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
                }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddTripViewController {
            destination.delegate = self
            //print("yes")
        }
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
            if segue.identifier == "goToLocationView", let VC = segue.destination as? LocationTableViewController {
                VC.selectedTrip = selectedPath.row
            }
        
    }
    
}
