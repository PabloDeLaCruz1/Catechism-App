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
        quizB.layer.cornerRadius = 20
        dashB.layer.cornerRadius = 20
        adminB.layer.cornerRadius = 20
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)

        if (suscriptionL.text == "0"){
            adminB.isEnabled = false
            dashB.isEnabled = false
            quizB.isEnabled = true
        }else if (suscriptionL.text == "1"){
            adminB.isEnabled = false
            dashB.isEnabled = true
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
    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
     //MARK: Functions
    
    func goNextView(nameView : String) {
        if (nameView == "quiz") {
            
//            let displayVC : QuizViewController  = UIStoryboard(name: "QuizStoryboard", bundle: nil).instantiateViewController(withIdentifier: "quizSB") as!  QuizViewController
            
           // displayVC.userWellcome   = userName.text!
            self.modalPresentationStyle = .fullScreen

            self.present(StartQuizVC(), animated: true, completion: nil)
//            displayVC.modalPresentationStyle = .fullScreen
//                self.present(displayVC, animated: true, completion: nil)
        }
        
        if (nameView == "admin") {
            
            let displayVC : AdminViewController  = UIStoryboard(name: "AdminStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "adminSB") as!  AdminViewController
            displayVC.modalPresentationStyle = .fullScreen

       //     displayVC.userWellcome   = userText.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }
        
        if (nameView == "dashboard") {
            
            let displayVC :
            DashboardViewController = UIStoryboard(name: "DashboardStoryBoard", bundle: nil).instantiateViewController(withIdentifier: "dashBoardSB") as!  DashboardViewController
            displayVC.modalPresentationStyle = .fullScreen

       //     displayVC.userWellcome   = userText.text!
                    
                self.present(displayVC, animated: true, completion: nil)
        }
        
    }
        
}
     
    
    
    

