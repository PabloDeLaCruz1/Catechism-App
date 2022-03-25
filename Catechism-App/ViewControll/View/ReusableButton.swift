//
//  SubjectChoiceButton.swift
//  Catechism-App
//
//  Created by Young Ju on 3/22/22.
//

import UIKit

class ReusableButton: UIButton {

     override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius=5
         layer.borderWidth=1
         layer.cornerRadius=5
        layer.masksToBounds=true
        translatesAutoresizingMaskIntoConstraints=false
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    func setTypeProperties(tag: Int, title: String) {
        self.tag = tag
        setTitle(title, for: .normal)
    }
    func setAnswerProperties(tag: Int) {
        self.tag = tag
        setTitleColor(UIColor.black, for: .normal)
        backgroundColor=UIColor.white
        titleLabel?.lineBreakMode = .byWordWrapping
        titleLabel?.adjustsFontSizeToFitWidth = true
       titleLabel?.textAlignment = .left
        titleLabel?.minimumScaleFactor = 0.2;
        titleLabel?.baselineAdjustment = .alignBaselines

//        addTarget(superView!, action: #selector(solveAIX), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor=UIColor.orange
        


    }
}
