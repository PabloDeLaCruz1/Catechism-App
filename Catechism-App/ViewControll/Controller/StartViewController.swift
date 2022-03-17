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
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var error: UILabel!
    
    
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
        userText.text = email
        userPasswordText.text = password
        
    }
    
    @IBAction func showPass(_ sender: Any) {
        print("Change passs")
        userPasswordText.isSecureTextEntry = false
        hidePas.isHidden = false
        showP.isHidden = true
    }
    @IBAction func hidePass(_ sender: Any) {
        print("Hide Change passs")
        userPasswordText.isSecureTextEntry = true
        hidePas.isHidden = true
        showP.isHidden = false
        
    }
    
    // *********
    
    @IBAction func signUpB(_ sender: Any) {
        goNextView(nameView: "signUp")
    }
    
    func goNextView(nameView : String){
        if (nameView == "signUp") {
            
            let displayVC : SignUpViewController  = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "signUpSB") as!  SignUpViewController
            
            displayVC.userWellcome   = userText.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }else{
            print("no")
        }
     
    }
    
    
    
    @IBAction func loginButton(_ sender: Any) {
        //DBHELPER
        let data = DBHelper.init().read() //  .inst.read()
        for d in data{
            
            if (d.name == userText.text!) &&  (userText.text! != "")  &&  (d.password ==  userPasswordText.text!) {
                
                let displayVC : WellcomeViewController = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "WellcomeSB") as! WellcomeViewController
                displayVC.userWellcome   = userText.text!
                        
                    self.present(displayVC, animated: true, completion: nil)
                
            
                print("Exxiste  id:***********************:", d.id, "user: ",d.name,"pass:",d.password , d.subscriptionType)
            }
        }
    }
    
}
