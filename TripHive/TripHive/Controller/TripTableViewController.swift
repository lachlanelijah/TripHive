//
//  TripTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import UIKit

// Store all the trips in the application
// TODO: this should probably be placed inside the class
var trips: [Trip] = []

class TripTableViewController: UITableViewController, TripDelegate, UINavigationControllerDelegate {
    // Set up the initial state of the home screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config = config.applying(UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30)))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        trips.append(Trip(people: 2, name: "Japan", year: 2024, icon: UIImage(systemName: "airplane.arrival", withConfiguration: config)!))
        trips.append(Trip(people: 3, name: "Korea", year: 2025, icon: UIImage(systemName: "airplane.arrival", withConfiguration: config)!))
        
        navigationController?.navigationBar.prefersLargeTitles = true //sets a large title style for the nav controller
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        //adds an 'Edit' button in the nav bar
    }
    
    // Delegate protocol functions
    func addTrip(trip: Trip) {
        trips.append(trip);
        self.tableView.reloadData()
    }
    
    func updateTrip() {
        // Trip already updated in child view. Refresh this (parent) view
        self.tableView.reloadData()
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
        cell.peopleNumberLabel.text = "People: \(trip.getNumberOfPeople()) | Year: \(trip.tripYear)"
        return cell
        //sets the custom elements of the trip cell to the relevant info housed in the array at that particular index
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.isEditing) {
            performSegue(withIdentifier: "goToAddTripView", sender: trips[indexPath.row]);
        } else {
            self.performSegue(withIdentifier: "goToLocationView", sender: self)
        }
        //when a cell is tapped, go to the next view
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
        //Allows the re-ordering of the table rows
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Allows for the deleting of rows
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
        
        // Allows editing of trip details
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self!.performSegue(withIdentifier: "goToAddTripView", sender: trips[indexPath.row]);
        }
        editAction.backgroundColor = .systemMint
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, editAction])
        return swipeActions
    }
    
    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        tableView.allowsSelectionDuringEditing = true;
        
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
    }
    
    @IBAction func goToAddTripViewButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddTripView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddTripViewController {
            destination.delegate = self
            if (sender as? Trip != nil) {
                destination.tripEditing = true;
                destination.trip = sender as? Trip;
            }
        }
        //If the user is adding a new trip, set TripTableViewController as a delegate. Else, send the index of the selected trip to LocationTableViewController
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "goToLocationView", let VC = segue.destination as? LocationTableViewController {
            VC.selectedTrip = selectedPath.row
        }
        
    }
    
}
