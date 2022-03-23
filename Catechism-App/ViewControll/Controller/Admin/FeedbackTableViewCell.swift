//
//  FeedbackTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/23/22.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
