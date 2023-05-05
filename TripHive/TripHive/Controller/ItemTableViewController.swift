//
//  ItemTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 5/5/2023.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var selectedTrip = 0
    var selectedLocation = 0
    var category: categoryType = .activities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if category == .accommodation {
            self.title = "Accommodation"
        } else {
            self.title = "Activities"
        }
        
        print("The selected location is index \(selectedLocation)")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if category == .accommodation {
            return trips[selectedTrip].locations[selectedLocation].categories[0].items.count
        } else {
            return trips[selectedTrip].locations[selectedLocation].categories[1].items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        if category == .accommodation {
            let name = trips[selectedTrip].locations[selectedLocation].categories[0].items[indexPath.row].itemName
            print("Current number of items in the accom list is \(trips[selectedTrip].locations[selectedLocation].categories[0].getItemCount())")
            print("Current index to find items from is \(indexPath.row)")
            let price = trips[selectedTrip].locations[selectedLocation].categories[0].items[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price)) per night"
            return cell
        } else {
            let name = trips[selectedTrip].locations[selectedLocation].categories[1].items[indexPath.row].itemName
            print("Current number of items in the place list is \(trips[selectedTrip].locations[selectedLocation].categories[1].getItemCount())")
            print("Current index to find items from is \(indexPath.row)")
            let price = trips[selectedTrip].locations[selectedLocation].categories[1].items[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price))"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            trips.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    @objc func addTapped() {
        if category == .accommodation {
            let ac = UIAlertController(title: "Add new accommodation option", message: nil, preferredStyle: .alert)
            ac.addTextField { field in
                field.placeholder = "Name of accommodation"
            }
            
            ac.addTextField { field in
                field.placeholder = "Price"
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                var name = "Accommodation"
                if ac.textFields![0].text != "" {
                    name = ac.textFields![0].text!
                }
                let price = ac.textFields![1].text
                trips[self.selectedTrip].locations[self.selectedLocation].categories[0].items.append(Item(itemName: name , itemPrice: Int(price!) ?? 0))
                self.tableView.reloadData()
                
            }
            ac.addAction(cancelAction)
            ac.addAction(submitAction)

            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Add new place", message: nil, preferredStyle: .alert)
            ac.addTextField { field in
                field.placeholder = "Name of place"
            }
            
            ac.addTextField { field in
                field.placeholder = "Price"
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                var name = "Place"
                if ac.textFields![0].text != "" {
                    name = ac.textFields![0].text!
                }
                let price = ac.textFields![1].text
                trips[self.selectedTrip].locations[self.selectedLocation].categories[1].items.append(Item(itemName: name, itemPrice: Int(price!) ?? 0))
                self.tableView.reloadData()
                
            }
            ac.addAction(cancelAction)
            ac.addAction(submitAction)

            present(ac, animated: true)
        }
        
    }

    @objc func editTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
            if tableView.isEditing {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editTapped))
            }
            else {
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
            }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if category == .accommodation {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let alert = UIAlertController(title: "Are you sure you want to delete this accommodation option?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { _ in
                    trips[self.selectedTrip].locations[self.selectedLocation].categories[0].removeItem(index: indexPath.row)
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

            let swipeActions = UISwipeActionsConfiguration(actions: [delete])
            return swipeActions
        } else {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let alert = UIAlertController(title: "Are you sure you want to delete this place?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { _ in
                    trips[self.selectedTrip].locations[self.selectedLocation].categories[1].removeItem(index: indexPath.row)
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

            let swipeActions = UISwipeActionsConfiguration(actions: [delete])
            return swipeActions
        }
            
    }

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
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
            if
                segue.identifier == "goToDetailView",
                let VC = segue.destination as? DetailTableViewController
            {
                VC.selectedTrip = selectedTrip
                VC.category = category
                VC.selectedLocation = selectedLocation
                VC.selectedItem = selectedPath.row
            }
    }

}
