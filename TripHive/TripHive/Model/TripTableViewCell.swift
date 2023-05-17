//
//  TripTableViewCell.swift
//  TripHive
//
//  Created by Lachlan Atack on 4/5/2023.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    //A custom UITableViewCell class used in TripTableViewController; allows access to the labels for trip name, icon, and number of people
    @IBOutlet weak var peopleNumberLabel: UILabel!
    @IBOutlet weak var tripIcon: UIImageView!
    @IBOutlet weak var tripNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
