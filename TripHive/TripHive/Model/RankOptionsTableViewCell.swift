//
//  RankOptionsTableViewCell.swift
//  TripHive
//
//  Created by Lachlan Atack on 19/5/2023.
//

import UIKit

class RankOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemCostLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
