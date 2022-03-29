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

var db = DBHelper()

class QuizTopicVC: UIViewController  {
    public var loggedInUser = 4  //TODO temp for test

    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="Tap will tell the topic chosen!"
        self.view.backgroundColor=UIColor.white
        setupViews()
    }
    
    let  buttonAIX = ReusableButton(frame: CGRect())
    let  buttonApple = ReusableButton(frame: CGRect())
    let  buttonSQLite = ReusableButton(frame: CGRect())
    
    @objc func solveAIX() {
        showNext(type: "1")
    }
    @objc func solveApple() {
        showNext(type: "2")
  }
    @objc func solveSQLite() {
        showNext(type: "3")
   }

    func setupViews() {
        
        self.view.addSubview(buttonAIX)
        buttonAIX.centerXAnchor.constraint(equalTo: (self.view.centerXAnchor)).isActive=true
        buttonAIX.centerYAnchor.constraint(equalTo: (self.view.centerYAnchor) , constant: CGFloat(-150)).isActive=true
        buttonAIX.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonAIX.widthAnchor.constraint(equalToConstant: 180).isActive=true
 
        self.view.addSubview(buttonApple)
        buttonApple.centerXAnchor.constraint(equalTo: (self.view.centerXAnchor)).isActive=true
        buttonApple.centerYAnchor.constraint(equalTo: (self.view.centerYAnchor) , constant: CGFloat(0)).isActive=true
        buttonApple.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonApple.widthAnchor.constraint(equalToConstant: 180).isActive=true
        self.view.addSubview(buttonSQLite)
        buttonSQLite.centerXAnchor.constraint(equalTo: (self.view.centerXAnchor)).isActive=true
        buttonSQLite.centerYAnchor.constraint(equalTo: (self.view.centerYAnchor) , constant: CGFloat(150)).isActive=true
        buttonSQLite.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonSQLite.widthAnchor.constraint(equalToConstant: 180).isActive=true

        buttonAIX.addTarget(self, action: #selector(solveAIX), for: .touchUpInside)
        buttonApple.addTarget(self, action: #selector(solveApple), for: .touchUpInside)
        buttonSQLite.addTarget(self, action: #selector(solveSQLite), for: .touchUpInside)
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 130).isActive=true
        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
        lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
    }
    
    func showNext(type: String)  {
        let v=QuizVC()
        v.typeChosen = type
        SessionInfo.sessionId = db.createSessionRecord(uid: SessionInfo.loginUserId, type: type)
        if SessionInfo.loginUserType == 0 {
            SessionInfo.freeSessionCount = Int(db.countFreeSessions(uid: SessionInfo.loginUserId))
        }
        navigationController?.pushViewController(v, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
                    guard let windowScene = (SceneDelegate.scene as? UIWindowScene) else { return }
            
                                        let window = UIWindow(windowScene: windowScene)
            
                                        let navigation = UINavigationController(rootViewController: v)
                                        window.rootViewController = navigation
            
                                        self.window = window
                                        window.makeKeyAndVisible()
                                        window.backgroundColor = UIColor.white
    }
        
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text="Blind Quiz"
        lbl.textColor=UIColor.darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 46)
        lbl.numberOfLines=2
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
}
