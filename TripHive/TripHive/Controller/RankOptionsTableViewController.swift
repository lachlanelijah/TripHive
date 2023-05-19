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
    var category: categoryType = .accommodation
    var numberOfPeople = 1
    var currentPerson = 1
    
    var delegate: RankOptionsDelegate?
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        if (currentPerson == numberOfPeople ) {
            dismiss(animated: true, completion: nil)
            //do the delegate prepare send data stuff
        } else if (currentPerson == numberOfPeople-1) {
            nextButton.title = "Done"
            currentPerson += 1
        } else {
            currentPerson += 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setEditing(!tableView.isEditing, animated: true)
        numberOfPeople = trips[selectedTrip].getNumberOfPeople()
        print("Trip: \(selectedTrip), Location: \(selectedLocation), category: \(category)")
        print(trips[selectedTrip].getNumberOfPeople())
        

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankOptionsCell", for: indexPath) as! RankOptionsTableViewCell
        if category == .accommodation {
            let name = trips[selectedTrip].locations[selectedLocation].categories[0].items[indexPath.row].itemName
//            print("Current number of items in the accom list is \(trips[selectedTrip].locations[selectedLocation].categories[0].getItemCount())")
//            print("Current index to find items from is \(indexPath.row)")
            let price = trips[selectedTrip].locations[selectedLocation].categories[0].items[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price)) per night"
            return cell
        } else {
            let name = trips[selectedTrip].locations[selectedLocation].categories[1].items[indexPath.row].itemName
//            print("Current number of items in the place list is \(trips[selectedTrip].locations[selectedLocation].categories[1].getItemCount())")
//            print("Current index to find items from is \(indexPath.row)")
            let price = trips[selectedTrip].locations[selectedLocation].categories[1].items[indexPath.row].itemPrice
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
        trips.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        //Allows the re-ordering of the table rows
    }
    

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
