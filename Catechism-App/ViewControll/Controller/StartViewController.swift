//
//  StartViewController.swift
//  FeedBack-Team-D-1
//
//  Created by David Gonzalez on 2/28/22.
//

import UIKit
import FBSDKLoginKit

class StartViewController: UIViewController, LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
       
    }
    
   
    
    @IBOutlet weak var showP: UIButton!
    @IBOutlet weak var hidePas: UIButton!
    
    
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
   
    
    @IBOutlet weak var loginB: UIButton!
    
    @IBOutlet weak var signUpB: UIButton!
    
    
    @IBOutlet weak var lgbtn: FBLoginButton!
    
    
    var loginChecked = false
    var signupChecked = true
    var email = ""
    var password = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceLogin()
        //setupUI()
        loginB.layer.cornerRadius = 20
        signUpB.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        userEmailText.text = email
        userPasswordText.text = password
        
    }
    
    func faceLogin(){
        var retUser:String = ""
        if let token = AccessToken.current   , !token.isExpired{
            let token =  token.tokenString
                
                let req = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,first_name"],
                                             tokenString: token, version: nil, httpMethod: .get)
                
                req.start{
                    conne, result, error in
                    if let userdata = result as? [String:AnyObject] {
                                                                                   retUser = (userdata["email"] as? String)!
                                                                                         }
                    self.userEmailText.text! = retUser
                    print("resulados::::::",result)
                }
            }
            
            
        else{
//            let loginbtn = FBLoginButton()
//            loginbtn.center = view.center
//            view.addSubview(loginbtn)
            self.lgbtn.delegate = self
            lgbtn.permissions = ["public_profile","email"]
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    // *********
    
    
    
    
    // *************
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?){
        var retUser:String = ""
     //   let token = result?.token?.to
        
    let token =  result?.token?.tokenString
        
        let req = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name"],
                                     tokenString: token, version: nil, httpMethod: .get)
        
        req.start{
            conne, result, error in
            if let userdata = result as? [String:AnyObject] {
                                                                           retUser = (userdata["email"] as? String)!
                                                                                 }
            self.userEmailText.text! = retUser
            print("userrrrrrrrrr:",result,"retUser:",retUser)
        }
    }
    

}
