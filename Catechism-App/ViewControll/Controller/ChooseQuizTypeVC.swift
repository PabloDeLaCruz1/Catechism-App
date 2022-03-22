//
//  ViewController.swift
//  QuizGame
//
//  Created by Abdinasir Hussein on 25/02/2018.
//  Copyright © 2018 Abdinasir Hussein. All rights reserved.
//

import UIKit
import SwiftUI

class StartQuizVC: UIViewController {
    
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="4CQ"
        self.view.backgroundColor=UIColor.white
        setupViews()
    }
    
    @objc func btnAIXAction() {
        let v=QuizVC()
        navigationController?.pushViewController(v, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        v.typeChosen = 1
    }
    @objc func btnAppleAction() {
        let v=QuizVC()
        navigationController?.pushViewController(v, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        v.typeChosen = 2
    }
    @objc func btnJavaAction() {
        let v=QuizVC()
        navigationController?.pushViewController(v, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        v.typeChosen = 3
    }

//    func addSubview(view: View, con1: Int, con2: Int, con3: Int) {
//        self.view.addSubview(lblTitle)
//        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive=true
//        lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
//        lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
//        lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
//    }
        
        func setupViews() {
            self.view.addSubview(lblTitle)
            lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive=true
            lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
            lblTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
            lblTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
     
        self.view.addSubview(buttonAIX)
        buttonAIX.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonAIX.widthAnchor.constraint(equalToConstant: 150).isActive=true
        buttonAIX.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        buttonAIX.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive=true
        
        self.view.addSubview(buttonApple)
        buttonApple.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonApple.widthAnchor.constraint(equalToConstant: 150).isActive=true
        buttonApple.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        buttonApple.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50).isActive=true
        
        self.view.addSubview(buttonJava)
        buttonJava.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonJava.widthAnchor.constraint(equalToConstant: 150).isActive=true
        buttonJava.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        buttonJava.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant:150).isActive=true
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
    
    let buttonAIX: UIButton = {
        let btn=UIButton()
        btn.setTitle("AIX", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor=UIColor.orange
        btn.layer.cornerRadius=5
        btn.layer.masksToBounds=true
        btn.translatesAutoresizingMaskIntoConstraints=false
        btn.addTarget(self, action: #selector(btnAIXAction), for: .touchUpInside)
        return btn
    }()
    
    let buttonApple: UIButton = {
    let btn=UIButton()
    btn.setTitle("Apple", for: .normal)
    btn.setTitleColor(UIColor.white, for: .normal)
    btn.backgroundColor=UIColor.orange
    btn.layer.cornerRadius=5
    btn.layer.masksToBounds=true
    btn.translatesAutoresizingMaskIntoConstraints=false
    btn.addTarget(self, action: #selector(btnAppleAction), for: .touchUpInside)
    return btn
}()
    
    let buttonJava: UIButton = {
    let btn=UIButton()
    btn.setTitle("Java", for: .normal)
    btn.setTitleColor(UIColor.white, for: .normal)
    btn.backgroundColor=UIColor.orange
    btn.layer.cornerRadius=5
    btn.layer.masksToBounds=true
    btn.translatesAutoresizingMaskIntoConstraints=false
    btn.addTarget(self, action: #selector(btnJavaAction), for: .touchUpInside)
    return btn
}()
}
