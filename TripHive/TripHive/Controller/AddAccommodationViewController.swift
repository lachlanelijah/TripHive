//
//  AddAccommodationViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

class AddAccommodationViewController: UIViewController {
    
    // Delegates
    var delegate: ItemDelegate? // Found in ItemTableViewController
    
    var accommodation: Item?
    var accommodationEditing = false;
    
    // Outlets
    @IBOutlet weak var accommodationLabel: UINavigationItem!
    @IBOutlet weak var accommodationActionLabel: UIBarButtonItem!
    @IBOutlet weak var accommodationNameTextField: UITextField!
    @IBOutlet weak var accommodationPriceTextField: UITextField!
    
    // Initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        if (accommodationEditing && accommodation != nil) {
            accommodationLabel.title = "Update Accommodation";
            accommodationActionLabel.title = "Confirm"
            accommodationNameTextField.text = accommodation?.itemName;
            accommodationPriceTextField.text = "\(accommodation?.itemPrice ?? 0)";
        } else {
            accommodation = Item(itemName: "", itemPrice: 0)
        }
    }
    
    // Actions
    
    // Set the item name
    @IBAction func itemNameChanged() {
        accommodation?.itemName = accommodationNameTextField.text ?? "";
    }
    
    // Set the item price
    @IBAction func itemPriceChanged() {
        accommodation?.itemPrice = Int(accommodationPriceTextField.text ?? "0") ?? 0;
    }
    
    @IBAction func addAccommodationButton(_ sender: UIBarButtonItem) {
        if (accommodation?.isValid() == true) {
            // Accommodation is valid - Save the Item
            if (accommodationEditing) {
                delegate?.addOrUpdateItem(item: nil);
            } else {
                delegate?.addOrUpdateItem(item: accommodation);
            }
            dismiss(animated: true, completion: nil);
        } else {
            // Accommodation is invalid - present error dialogue
            let ac = UIAlertController(title: "Your Accommodation details are incorrect. Please ensure the name is not empty, and the price is $0 or more.", message: nil, preferredStyle: .alert);
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction);
            present(ac, animated: true)
        }
    }
    
    // Cancel error prompt
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
