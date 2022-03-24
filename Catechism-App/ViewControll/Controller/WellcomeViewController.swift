//
//  WellcomeViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit

class WellcomeViewController: UIViewController {
   
    //MARK: Variables
    var userWellcome = ""
    var susWellcome = ""
    
    //MARK: IBOutlet
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var suscriptionL: UILabel!
    @IBOutlet weak var quizB: UIButton!
    @IBOutlet weak var dashB: UIButton!
    @IBOutlet weak var adminB: UIButton!
    
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text! = userWellcome
        suscriptionL.text! = susWellcome
        
        if (suscriptionL.text == "0"){
            adminB.isEnabled = false
            dashB.isEnabled = false
            quizB.isEnabled = true
        }else if (suscriptionL.text == "1"){
            adminB.isEnabled = false
            dashB.isEnabled = false
        }else if (suscriptionL.text == "2"){
            adminB.isEnabled = true
            dashB.isEnabled = true
            quizB.isEnabled = true
        }else if (suscriptionL.text == "3"){
            adminB.isEnabled = false
            dashB.isEnabled = false
            quizB.isEnabled = false
        }
        
        
        print("userWellcome:",userWellcome)
        // Do any additional setup after loading the view.
    }
    
    //MARK: IBAction
    @IBAction func quizB(_ sender: Any) {
        goNextView(nameView : "quiz")
    }
    
    
    @IBAction func adminB(_ sender: Any) {
        goNextView(nameView : "admin")
    }
    
    @IBAction func dashB(_ sender: Any) {
     
            goNextView(nameView : "dashboard")
    }
    
     //MARK: Functions
    
    func goNextView(nameView : String) {
        if (nameView == "quiz") {
            
            let _ : QuizViewController  = UIStoryboard(name: "QuizStoryboard", bundle: nil).instantiateViewController(withIdentifier: "quizSB") as!  QuizViewController
            var _:UIViewController = ChooseQuizTypeVC()
            self.modalPresentationStyle = .fullScreen
            
            let modalStyle: UIModalTransitionStyle = UIModalTransitionStyle.crossDissolve
                StartViewController().modalTransitionStyle = modalStyle
            present(ChooseQuizTypeVC(), animated: true, completion: nil)
            
//            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "wcvc") as! ViewController
//            let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
            let v=ChooseQuizTypeVC()
//            DBHelper.init().createSessionRecord(uid: 0, type: type)
//           navigationController?.pushViewController(v, animated: true)
//            navigationController?.setNavigationBarHidden(true, animated: false)

//            self.present(navController, animated:true, completion: nil)

//            self.present(instVC, animated: true, completion: nil)

//                self.present(QuizVC, animated: true, completion: nil)
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
     
    
    
    

