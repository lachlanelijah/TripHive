//
//  AddTripViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

protocol TripDelegate {
    func passTripInformation(tripName: String, tripPeople: Int)
}

class AddTripViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    var delegate: TripDelegate?
    var delegate: TripDelegate?
    
    var selectedPeople = 0
    var selectedYear = 0
    var peoplePickerData: [Int] = []
    var yearPickerData: [Int] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
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
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func addTripButton(_ sender: UIBarButtonItem) {
        if tripNameTextField.text == "" {
            let ac = UIAlertController(title: "Your trip needs a name!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        } else {
            delegate?.passTripInformation(tripName: "\(tripNameTextField.text!) \(yearPickerData[selectedYear])", tripPeople: peoplePickerData[selectedPeople])
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tripNameTextField: UITextField!
    
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var peoplePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
}
