//
//  RankOptionsTableViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 19/5/2023.
//

import UIKit

protocol RankOptionsDelegate {
    func passRankingInformation()
} //Delegate protocol that ItemTableViewController conforms to that allows AddAccommodationViewController to send information back

class RankOptionsTableViewController: UITableViewController {
    
    var selectedTrip = 0
    var selectedLocation = 0
    var category: categoryType = .accommodation // category will be overridden by input
    var categoryIndex = 0
    var numberOfPeople = 1
    var currentPerson = 1
    // var allItemRankings = [Item: [Int]]
    
    var theItems: [Item] = []
    var theItemsDefaultSort: [Item] = []
    
    var delegate: RankOptionsDelegate?
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        if (currentPerson == numberOfPeople ) {
            dismiss(animated: true, completion: nil)
            for i in 0..<theItems.count {
                var itemPointsTotal = 0
                for k in 0..<theItems[i].pointsFromEachPerson.count {
                    itemPointsTotal += theItems[i].pointsFromEachPerson[k]
                }
                print("The item \(theItems[i]) has \(itemPointsTotal) points total")
            }
            //do the delegate prepare send data stuff
        } else if (currentPerson == numberOfPeople-1) {
            nextButton.title = "Done"
            currentPerson += 1
        } else {
            currentPerson += 1
            theItems = theItemsDefaultSort
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setEditing(!tableView.isEditing, animated: true)
        numberOfPeople = trips[selectedTrip].getNumberOfPeople()
        print("Trip: \(selectedTrip), Location: \(selectedLocation), category: \(category)")
        print("\(trips[selectedTrip].getNumberOfPeople()) people in this trip")
        print(categoryIndex)
        
        theItems = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items
        theItemsDefaultSort = trips[selectedTrip].locations[selectedLocation].categories[categoryIndex].items

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
            return theItems.count
        } else {
            return theItems.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankOptionsCell", for: indexPath) as! RankOptionsTableViewCell
        if category == .accommodation {
            let name = theItems[indexPath.row].itemName
//            print("Current number of items in the accom list is \(trips[selectedTrip].locations[selectedLocation].categories[0].getItemCount())")
//            print("Current index to find items from is \(indexPath.row)")
            let price = theItems[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price)) per night"
            return cell
        } else {
            let name = theItems[indexPath.row].itemName
//            print("Current number of items in the place list is \(trips[selectedTrip].locations[selectedLocation].categories[1].getItemCount())")
//            print("Current index to find items from is \(indexPath.row)")
            let price = theItems[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price))"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            
                return .none

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

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        theItems.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        print("\(theItems[destinationIndexPath.row]) ")
        //Allows the re-ordering of the table rows
        var thisItemPoints = theItems.count - destinationIndexPath.row
        // 1st of 2 becomes 2 points, 2nd of 2 becomes 1 point
        var thePointsArray = theItems[destinationIndexPath.row].pointsFromEachPerson
        if currentPerson == 1 { // if there are ranks from a previous session
            if !thePointsArray.isEmpty {
                thePointsArray.removeAll()
            }
        }
        theItems[destinationIndexPath.row].pointsFromEachPerson.append(thisItemPoints)
    }
    // THE PROBLEM: If the cells aren't rearranged, they get no points
    // TO-DO: Append points to cells even if not dragged
    

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

}
