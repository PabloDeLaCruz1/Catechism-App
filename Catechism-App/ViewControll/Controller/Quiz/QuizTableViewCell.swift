//
//  QuizTableViewCell.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/24/22.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var quizTitleLabel: UILabel!

    @IBOutlet weak var randomImgView: UIImageView!
    @IBOutlet weak var subTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        super.layoutSubviews()
        // Initialization code
//        randomImgView.layer.cornerRadius = 20
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

        quizTitleLabel.layer.zPosition = 1;
        subTypeLabel.layer.zPosition = 1;

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
