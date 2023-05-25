//
//  AddTripViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

// Delegate protocol that TripTableViewController conforms to that allows AddTripViewController to send information back
protocol TripDelegate {
    func addTrip(trip: Trip);
    func updateTrip();
}

class AddTripViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Delegates
    var delegate: TripDelegate?
    
    // The trip being added/edited
    var trip: Trip?;
    
    // var to indicate whether an add or edit action is being performed
    // (set via parent controller)
    var tripEditing = false;
    
    // Picker data
    // Whenever these values are set, automatically update the actual Trip object's properties
    var selectedPeople = 0 {
        didSet {
            trip?.setNumberOfPeople(peoplePickerData[selectedPeople])
        }
    }
    var selectedYear = 0 {
        didSet {
            trip?.setTripYear(yearPickerData[selectedYear])
        }
    }
    var peoplePickerData: [Int] = []
    var yearPickerData: [Int] = []
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tripActionLabel: UINavigationItem!
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var peoplePicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var tripActionButton: UIBarButtonItem!
    
    // Perform intial setup depending on whether this is an "Add" or "Edit" action
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //Allows keyboard to be dismissed by tapping outside of it
        
        self.peoplePicker.delegate = self
        self.peoplePicker.dataSource = self
        
        self.yearPicker.delegate = self
        self.yearPicker.dataSource = self
        
        for person in 1...20 {
            peoplePickerData.append(person)
        }
        
        for year in 2023...2030 {
            yearPickerData.append(year)
        }
        
        // If editing, set the original trip name, people count and year
        if (tripEditing && trip != nil) {
            // Set the values
            selectedPeople = peoplePickerData.firstIndex(of: trip!.getNumberOfPeople()) ?? 0;
            selectedYear = yearPickerData.firstIndex(of: trip!.getTripYear()) ?? 0
            
            // Set the UI
            tripActionLabel.title = "Edit Trip";
            tripNameTextField.text = trip?.tripName;
            tripActionButton.title = "Confirm"
            peoplePicker.selectRow(selectedPeople, inComponent: 0, animated: false)
            yearPicker.selectRow(selectedYear, inComponent: 0, animated: false);
        } else {
            // Create an empty trip
            trip = Trip(people: peoplePickerData[0], name: "", year: yearPickerData[0])
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Handler functions for when a picker value is selected
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == peoplePicker {
            return peoplePickerData.count
        } else {
            return yearPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == peoplePicker {
            return String(peoplePickerData[row])
        } else {
            return String(yearPickerData[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == peoplePicker {
            selectedPeople = row
        } else {
            selectedYear = row
        }
    }
    
    // Actions
    
    @IBAction func onTripNameChange() {
        trip?.setTripName(tripNameTextField.text ?? "")
    }
    
    // Validate user input before creating a trip
    @IBAction func performTripAction(_ sender: UIBarButtonItem) {
        if ((trip?.isValid()) != nil) {
            // Trip is valid - save trip and dismiss this screen
            if (tripEditing) {
                delegate?.updateTrip();
            } else {
                delegate?.addTrip(trip: trip!);
            }
            dismiss(animated: true, completion: nil)
        } else {
            // Trip is invalid - show error dialogue
            let ac = UIAlertController(title: "Your trip needs a name!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        }
    }
    
    @objc func dismissKeyboard() {
        //allows the user to dismiss the keyboard by tapping outside of it
        view.endEditing(true)
    }
    
    // Dismiss the error dialogue
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
