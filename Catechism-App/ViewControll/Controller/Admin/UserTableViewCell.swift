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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        userId.text = "2"
//        userName.text = "Pablo"
//        subType.text = "freeee"
//        totalScore.text = "1000"
        
        fanMenu.button = FanMenuButton(
            id: "fanMenuButton",
            image: UIImage(systemName: "gearshape.fill"),
            color: Color(val: 0x7C93FE)
        )
        fanMenu.items = [
            FanMenuButton(
                id: "block_user_id",
                image: UIImage(systemName: "person.fill.xmark"),
                color: Color(val: 0x9F85FF)
            ),
            FanMenuButton(
                id: "promote_user_id",
                image: UIImage(systemName: "person.fill.checkmark"),
                color: Color(val: 0xF55B58)
            )
        ]
        
        // call before animation
        fanMenu.onItemDidClick = { button in
            print("ItemDidClick: \(button.id)")
            
        }
        // call after animation
        fanMenu.onItemWillClick = { button in
            print("ItemWillClick: \(button.id)")
        }
        
        //FanMenu - Configure optional parameters
        //size of menu
        fanMenu.radius = 15

        // distance between button and items
        fanMenu.menuRadius = 30.0

        // animation duration
        fanMenu.duration = 0.35

        // menu opening delay
        fanMenu.delay = 0.05

        // interval for buttons in radians
        fanMenu.interval = (0, 2.0 * M_PI)

        // menu background color
        fanMenu.menuBackground = Color.aliceBlue
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
