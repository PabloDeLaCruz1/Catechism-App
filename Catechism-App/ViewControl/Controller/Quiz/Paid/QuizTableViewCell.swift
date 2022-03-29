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

        //Allow for overlapping views
        quizTitleLabel.layer.zPosition = 1;
        subTypeLabel.layer.zPosition = 1;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.randomImgView.image = nil
        self.subTypeLabel.text = nil
        self.quizTitleLabel.text = nil
    }
}
