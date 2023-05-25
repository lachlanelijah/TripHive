//
//  LocationTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import UIKit

class LocationTableViewController: UITableViewController, LocationDelegate {
    
    // Store the index of the selected Trip
    var selectedTripIndex: Int = 0
    
    // Store the Locations of the Trip
    var locations: [Location] = [];
    
    // Perform initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // navigationItem.largeTitleDisplayMode = .never
        
        //Adds an edit button to the title bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        
        // Set the locations at class level
        locations = trips[selectedTripIndex].locations;
    }
    
    // Delegate functions
    
    // Add a Location
    func addLocation(location: Location) {
        locations.append(location);
        setTripLocations();
        self.tableView.reloadData()
    }
    
    // Update a Location's details (performed in AddLocationViewController)
    func updateLocation() {
        setTripLocations();
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Sets the number of rows to the number of locations in the selected trip
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count;
    }
    
    // Handles going to the Edit Location or Category View page
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.isEditing) {
            performSegue(withIdentifier: "goToAddLocationView", sender: locations[indexPath.row]);
        }
    }
    
    // Sets each cell with the location's name
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let text = locations[indexPath.row].locationName
        cell.textLabel!.text = text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        locations.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        setTripLocations();
    }
    
    // Go into, or exit editing mode
    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true);
        tableView.allowsSelectionDuringEditing = true;
        if tableView.isEditing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
        }
        else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Allow deletion of Trip Locations
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let alert = UIAlertController(title: "Are you sure you want to delete this location?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { _ in
                    self.locations.remove(at: indexPath.row);
                    self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic);
                    self.setTripLocations();
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
        
        // Allows editing of location details
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            self.performSegue(withIdentifier: "goToAddLocationView", sender: self.locations[indexPath.row]);
        }
        edit.backgroundColor = .systemMint
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeActions
    }

    // Helper function which updates the parent object Trip with any changes made to locations
    private func setTripLocations() {
        trips[selectedTripIndex].setLocations(locations: locations);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddLocationViewController {
            destination.delegate = self
            // If sender is a Location object, we are moving to "destination" to edit a Location item
            if (sender as? Location != nil) {
                destination.locationEditing = true;
                destination.location = sender as? Location;
            }
        }
        
        //If the user is adding a new location, set LocationTableViewController as a delegate. Else, send the index of the selected location and trip to CategoryViewController
        
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "goToCategoryView",
           let VC = segue.destination as? CategoryViewController
        {
            VC.selectedTrip = selectedTripIndex
            VC.selectedLocation = selectedPath.row
        }
    }
    
}
