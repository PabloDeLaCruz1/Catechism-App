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

    var myTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = selectedSubject + " Quiz"
        questionLabel.numberOfLines = 0

        //30min timer for quiz:
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.myTimer = timer
            self.timeLeft -= 1
            let (h, m, s) = self.secondsToHoursMinutesSeconds(self.timeLeft)
            self.timeLeftLabel.text = "Time Left: \(h):\(m):\(s)"
            if(self.timeLeft == 0) {
                timer.invalidate()
            }
        }
        loadQuestionsAndAnswers()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }

    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    //Insert Data into Quiz once the quiz is over.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quizDetail" {
            if let nextVC = segue.destination as? ShowOneUserViewController {
                nextVC.modalPresentationStyle = .fullScreen
                db.insertQuizSessions(userId: userData.id, score: score, sessionDate: "\(Date.now)", subjectName: selectedSubject)
                nextVC.User.scoresBySubject = getUserTotalScoreBySubjectById(id: userData.id)
                nextVC.User = sender as! Users
            }
        }
    }

    func loadQuestionsAndAnswers() {
        if questionsLeft == 0 {
            self.myTimer.invalidate()
            self.performSegue(withIdentifier: "quizDetail", sender: userData)
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

    //TODO: implement and use
    func checkAnswer() {

    }

    //IBAction buttons as answer pickers:
    @IBAction func answer1Btn(_ sender: Any) {
        selectedAnswer = 0
        answer1Btn.tintColor = UIColor.systemRed

        answer2Btn.tintColor = UIColor.systemBlue
        answer3Btn.tintColor = UIColor.systemBlue
        answer4Btn.tintColor = UIColor.systemBlue
    }

    @IBAction func answer2Btn(_ sender: Any) {
        selectedAnswer = 1
        answer2Btn.tintColor = UIColor.red

        answer1Btn.tintColor = UIColor.systemBlue
        answer3Btn.tintColor = UIColor.systemBlue
        answer4Btn.tintColor = UIColor.systemBlue
    }

    @IBAction func answer3Btn(_ sender: Any) {
        selectedAnswer = 2
        answer3Btn.tintColor = UIColor.red

        answer2Btn.tintColor = UIColor.systemBlue
        answer1Btn.tintColor = UIColor.systemBlue
        answer4Btn.tintColor = UIColor.systemBlue
    }
    @IBAction func answer4Btn(_ sender: Any) {
        selectedAnswer = 3
        answer4Btn.tintColor = UIColor.red

        answer2Btn.tintColor = UIColor.systemBlue
        answer3Btn.tintColor = UIColor.systemBlue
        answer1Btn.tintColor = UIColor.systemBlue
    }

    @IBAction func submitBtn(_ sender: Any) {
        if selectedAnswer == 4 {
            print("Error, No Answer Selected!")
        } else {
            if selectedAnswer == correctAnswer {
                //TODO: Optional, depending on requirements - Inform user of correct/wrong answer
                print("Correct Answer!")
                score += 1
                loadQuestionsAndAnswers()
            } else {
                print("Bad Answer!")
                loadQuestionsAndAnswers()
            }
        }
    }

    //TODO: This function needs to be a helper, its copied and pasted in many places
    func getUserTotalScoreBySubjectById(id: Int) -> [String: Int] {
        var score = 0
        var userScoreBySubject = [String: Int]()
        let quizSessions = db.getQuizSessions()
        for q in quizSessions {
            if q.userId == id {
                score += q.score

                if userScoreBySubject[q.subjectName] == nil {
                    userScoreBySubject[q.subjectName] = q.score
                } else {
                    userScoreBySubject[q.subjectName]! += q.score
                }
            }
        }
        return userScoreBySubject;
    }
}
