//
//  StartViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/28/22.
//

import UIKit

class StartViewController: UIViewController {
   
    @IBOutlet weak var showP: UIButton!
    @IBOutlet weak var hidePas: UIButton!
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
   
    @IBOutlet weak var loginB: UIButton!
    
    @IBOutlet weak var signUpB: UIButton!
    
    var loginChecked = false
    var signupChecked = true
    var email = ""
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
        loginB.layer.cornerRadius = 20
        signUpB.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        userEmailText.text = email
        userPasswordText.text = password
        
    }
    

}
