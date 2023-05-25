//
//  AddLocationViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

// Delegate protocol that LocationTableViewController conforms to that allows AddLocationViewController to send information back
protocol LocationDelegate {
    func passLocationName(locationName: String)
    func updateLocation(locationName: String, selectedLocationIndex: Int)
}

class AddLocationViewController: UIViewController {
    
    // Delegates
    var delegate: LocationDelegate?
    
    var location: Location?
    
    var selectedIndex = 0
    
    // var to indicate whether an add or edit action is being performed
    // (set via parent controller)
    var locationEditing = false;
    
    // Outlets
    @IBOutlet weak var locationActionLabel: UINavigationItem!
    @IBOutlet weak var locationActionButton: UIBarButtonItem!
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var locationArrivalDatePicker: UIDatePicker!
    @IBOutlet weak var locationDepartureDatePicker: UIDatePicker!
    
    // Perform intial setup depending on whether this is an "Add" or "Edit" action
    override func viewDidLoad() {
        super.viewDidLoad()
        // Sets the minimum date of location arrival to today's date, and location departure to the day after
        locationArrivalDatePicker.minimumDate = Date()
        locationDepartureDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        // If editing, set the original Location data
        if (locationEditing && location != nil) {
            locationActionLabel.title = "Edit Location";
            locationActionButton.title = "Confirm";
            locationNameTextField.text = location?.locationName;
        } else {
            // Else when adding, create a default Location object
//            location = Location(from: <#Decoder#>);
        }
        
//        locationArrivalDatePicker.date = location!.arrivalDate;
//        locationDepartureDatePicker.date = location!.departureDate;
    }
    
    
    // Action handlers
    
    // Set the Location name
    @IBAction func locationNameChanged() {
        location?.locationName = locationNameTextField.text ?? "";
    }
    
    // Set the arrival date
//    @IBAction func arrivalDateChanged(_ sender: UIDatePicker) {
//                location?.arrivalDate = locationArrivalDatePicker.date;
//        locationDepartureDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: locationArrivalDatePicker.date)
//    }
//
//    // Set the departure date
//    @IBAction func departureDateChanged(_ sender: UIDatePicker) {
//        location?.departureDate = locationDepartureDatePicker.date;
//    }
    
    // Add or Update the Location
    @IBAction func addLocationButtonClicked(_ sender: UIBarButtonItem) {
        if (locationNameTextField != nil) {
            // Location is valid - Add or Update
            if (locationEditing) {
                delegate?.updateLocation(locationName: locationNameTextField.text!, selectedLocationIndex: selectedIndex);
            } else {
                delegate?.passLocationName(locationName: locationNameTextField.text!)
            }
            dismiss(animated: true, completion: nil)
        } else {
            // Location is invalid - Show error prompt
            let ac = UIAlertController(title: "Your location needs a name!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        }
    }
    
    // Dismiss error prompt
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
