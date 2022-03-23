//
//  ViewController.swift
//  QuizGame
//
//  Created by Abdinasir Hussein on 25/02/2018.
//  Copyright © 2018 Abdinasir Hussein. All rights reserved.
//
//
//Adapted by Ju on 3/12/2022 for non commercial purpose.
// All rights of the creator respected.
import UIKit
import SwiftUI

class StartQuizVC: UIViewController {
    
    var window: UIWindow?
    var userID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="4CQ"
        self.view.backgroundColor=UIColor.white
        setupViews()
    }
    
    let  buttonAIX = ReusableButton(frame: CGRect())
    let  buttonApple = ReusableButton(frame: CGRect())
    let  buttonSQLite = ReusableButton(frame: CGRect())
    
    @objc func solveAIX() {
//        prepareNext(uid: userID, type: "1")
        showNext(type: "1")
    }
    @objc func solveApple() {
//        prepareNext(uid: userID, type: "2")
        showNext(type: "2")
  }
    @objc func solveSQLite() {
//        prepareNext(uid: userID, type: "3")
        showNext(type: "3")
   }

    func setupViews() {
        self.view.addSubview(buttonAIX)
        buttonAIX.centerXAnchor.constraint(equalTo: (self.view.centerXAnchor)).isActive=true
        buttonAIX.centerYAnchor.constraint(equalTo: (self.view.centerYAnchor) , constant: CGFloat(-150)).isActive=true
        buttonAIX.heightAnchor.constraint(equalToConstant: 55).isActive=true
        buttonAIX.widthAnchor.constraint(equalToConstant: 220).isActive=true
 
        self.view.addSubview(buttonApple)
        buttonApple.centerXAnchor.constraint(equalTo: (self.view.centerXAnchor)).isActive=true
        buttonApple.centerYAnchor.constraint(equalTo: (self.view.centerYAnchor) , constant: CGFloat(0)).isActive=true
        buttonApple.heightAnchor.constraint(equalToConstant: 55).isActive=true
        buttonApple.widthAnchor.constraint(equalToConstant: 220).isActive=true
        self.view.addSubview(buttonSQLite)
        buttonSQLite.centerXAnchor.constraint(equalTo: (self.view.centerXAnchor)).isActive=true
        buttonSQLite.centerYAnchor.constraint(equalTo: (self.view.centerYAnchor) , constant: CGFloat(150)).isActive=true
        buttonSQLite.heightAnchor.constraint(equalToConstant: 55).isActive=true
        buttonSQLite.widthAnchor.constraint(equalToConstant: 220).isActive=true

        buttonAIX.addTarget(self, action: #selector(solveAIX), for: .touchUpInside)
        buttonApple.addTarget(self, action: #selector(solveApple), for: .touchUpInside)
        buttonSQLite.addTarget(self, action: #selector(solveSQLite), for: .touchUpInside)
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive=true
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
    }
    
//    func prepareNext(uid: Int, type: String)  {
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        let  todayString = dateFormatter.string(from: date)
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        DBConnector.init().createSessionRecord(uid: 0, type: type)  // date: todayString
//     }
    
    func showNext(type: String)  {
        let v=QuizVC()
        DBHelper.init().createSessionRecord(uid: 0, type: type)
       navigationController?.pushViewController(v, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        v.typeChosen = type
    }

    func setButton(button: UIButton, pos: Int) {
   }
        
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text="Challenges"
        lbl.textColor=UIColor.darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 46)
        lbl.numberOfLines=2
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    


//    let buttonAIX: UIButton = {
//        let btn=UIButton()
//        btn.setTitle("AIX", for: .normal)
//        btn.setTitleColor(UIColor.white, for: .normal)
//        btn.backgroundColor=UIColor.orange
//        btn.layer.cornerRadius=5
//        btn.layer.masksToBounds=true
//        btn.translatesAutoresizingMaskIntoConstraints=false
//        btn.addTarget(self, action: #selector(solveAIX), for: .touchUpInside)
//        return btn
//    }()
//
//    let buttonApple: UIButton = {
//    let btn=UIButton()
//    btn.setTitle("Apple", for: .normal)
//    btn.setTitleColor(UIColor.white, for: .normal)
//    btn.backgroundColor=UIColor.orange
//    btn.layer.cornerRadius=5
//    btn.layer.masksToBounds=true
//    btn.translatesAutoresizingMaskIntoConstraints=false
//    btn.addTarget(self, action: #selector(solveApple), for: .touchUpInside)
//    return btn
//}()
//
//    let buttonSQLite: UIButton = {
//    let btn=UIButton()
//    btn.setTitle("SQLite", for: .normal)
//    btn.setTitleColor(UIColor.white, for: .normal)
//    btn.backgroundColor=UIColor.orange
//    btn.layer.cornerRadius=5
//    btn.layer.masksToBounds=true
//    btn.translatesAutoresizingMaskIntoConstraints=false
//    btn.addTarget(self, action: #selector(solveSQLite), for: .touchUpInside)
//    return btn
//}()
}
