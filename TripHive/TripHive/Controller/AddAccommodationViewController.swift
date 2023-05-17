//
//  AddAccommodationViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

protocol AccommodationDelegate {
    func passAccommodationInformation(accommodationName: String, accommodationPrice: Int)
} //Delegate protocol that ItemTableViewController conforms to that allows AddAccommodationViewController to send information back

class AddAccommodationViewController: UIViewController {
    
    @IBAction func addAccommodationButton(_ sender: UIBarButtonItem) {
        if accommodationNameTextField.text == "" {
            let ac = UIAlertController(title: "Your accommodation needs a name!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        } else {
            delegate?.passAccommodationInformation(accommodationName: accommodationNameTextField.text!, accommodationPrice: Int(accommodationPriceTextField.text!)!)
            //Passes the name of the new accommodation option into the delegate (sending it to ItemTableViewController) and dismisses AddAccommodationViewController
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var accommodationNameTextField: UITextField!
    @IBOutlet weak var accommodationPriceTextField: UITextField!
    
    var delegate: AccommodationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
