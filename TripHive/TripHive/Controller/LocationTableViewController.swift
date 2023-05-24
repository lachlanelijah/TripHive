//
//  LocationTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import UIKit

class LocationTableViewController: UITableViewController, LocationDelegate {
    
    func passLocationInformation(locationName: String) {
        addLocation(locationName: locationName)
    } //Function from LocationDelegate protocol that allows AddLocationViewController to send info back to LocationTableViewController
    
    func addLocation(locationName: String) {
        trips[selectedTrip].addLocation(locationName)
        self.tableView.reloadData()
    } //Adds a new location to the selected trip and reloads table data
    
    var selectedTrip: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        //Adds an edit button to the title bar
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips[selectedTrip].getLocationCount()
        //Sets the number of rows to the number of locations in the selected trip
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let text = trips[selectedTrip].locations[indexPath.row].locationName
        cell.textLabel!.text = text
        return cell
        //Sets each cell with the location's name
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let theLocationToMove = trips[selectedTrip].locations[sourceIndexPath.row]
        trips[selectedTrip].locations.remove(at: sourceIndexPath.row)
        trips[selectedTrip].locations.insert(theLocationToMove, at: destinationIndexPath.row)
        print(trips[selectedTrip].locations)
    }
    
//    @objc func addTapped() {
//        let ac = UIAlertController(title: "Add new location", message: nil, preferredStyle: .alert)
//        ac.addTextField { field in
//            field.placeholder = "Location name"
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
//            let name = ac.textFields![0].text
//            trips[self.selectedTrip].addLocation(name ?? "Location")
//            self.tableView.reloadData()
//        }
//
//        ac.addAction(cancelAction)
//        ac.addAction(submitAction)
//
//        present(ac, animated: true)
//    }

    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
                if tableView.isEditing {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
                }
                else {
                    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
                }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            let alert = UIAlertController(title: "Are you sure you want to delete this location?", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(
//                title: "Delete",
//                style: .destructive,
//                handler: { _ in
//                    tableView.deleteRows(at: [indexPath], with: .fade)
//                    trips[self.selectedIndex].removeLocation(index: indexPath.row)
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
//
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
//                trips[self.selectedIndex].removeLocation(index: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//            }
//
//            let swipeActions = UISwipeActionsConfiguration(actions: [delete])
//            return swipeActions
//    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
                //Handles trip deletion and confirmation
//                trips.remove(at: indexPath.row)
//                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            let alert = UIAlertController(title: "Are you sure you want to delete this location?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { _ in
                    trips[self.selectedTrip].removeLocation(index: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { _ in
                // cancel action
            }))
            self.present(alert,
                    animated: true,
                    completion: nil
            )
        }
        
        // Allows editing of trip details
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, completionHandler) in
            self!.performSegue(withIdentifier: "goToAddLocationView", sender: trips[indexPath.row]);
        }
        editAction.backgroundColor = .systemTeal
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, editAction])
        return swipeActions
        //Sets swipe actions (currently just cancel)
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddLocationViewController {
            destination.delegate = self
        }
        
        //If the user is adding a new location, set LocationTableViewController as a delegate. Else, send the index of the selected location and trip to CategoryViewController
        
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
            if
                segue.identifier == "goToCategoryView",
                let VC = segue.destination as? CategoryViewController
            {
                VC.selectedTrip = selectedTrip
                VC.selectedLocation = selectedPath.row
            }
    }

}
