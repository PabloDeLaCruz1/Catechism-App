//
//  SignViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit

class SignUpViewController: UIViewController {

    var db:DBHelper = DBHelper()
    var userWellcome = ""
    
    @IBOutlet weak var emailText: UITextField!
   

    @IBOutlet weak var passT: UITextField!
    
    @IBOutlet weak var subscriptionType: UITextField!
    @IBOutlet weak var id: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  print("selectedName:",userWellcome)
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func crearUsuario(_ sender: UIButton) {
        saveUserDB()
    }
    
    
    func saveUserDB(){
        db.insertUsers(id: Int(id.text!) ?? 0, name: emailText.text!, password: passT.text! , subscriptionType: Int(subscriptionType.text!) ?? 0)
    }

}
