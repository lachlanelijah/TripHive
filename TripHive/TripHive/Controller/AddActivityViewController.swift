//
//  AddActivityViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    // Delegates
    var delegate: ItemDelegate? // Found in ItemTableViewController

    // vars
    var activity: Item?
    var activityEditing = false;
    
    // Outlets
    @IBOutlet weak var activityLabel: UINavigationItem!
    @IBOutlet weak var activityActionButton: UIBarButtonItem!
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var activityPriceTextField: UITextField!
    
    
    // Initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        //Allows keyboard to be dismissed by tapping outside of it
        
        if (activityEditing && activity != nil) {
            activityLabel.title = "Update Activity";
            activityActionButton.title = "Confirm";
            activityNameTextField.text = activity?.itemName;
            activityPriceTextField.text = "\(activity?.itemPrice ?? 0)"
        } else {
            activity = Item(itemName: "", itemPrice: 0);
        }
    }
    
    // Actions
    @IBAction func activityNameChanged() {
        activity?.itemName = activityNameTextField.text ?? "";
    }
    
    @IBAction func activityPriceChanged() {
        activity?.itemPrice = Int(activityPriceTextField.text ?? "0") ?? 0;
    }
    
    @IBAction func addActivityButton(_ sender: UIBarButtonItem) {
        if (activity?.isValid() == true) {
            // Activity is valid - Save item and dismiss the screen
            if activityEditing {
                delegate?.addOrUpdateItem(item: nil);
            } else {
                delegate?.addOrUpdateItem(item: activity);
            }
            dismiss(animated: true, completion: nil);
        } else {
            // Activity is invalid - Show error dialogue
            let ac = UIAlertController(title: "Your Activity details are incorrect. Please ensure the name is not empty, and the price is $0 or more.", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        }
    }
    
    // Hide error dialogue
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        //allows the user to dismiss the keyboard by tapping outside of it
        view.endEditing(true)
    }
}
