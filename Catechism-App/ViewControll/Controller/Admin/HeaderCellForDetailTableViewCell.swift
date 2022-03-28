//
//  HeaderCellForDetailTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/23/22.
//

import UIKit

class HeaderCellForDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectHeader: UILabel!
    @IBOutlet weak var totalScoreHeader: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        subjectHeader.text = "Subject:"
        totalScoreHeader.text = "Total Score:"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
