//
//  AddLocationViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

protocol LocationDelegate {
    func passLocationInformation(locationName: String)
}

class AddLocationViewController: UIViewController {

    var delegate: LocationDelegate?
    
    @IBAction func locationLeaveDatePickerChanged(_ sender: UIDatePicker) {
        locationLeaveDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: locationArriveDatePicker.date)
    }
    @IBOutlet weak var locationLeaveDatePicker: UIDatePicker!
    @IBOutlet weak var locationArriveDatePicker: UIDatePicker!
    @IBAction func addLocationButton(_ sender: UIBarButtonItem) {
        if locationNameTextField.text == "" {
            let ac = UIAlertController(title: "Your location needs a name!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        } else {
            delegate?.passLocationInformation(locationName: locationNameTextField.text!)
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var locationNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationArriveDatePicker.minimumDate = Date()
        locationLeaveDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
    }
}
