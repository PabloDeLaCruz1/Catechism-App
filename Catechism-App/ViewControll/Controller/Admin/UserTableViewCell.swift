//
//  UserTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userId: UILabel!

    @IBOutlet weak var userName: UILabel!


    @IBOutlet weak var subType: UILabel!
    
    @IBOutlet weak var totalScore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        userId.text = "2"
//        userName.text = "Pablo"
//        subType.text = "freeee"
//        totalScore.text = "1000"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func dropDownMenu(_ sender: Any) {
    }
    @IBOutlet weak var blockUser: UICommand!
    
    @IBOutlet weak var makeAdmin: UICommand!
}
