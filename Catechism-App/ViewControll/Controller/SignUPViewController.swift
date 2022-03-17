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
    
    @IBOutlet weak var hidePB: UIButton!
    @IBOutlet weak var showPB: UIButton!
    @IBOutlet weak var subB: UIButton!
    @IBOutlet weak var errorB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        subB.layer.cornerRadius = 20
  print("selectedName:",userWellcome)
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func crearUsuario(_ sender: UIButton) {
       
        
        if validateData(){
            saveUserDB()
            goNextView(nameView : "login")
        }else{
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
    
    func validateData() -> Bool{
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
        
        if id.text! == "" {
            errorB.text = "Enter id"
            return false
        }
        
        
        
        return true
    }
    
    
    
    func saveUserDB(){
        db.insertUsers(id: Int(id.text!) ?? 0, name: emailText.text!, password: passT.text! , subscriptionType: Int(subscriptionType.text!) ?? 0)
        
        
    }

    
    func goNextView(nameView : String) {
        if (nameView == "login") {
            
            let displayVC : StartViewController  = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "loginView") as!  StartViewController
            
           // displayVC.userWellcome   = userName.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }
    }
    
    
}