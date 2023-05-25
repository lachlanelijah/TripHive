//
//  ItemTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 5/5/2023.
//

import UIKit

class ItemTableViewController: UITableViewController, AccommodationDelegate, ActivityDelegate, RankOptionsDelegate {
    func fetchRankingInformation(rankedItems: [Item]) {
        resetMenuLabels()
        print(rankedItems)
        for k in 0..<trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items.count {
            trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items[k] = rankedItems[k]
        }
        theItems = rankedItems
        sortBy = "RD"
        sortedItems = sortItems()
        print("Success")
        print(sortedItems)
        tableView.reloadData()
        overflowMenu.barButtonItems[1].title = "\u{2713} Sort by Rank \u{2193}"
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
        theItems = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
        self.tableView.reloadData()
    } //Adds a new accommodation option to the selected location and reloads table data
    
    func addActivity(activityName: String, activityPrice: Int) {
        trips[self.selectedTrip].locations[self.selectedLocation].categories[1].items.append(Item(itemName: activityName , itemPrice: activityPrice))
        theItems = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
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
    
    @IBAction func sortByRankTapped(_ sender: UIBarButtonItem) {
        resetMenuLabels()
        updateLocalItems()
        
        // if theItems[0].totalPoints == 0
        
        if sortBy != "RD" {
            sortBy = "RD"
            overflowMenu.barButtonItems[1].title = "\u{2713} Sort by Rank \u{2193}"
        } else {
            sortBy = "RA"
            overflowMenu.barButtonItems[1].title = "\u{2713} Sort by Rank \u{2191}"
        }
        sortedItems = sortItems()
        tableView.reloadData()
    }
    @IBAction func sortByShortlistTapped(_ sender: UIBarButtonItem) {
        resetMenuLabels()
        updateLocalItems()
        
        if sortBy != "SD" {
            sortBy = "SD"
            overflowMenu.barButtonItems[2].title = "\u{2713} Sort by Shorlist \u{2193}"
        } else {
            sortBy = "SA"
            overflowMenu.barButtonItems[2].title = "\u{2713} Sort by Shortlist \u{2191}"
        }
        sortedItems = sortItems()
        tableView.reloadData()
    }
    @IBAction func sortByPriceTapped(_ sender: UIBarButtonItem) {
        resetMenuLabels()
        updateLocalItems()
        
        if sortBy != "PA" {
            sortBy = "PA"
            overflowMenu.barButtonItems[3].title = "\u{2713} Sort by Price \u{2191}"
        } else {
            sortBy = "PD"
            overflowMenu.barButtonItems[3].title = "\u{2713} Sort by Price \u{2193}"
        }
        sortedItems = sortItems()
        tableView.reloadData()
    }
    @IBAction func sortByNameTapped(_ sender: UIBarButtonItem) {
        resetMenuLabels()
        updateLocalItems()
        
        if sortBy != "NA" {
            sortBy = "NA"
            overflowMenu.barButtonItems[4].title = "\u{2713} Sort by Name \u{2191}"
        } else {
            sortBy = "ND"
            overflowMenu.barButtonItems[4].title = "\u{2713} Sort by Name \u{2193}"
        }
        sortedItems = sortItems()
        tableView.reloadData()
    }
    
    @IBAction func sortDefaultTapped(_ sender: UIBarButtonItem) {
        resetMenuLabels()
        sortBy = "def"
        overflowMenu.barButtonItems[5].title = "\u{2713} Unlock Sort Order"
        trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items = theItems
    }
    @IBAction func shareTapped(_ sender: UIBarButtonItem) {
        let shareSheet = UIActivityViewController(activityItems: [exportAsText() as NSString], applicationActivities: nil)
            present(shareSheet, animated: true, completion: {})
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
    
    var theItems: [Item] = []
    var sortedItems: [Item] = []
    
    var sortingByRank = "n"
    var sortingByShortlist = "n"
    var sortingByPrice = "n"
    var sortingByName = "n"
    
    var sortBy = "def"
    
    func sortItems() -> [Item] {
        switch sortBy {
        case "RA":
            return theItems.sorted { $0.totalPoints < $1.totalPoints }
        case "RD":
            return theItems.sorted { $0.totalPoints > $1.totalPoints }
        case "SA":
            return theItems.sorted { $0.shortlisted < $1.shortlisted }
        case "SD":
            return theItems.sorted { $0.shortlisted > $1.shortlisted }
        case "PA":
            return theItems.sorted { $0.itemPrice < $1.itemPrice }
        case "PD":
            return theItems.sorted { $0.itemPrice > $1.itemPrice }
        case "NA":
            return theItems.sorted { $0.itemName < $1.itemName }
        case "ND":
            return theItems.sorted { $0.itemName > $1.itemName }
        default:
            return theItems
        }
    }
    
    func updateGlobalItems() {
        for i in 0..<trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items.count {
            trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items[i] = theItems[i]
        }
    }
    
    func updateLocalItems() {
        for k in 0..<trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items.count {
            theItems[k] = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items[k]
        }
    }
    
    func resetMenuLabels() {
        let menuLabels = ["Rank Options...", "Sort by Rank", "Sort by Shortlist", "Sort by Price", "Sort by Name", "Unlock Sort Order", "Share Sorted List..."]
        
        for k in 0..<overflowMenu.barButtonItems.count {
            overflowMenu.barButtonItems[k].title = menuLabels[k]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
//        let editButton = editButtonItem
//        let topRightButtons = [addNewItemButton!, editButton]
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
//        navigationItem.rightBarButtonItems = topRightButtons
        
//        if sortingByRank == "a" {
//            overflowMenu.barButtonItems[1].title = "\u{2713} Sort by Rank \u{2191}"
//        }
        
        sortBy = "def"
        overflowMenu.barButtonItems[5].title = "\u{2713} Unlock Sort Order"
        
        if category == .accommodation {
            self.title = "Accommodation"
        } else {
            self.title = "Activities"
        }
        
        print("Category: \(categoryIndex)")
        
        theItems = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
        
        print("Items default sort: \(theItems)")
        //Depending on the selected category, change the nav bar title
        
        //print("The selected location is index \(selectedLocation)")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))

    }
    
    func exportAsText() -> String {
        var theString = ""
        if !sortedItems.isEmpty {
            for i in 0..<sortedItems.count {
                let name = sortedItems[i].itemName
                let price = ", $\(sortedItems[i].itemPrice)"
                // let rankPlace = "Ranked #\(i+1)"
                var shortlisted = ""
                if sortedItems[i].shortlisted == 1 {
                    shortlisted = "\u{272a} Shortlisted"
                }
                theString.append(name)
                theString.append(price)
            }
        } else {
            for i in 0..<theItems.count {
                let name = theItems[i].itemName
                let price = ", $\(theItems[i].itemPrice)"
                // let rankPlace = "Ranked #\(i+1)"
                var shortlisted = ""
                if theItems[i].shortlisted == 1 {
                    shortlisted = "\u{272a} Shortlisted"
                }
                theString.append(name)
                theString.append(price)
                theString.append("\n")
            }
        }
        return theString
    }

//    func sortByRank(array: [Item]) {
//        print(sortedItems)
//        sortedItems = array.sorted {
//            $0.totalPoints > $1.totalPoints
//        }
//        print(sortedItems)
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        if sortBy != "def" && !sortedItems.isEmpty {
            var beforePriceText = ""
            if sortedItems[indexPath.row].shortlisted == 1 {
                beforePriceText = "\u{272a} "
            }
            var afterPriceText = ""
            if sortedItems[indexPath.row].totalPoints > 0 {
                if sortBy == "RD" {
                    afterPriceText = " \u{2022} Ranked #\(indexPath.row + 1)"
                } else if sortBy == "RA" {
                    afterPriceText = " \u{2022} Ranked #\(sortedItems.count - indexPath.row)"
                }
            }
            let name = sortedItems[indexPath.row].itemName
            let price = sortedItems[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            
            if category == .accommodation {
                cell.itemCostLabel!.text = "\(beforePriceText)$\(String(price)) per night\(afterPriceText)"
                return cell
            } else {
                cell.itemCostLabel!.text = "\(beforePriceText)$\(String(price))\(afterPriceText)"
                return cell
            }
        }
        
        var beforePriceText = ""
        if theItems[indexPath.row].shortlisted == 1 {
            beforePriceText = "\u{272a} "
        }
        var afterPriceText = ""
        if theItems[indexPath.row].totalPoints > 0 {
            if sortBy == "RD" {
                afterPriceText = " \u{2022} Ranked #\(indexPath.row + 1)"
            } else if sortBy == "RA" {
                afterPriceText = " \u{2022} Ranked #\(theItems.count - indexPath.row)"
            }
        }
        
        let name = theItems[indexPath.row].itemName
        let price = theItems[indexPath.row].itemPrice
        cell.itemNameLabel!.text = name
        
        if category == .accommodation {
            cell.itemCostLabel!.text = "\(beforePriceText)$\(String(price)) per night\(afterPriceText)"
            return cell
        } else {
            cell.itemCostLabel!.text = "\(beforePriceText)$\(String(price))\(afterPriceText)"
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let theItemToMove = theItems[sourceIndexPath.row]
        theItems.remove(at: sourceIndexPath.row)
        theItems.insert(theItemToMove, at: destinationIndexPath.row)
        overflowMenu.barButtonItems[5].title = "\u{2713} Unlock Sort Order"
        print(theItems)
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
        sortBy = "def"
        resetMenuLabels()
        overflowMenu.barButtonItems[5].title = "\u{2713} Unlock Sort Order"
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
            let alert = UIAlertController(title: "Are you sure you want to delete this activity?", message: nil, preferredStyle: .alert)
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
     */
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let theItemToMove = theItemsDefaultSort[sourceIndexPath.row]
//        theItemsDefaultSort.remove(at: sourceIndexPath.row)
//        theItemsDefaultSort.insert(theItemToMove, at: destinationIndexPath.row)
//        // print("\(theItems[destinationIndexPath.row]) ")
//        print(theItemsDefaultSort)
//        tableView.reloadData()
//    }
    

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
        
        if let destination = segue.destination as? RankOptionsViewController {
            destination.delegate = self
        }
        
        if
            segue.identifier == "goToRankOptionsView",
            let tableVC = segue.destination as? RankOptionsViewController
        {
//            let tableVC = VC.viewControllers.first as! RankOptionsTableViewController
            tableVC.selectedTrip = selectedTrip
            tableVC.category = category
            tableVC.categoryIndex = categoryIndex
            tableVC.selectedLocation = selectedLocation
//            theItemsDefaultSort = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
            print(theItems)
            tableVC.theItemsDefaultSort = theItems
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
