//
//  ScoreBySubjectTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/23/22.
//

import UIKit

class ScoreBySubjectTableViewCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
