//
//  WellcomeViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/16/22.
//

import UIKit

class WelcomeViewController: UIViewController, UIGestureRecognizerDelegate {
   
    //MARK: Variables
    var userWelcome = ""  // username comes login page
    var idUserWelcome = 0   // id USer
    var susWelcome = "" // suscription
    var userData = Users()
    //MARK: IBOutlet
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var suscriptionL: UILabel!
    @IBOutlet weak var quizB: UIButton!
    @IBOutlet weak var dashB: UIButton!
    @IBOutlet weak var adminB: UIButton!
    @IBOutlet weak var paidB: UIButton!
    
    @IBOutlet weak var idUserL: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text! = userWelcome
        idUserL.text! = String(idUserWelcome)
        suscriptionL.text! = susWelcome
        quizB.layer.cornerRadius = 20
        dashB.layer.cornerRadius = 20
        adminB.layer.cornerRadius = 20
        paidB.layer.cornerRadius = 20
        
//        var UITapRecognizer = UITapGestureRecognizer(target: self, action: Selector("tappedUserProfile"))
        
        var UITapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedUserProfile))
        
        UITapRecognizer.delegate = self
        
        self.userProfile.addGestureRecognizer(UITapRecognizer)

        self.userProfile.isUserInteractionEnabled = true
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)

        if (suscriptionL.text == "0"){
            adminB.isEnabled = false
            dashB.isEnabled = false
            quizB.isEnabled = true
            paidB.isEnabled = false
        }else if (suscriptionL.text == "1"){
            adminB.isEnabled = false
            dashB.isEnabled = true
            paidB.isEnabled = true

        }else if (suscriptionL.text == "2"){
            adminB.isEnabled = true
            dashB.isEnabled = true
            quizB.isEnabled = true
            paidB.isEnabled = true

        }else if (suscriptionL.text == "3"){
            adminB.isEnabled = false
            dashB.isEnabled = false
            quizB.isEnabled = false
            paidB.isEnabled = false

        }
        
        
        print("userWelcome:",userWelcome)
        // Do any additional setup after loading the view.
    }
    

    @objc func tappedUserProfile(sender: AnyObject) {
        print("User profile clicked for \(userWelcome)")
    
//        self.present(ShowOneUserViewController(), animated: true, completion: nil)
        self.performSegue(withIdentifier: "userProfileSegue", sender: userData)

    }
    
    
    
    @IBAction func paidBtn(_ sender: UIButton) {
        goNextView(nameView : "paidQuiz")

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

//            let displayVC : QuizzesViewController  = UIStoryboard(name: "QuizStoryboard", bundle: nil).instantiateViewController(withIdentifier: "quizSB") as!  QuizzesViewController
//            displayVC.modalPresentationStyle = .fullScreen
            self.present(ChooseQuizTypeVC(), animated: true, completion: nil)

        }
        if (nameView == "paidQuiz") {

            let displayVC : QuizzesViewController  = UIStoryboard(name: "QuizStoryboard", bundle: nil).instantiateViewController(withIdentifier: "quizSB") as!  QuizzesViewController
            displayVC.modalPresentationStyle = .fullScreen
            self.present(displayVC, animated: true, completion: nil)

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
     
    
    
    

