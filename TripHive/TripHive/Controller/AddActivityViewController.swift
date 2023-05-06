//
//  AddActivityViewController.swift
//  TripHive
//
//  Created by Lachlan Atack on 6/5/2023.
//

import UIKit

protocol ActivityDelegate {
    func passActivityInformation(activityName: String, activityPrice: Int)
}

class AddActivityViewController: UIViewController {

    var delegate: ActivityDelegate?

    @IBAction func addActivityButton(_ sender: UIBarButtonItem) {
        if activityNameTextField.text == "" {
            let ac = UIAlertController(title: "Your activity needs a name!", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true)
        } else {
            delegate?.passActivityInformation(activityName: activityNameTextField.text!, activityPrice: Int(activityPriceTextField.text!)!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var activityPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
