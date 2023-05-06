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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}