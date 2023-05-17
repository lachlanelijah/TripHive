//
//  ItemTableViewCell.swift
//  TripHive
//
//  Created by Lachlan Atack on 5/5/2023.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    //A custom UITableViewCell class used in ItemTableViewController; allows access to the labels for item name and cost
    @IBOutlet weak var itemCostLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
