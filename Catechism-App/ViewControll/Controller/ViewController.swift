//
//  ViewController.swift
//  FacebookDemo-class-1
//
//  Created by David Gonzalez on 3/14/22.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {
 
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton){
        
    }

    
    @IBOutlet weak var lgbtn: FBLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current   , !token.isExpired{
            let token =  token.tokenString
                
                let req = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,first_name"],
                                             tokenString: token, version: nil, httpMethod: .get)
                
                req.start{
                    conne, result, error in
                    print(result)
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
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?){

     //   let token = result?.token?.to
        
    let token =  result?.token?.tokenString
        
        let req = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name"],
                                     tokenString: token, version: nil, httpMethod: .get)
        
        req.start{
            conne, result, error in
            print(result)
        }
    }
}



