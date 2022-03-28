//
//  ShowQuizViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/28/22.
//

import UIKit
import Foundation


class ShowQuizViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var answer1Btn: UIButton!
    @IBOutlet weak var answer2Btn: UIButton!
    @IBOutlet weak var answer3Btn: UIButton!
    @IBOutlet weak var answer4Btn: UIButton!

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var timeLeftLabel: UILabel!
    let db = DBHelper.init()

    var userData = Users()
    var selectedSubject = ""
    var questionNum = 0
    var selectedAnswer = 4
    var correctAnswer = 4
    var score = 0
    var questionsLeft = 5
    
    var timeLeft = 60 * 30

    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = selectedSubject
        questionLabel.numberOfLines = 0
        // Do any additional setup after loading the view.
        
        loadTimer()
        loadQuestionsAndAnswers()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }
    
    func loadTimer(){
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                 print("timer fired!")

            self.timeLeft -= 1
           
            
            let (h,m,s) = self.secondsToHoursMinutesSeconds(self.timeLeft)
            self.timeLeftLabel.text = "Time Left: \(h):\(m):\(s)"
            print(self.timeLeft)
            
            if(self.timeLeft==0){
                      timer.invalidate()
                  }
         }
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    func loadQuestionsAndAnswers() {
        if questionsLeft == 0 {
            print("End of questions!, your total score was", score)
            //send to detail quiz result view before back to main screen.
            
            let displayVC : WelcomeViewController  = UIStoryboard(name: "StartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "WelcomeSB") as!  WelcomeViewController
            displayVC.modalPresentationStyle = .fullScreen
            displayVC.userData = self.userData
            self.present(displayVC, animated: true, completion: nil)
            
        } else {

            var currentQuestions = db.getQuestions()
            var currentAnswers = db.getAnswers()

            answer2Btn.tintColor = UIColor.systemBlue
            answer3Btn.tintColor = UIColor.systemBlue
            answer1Btn.tintColor = UIColor.systemBlue
            answer4Btn.tintColor = UIColor.systemBlue

            currentQuestions = currentQuestions.filter { $0.subject_name == selectedSubject }
            currentAnswers = currentAnswers.filter { $0.questionId == currentQuestions[questionNum].id
            }

            questionLabel.text = currentQuestions[questionNum].question_text
            answer1Btn.setTitle(currentAnswers[0].answerText, for: .normal)
            answer2Btn.setTitle(currentAnswers[1].answerText, for: .normal)
            answer3Btn.setTitle(currentAnswers[2].answerText, for: .normal)
            answer4Btn.setTitle(currentAnswers[3].answerText, for: .normal)

            correctAnswer = Int(currentQuestions[questionNum].corrrect_answer) ?? 4

            questionNum += 1;
            questionsLeft -= 1;
        }
    }

    func checkAnswer() {

    }

    @IBAction func answer1Btn(_ sender: Any) {

        selectedAnswer = 0
        answer1Btn.tintColor = UIColor.systemRed

        answer2Btn.tintColor = UIColor.systemBlue
        answer3Btn.tintColor = UIColor.systemBlue
        answer4Btn.tintColor = UIColor.systemBlue

        print("Answer 1 ")
        loadTimer()
    }


    @IBAction func answer2Btn(_ sender: Any) {
        selectedAnswer = 1
        answer2Btn.tintColor = UIColor.red

        answer1Btn.tintColor = UIColor.systemBlue
        answer3Btn.tintColor = UIColor.systemBlue
        answer4Btn.tintColor = UIColor.systemBlue

        print("Answer 2 ")

    }

    @IBAction func answer3Btn(_ sender: Any) {
        selectedAnswer = 2
        answer3Btn.tintColor = UIColor.red

        answer2Btn.tintColor = UIColor.systemBlue
        answer1Btn.tintColor = UIColor.systemBlue
        answer4Btn.tintColor = UIColor.systemBlue

        print("Answer 3 ")

    }
    @IBAction func answer4Btn(_ sender: Any) {
        selectedAnswer = 3
        answer4Btn.tintColor = UIColor.red

        answer2Btn.tintColor = UIColor.systemBlue
        answer3Btn.tintColor = UIColor.systemBlue
        answer1Btn.tintColor = UIColor.systemBlue

        print("Answer 4 ")

    }

    @IBAction func submitBtn(_ sender: Any) {
        if selectedAnswer == 4 {
            print("Error, No Answer Selected!")
        } else {
            if selectedAnswer == correctAnswer {
                print("Correct Answer!")
                score += 1
                loadQuestionsAndAnswers()
            } else {
                print("Bad Answer!")
                loadQuestionsAndAnswers()
            }
        }
    }
}
