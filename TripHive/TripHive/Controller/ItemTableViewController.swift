//
//  ItemTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 5/5/2023.
//

import UIKit

class ItemTableViewController: UITableViewController, AccommodationDelegate, ActivityDelegate, RankOptionsDelegate {
    func fetchRankingInformation(nowRanked: [Item]) {
        print(nowRanked)
        sortByRank(array: nowRanked)
        
        //maybe create a function to rearrange items
        //rearrange items in the array based on ranking points determined by RankOptionsTableViewController
        //reload the table
    }
    
    func passAccommodationInformation(accommodationName: String, accommodationPrice: Int) {
        addAccommodation(accommodationName: accommodationName, accommodationPrice: accommodationPrice)
    } //Function from AccommodationDelegate protocol that allows AddAccommodationViewController to send info back to ItemTableViewController
    
    func passActivityInformation(activityName: String, activityPrice: Int) {
        addActivity(activityName: activityName, activityPrice: activityPrice)
    } //Function from ActivityDelegate protocol that allows AddActivityViewController to send info back to ItemTableViewController
    
    func addAccommodation(accommodationName: String, accommodationPrice: Int) {
        trips[self.selectedTrip].locations[self.selectedLocation].categories[0].items.append(Item(itemName: accommodationName , itemPrice: accommodationPrice))
        theItemsDefaultSort = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
        self.tableView.reloadData()
    } //Adds a new accommodation option to the selected location and reloads table data
    
    func addActivity(activityName: String, activityPrice: Int) {
        trips[self.selectedTrip].locations[self.selectedLocation].categories[1].items.append(Item(itemName: activityName , itemPrice: activityPrice))
        theItemsDefaultSort = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
        self.tableView.reloadData()
    } //Adds a new activity to the selected location and reloads table data
    
    
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        //Depending on the category selected in the previous screen, load either the screen for adding accommodation or an activity
        if category == .accommodation {
            performSegue(withIdentifier: "goToAccommodationView", sender: nil)
        } else {
            performSegue(withIdentifier: "goToActivityView", sender: nil)
        }
        
    }
    
    
    @IBOutlet weak var overflowMenu: UIBarButtonItemGroup!
    @IBOutlet weak var addNewItemButton: UIBarButtonItem!
    @IBOutlet weak var rankOptionsButton: UIBarButtonItem!
    
    @IBAction func rankOptionsTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToRankOptions", sender: nil)
    }
    
    func goToRankOptions(status: Bool) {
        
    }
    
    var selectedTrip = 0
    var selectedLocation = 0
    var category: categoryType = .activities // will be overridden
    var categoryIndex = 0
    
    var theItemsDefaultSort: [Item] = []
    var theItemsRanked: [Item] = []
    var sortingByRank = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
        let editButton = editButtonItem
        let topRightButtons = [addNewItemButton!, editButton]
        navigationItem.rightBarButtonItems = topRightButtons
        
        if category == .accommodation {
            self.title = "Accommodation"
        } else {
            self.title = "Activities"
        }
        
        print("Category: \(categoryIndex)")
        
        theItemsDefaultSort = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
        //Depending on the selected category, change the nav bar title
        
        //print("The selected location is index \(selectedLocation)")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))

    }

    func sortByRank(array: [Item]) {
        print(theItemsRanked)
        theItemsRanked = array.sorted {
            $0.totalPoints > $1.totalPoints
        }
        print(theItemsRanked)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if category == .accommodation {
            return theItemsDefaultSort.count
        } else {
            return theItemsRanked.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        if sortingByRank {
            let name = theItemsRanked[indexPath.row].itemName
            let price = theItemsRanked[indexPath.row].itemPrice
        }
        
        let name = theItemsDefaultSort[indexPath.row].itemName
        let price = theItemsDefaultSort[indexPath.row].itemPrice
        cell.itemNameLabel!.text = name
        
        if category == .accommodation {
            cell.itemCostLabel!.text = "$\(String(price)) per night"
            return cell
        } else {
            cell.itemCostLabel!.text = "$\(String(price))"
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let theItemToMove = theItemsDefaultSort[sourceIndexPath.row]
        theItemsDefaultSort.remove(at: sourceIndexPath.row)
        theItemsDefaultSort.insert(theItemToMove, at: destinationIndexPath.row)
        print(theItemsDefaultSort)
    }
    
//    @objc func addTapped() {
//        if category == .accommodation {
//            let ac = UIAlertController(title: "Add new accommodation option", message: nil, preferredStyle: .alert)
//            ac.addTextField { field in
//                field.placeholder = "Name of accommodation"
//            }
//
//            ac.addTextField { field in
//                field.placeholder = "Price"
//            }
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
//                var name = "Accommodation"
//                if ac.textFields![0].text != "" {
//                    name = ac.textFields![0].text!
//                }
//                let price = ac.textFields![1].text
//                trips[self.selectedTrip].locations[self.selectedLocation].categories[0].items.append(Item(itemName: name , itemPrice: Int(price!) ?? 0))
//                self.tableView.reloadData()
//
//            }
//            ac.addAction(cancelAction)
//            ac.addAction(submitAction)
//
//            present(ac, animated: true)
//        } else {
//            let ac = UIAlertController(title: "Add new place", message: nil, preferredStyle: .alert)
//            ac.addTextField { field in
//                field.placeholder = "Name of place"
//            }
//
//            ac.addTextField { field in
//                field.placeholder = "Price"
//            }
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
//                var name = "Place"
//                if ac.textFields![0].text != "" {
//                    name = ac.textFields![0].text!
//                }
//                let price = ac.textFields![1].text
//                trips[self.selectedTrip].locations[self.selectedLocation].categories[1].items.append(Item(itemName: name, itemPrice: Int(price!) ?? 0))
//                self.tableView.reloadData()
//
//            }
//            ac.addAction(cancelAction)
//            ac.addAction(submitAction)
//
//            present(ac, animated: true)
//        }
//
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
        
        if let destination = segue.destination as? AddActivityViewController {
            destination.delegate = self
        }
        
        if let destination = segue.destination as? AddAccommodationViewController {
            destination.delegate = self
        }
        
        if let destination = segue.destination as? RankOptionsTableViewController {
            destination.delegate = self
        }
        
        if
            segue.identifier == "goToRankOptionsView",
            let VC = segue.destination as? UINavigationController
        {
            let tableVC = VC.viewControllers.first as! RankOptionsTableViewController
            tableVC.selectedTrip = selectedTrip
            tableVC.category = category
            tableVC.categoryIndex = categoryIndex
            tableVC.selectedLocation = selectedLocation
//            theItemsDefaultSort = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
            print(theItemsDefaultSort)
            tableVC.theItemsDefaultSort = theItemsDefaultSort
        }
        
        
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
