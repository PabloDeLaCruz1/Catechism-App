//
//  UserTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import UIKit
import FanMenu
import Macaw


class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var subType: UILabel!
    @IBOutlet weak var totalScore: UILabel!

    @IBOutlet weak var fanMenu: FanMenu!


    var buttonTappedAction: ((UserTableViewCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}

}
