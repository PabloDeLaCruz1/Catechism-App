//
//  SignViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    // MARK: Variables
    var db: DBHelper = DBHelper()
    var userWellcome = ""
    // MARK: IBOutlet
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passT: UITextField!
    @IBOutlet weak var subscriptionType: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var hidePB: UIButton!
    @IBOutlet weak var showPB: UIButton!
    @IBOutlet weak var subB: UIButton!
    @IBOutlet weak var errorB: UILabel!
    
    @IBOutlet weak var selected1: UIImageView!
    
    @IBOutlet weak var selected2: UIImageView!
    
    
    
    // Suscription
    @IBOutlet weak var freeeB: UIButton!
    @IBOutlet weak var paidB: UIButton!
    @IBOutlet weak var adminB: UIButton!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        subB.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)

        
        
        //  print("selectedName:",userWellcome)
        // Do any additional setup after loading the view.
    }
    
    // MARK: IBACTION
    @IBAction func BFree(_ sender: Any) {
        subscriptionType.text = "0"
        selected1.isHidden = false
        selected2.isHidden = true
        print("free")
    }
    
    
    @IBAction func BPaid(_ sender: Any) {
        subscriptionType.text = "1"
        selected1.isHidden = true
        selected2.isHidden = false
        print("paid")
    }
    
    
    @IBAction func BAdmin(_ sender: Any) {
        subscriptionType.text = "2"
        print("admin")
    }
    
    
    @IBAction func crearUsuario(_ sender: UIButton) {
        
        if validateData() {
            saveUserDB()
            goNextView(nameView: "login")
        } else {
            print("Input user")
        }
        
    }
    
    @IBAction func ShowPass(_ sender: Any) {
        print("Change passs")
        passT.isSecureTextEntry = false
        hidePB.isHidden = false
        showPB.isHidden = true
    }
    
    @IBAction func hidePass(_ sender: Any) {
        print("Hide Change passs")
        passT.isSecureTextEntry = true
        hidePB.isHidden = true
        showPB.isHidden = false
    }
    
    // MARK:  FUNCTIONS
    func saveUserDB() {
        db.insertUsers(name: emailText.text!, password: passT.text!, subscriptionType: Int(subscriptionType.text!) ?? 0)
    }
    
    func validateData() -> Bool {
        if emailText.text! == "" {
            errorB.text = "Enter the user"
            return false
        }
        if passT.text! == "" {
            errorB.text = "Enter the password"
            return false
        }
        
        if subscriptionType.text! == "" {
            errorB.text = "Enter Suscription"
            return false
        }
        
//        if id.text! == "" {
//            errorB.text = "Enter id"
//            return false
//        }
        
        return true
    }
    
    func goNextView(nameView: String) {
        if (nameView == "login") {
            
            let displayVC: StartViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "loginView") as! StartViewController
            
            // displayVC.userWellcome   = userName.text!
            
            self.present(displayVC, animated: true, completion: nil)
            
        }
    }
    
    
}

