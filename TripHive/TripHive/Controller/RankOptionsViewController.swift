//
//  RankOptionsViewController.swift
//  TripHive
//
//  Created by William Thomas Hartono on 18/5/2023.
//
import UIKit

protocol RankOptionsDelegate {
    func fetchRankingInformation(nowRanked: [Item])
} //Delegate protocol that ItemTableViewController conforms to that allows AddAccommodationViewController to send information back

class RankOptionsViewController: UIViewController { // ,delegates
    
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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var rankOptionsNavigationBarTitle: UINavigationItem!
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        commitPoints()
        
        if currentPerson == numberOfPeople { // if this is the last person
            totalUpAllPoints()
            for i in 0..<theItems.count { // iterate through items array
                print("The item \(theItems[i]) has \(theItems[i].totalPoints) points total")
            }
            print(theItems)
            print("Done ranking")
            delegate?.fetchRankingInformation(nowRanked: theItems)
            //Passes the name of the new activity option into the delegate (sending it to ItemTableViewController) and dismisses AddActivityViewController
            dismiss(animated: true, completion: nil)
        } else { // if this is NOT the last person
            // theItems = theItemsDefaultSort
            // William intended to reset the item sort order to default for the next person
            // BUT the above code would also clear all points in the array. so it's dormant for now
            
            currentPerson += 1
            print(currentPerson)
            rankOptionsNavigationBarTitle.title = "Rank Items (Person \(currentPerson)/\(numberOfPeople))"
            tableView.reloadData()
            if currentPerson == numberOfPeople {
                nextButton.title = "Done \u{2713}"
            }
        }
    }
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        
        tableView.setEditing(!tableView.isEditing, animated: true)
        numberOfPeople = trips[selectedTrip].getNumberOfPeople()
        print("Trip: \(selectedTrip), Location: \(selectedLocation), category: \(category)")
        print("\(trips[selectedTrip].getNumberOfPeople()) people in this trip")
        theItems = theItemsDefaultSort
        rankOptionsNavigationBarTitle.title = "Rank Items (Person \(currentPerson)/\(numberOfPeople))"
    }
    
    func commitPoints() {
        if tableView != nil {
            let rowCount = tableView.numberOfRows(inSection: 0)
            
            for k in 0..<rowCount {
                let theIndexPath = IndexPath(row: k, section: 0)
                let theItemCell = tableView.cellForRow(at: theIndexPath) as! RankOptionsTableViewCell
                print(theIndexPath[0])
                var thisItemPoints = theItems.count - k
                
                // 1st of 2 becomes 2 points, 2nd of 2 becomes 1 poin
                var thePointsArray = theItems[k].pointsFromEachPerson
                if currentPerson == 1 { // if there are ranks from a previous session
                    thePointsArray.removeAll()
                    
                    //                    if !thePointsArray.isEmpty {
                    //                        thePointsArray.removeAll()
                    //                    }
                    print("Cleared values")
                }
                theItems[k].pointsFromEachPerson.append(thisItemPoints)
                // print(thisItemPoints)
            }
            print(theItems)
        }
    }
    
    func totalUpAllPoints() {
        for k in 0..<theItems.count {
            var totalPoints = 0
            for pts in theItems[k].pointsFromEachPerson {
                totalPoints += pts
            }
            theItems[k].totalPoints = totalPoints
        }
    }
}

    // MARK: - Table view data source

extension RankOptionsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if category == .accommodation {
            return theItems.count
        } else {
            return theItems.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankOptionsCell", for: indexPath) as! RankOptionsTableViewCell
        if category == .accommodation {
            print("checking")
            let name = theItems[indexPath.row].itemName
            // print(theItems)
//            print("Current index to find items from is \(indexPath.row)")
            let price = theItems[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price)) per night"
            let rankNumber = indexPath.row + 1
            cell.rankLabel?.text = "#\(rankNumber)"
            return cell
        } else {
            let name = theItems[indexPath.row].itemName
            // print(theItems)
//            print("Current number of items in the place list is \(trips[selectedTrip].locations[selectedLocation].categories[1].getItemCount())")
//            print("Current index to find items from is \(indexPath.row)")
            let price = theItems[indexPath.row].itemPrice
            cell.itemNameLabel!.text = name
            cell.itemCostLabel!.text = "$\(String(price))"
            let rankNumber = indexPath.row + 1
            cell.rankLabel?.text = "#\(rankNumber)"
            return cell
        }
    }
}

extension RankOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
                return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let theItemToMove = theItems[sourceIndexPath.row]
        theItems.remove(at: sourceIndexPath.row)
        theItems.insert(theItemToMove, at: destinationIndexPath.row)
        // print("\(theItems[destinationIndexPath.row]) ")
        print(theItems)
        tableView.reloadData()
    }
}
