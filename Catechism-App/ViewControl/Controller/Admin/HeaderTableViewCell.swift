//
//  HeaderTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var HeaderOptionsMenu: UILabel!
    @IBOutlet weak var headerId: UILabel!
    @IBOutlet weak var headerUserName: UILabel!
    @IBOutlet weak var headerTotalScore: UILabel!
    @IBOutlet weak var headerSubType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        headerId.text = "ID"
        headerUserName.text = "User"
        headerSubType.text = "Sub Type"
        headerTotalScore.text = "Total Score"
        HeaderOptionsMenu.text = "Options"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
