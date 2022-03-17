//
//  WellcomeViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit

class WellcomeViewController: UIViewController {
    var userWellcome = ""
    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text! = userWellcome
        print("userWellcome:",userWellcome)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func quizB(_ sender: Any) {
        goNextView(nameView : "quiz")
    }
    
    
    @IBAction func adminB(_ sender: Any) {
        goNextView(nameView : "admin")
    }
    
    @IBAction func dashB(_ sender: Any) {
     
            goNextView(nameView : "dashboard")
    }
    
        
    
    func goNextView(nameView : String) {
        if (nameView == "quiz") {
            
            let displayVC : QuizViewController  = UIStoryboard(name: "QuizStoryboard", bundle: nil).instantiateViewController(withIdentifier: "quizSB") as!  QuizViewController
            
           // displayVC.userWellcome   = userName.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }
        
        if (nameView == "admin") {
            
            let displayVC : AdminViewController  = UIStoryboard(name: "AdminStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "adminSB") as!  AdminViewController
            
       //     displayVC.userWellcome   = userText.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }
        
        if (nameView == "dashboard") {
            
            let displayVC :
            DashboardViewController = UIStoryboard(name: "DashboardStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardSB") as!  DashboardViewController
            
       //     displayVC.userWellcome   = userText.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }
        
    }
        
}
     
    
    
    

