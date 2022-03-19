//
//  CreateQuizViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import UIKit
import Eureka

class CreateQuizViewController: FormViewController {
    let db = DBHelper.init()
    var questionCount = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        animateScroll = true
        rowKeyboardSpacing = 20



        form +++ Section("Create Quiz")
        <<< TextRow("Quiz Subject") { row in
            row.title = "Quiz Subject"
            row.placeholder = "iOS, Database, GCD"
        }
        for index in 1...questionCount {
            form +++ Section("Question \(index)")
            <<< TextAreaRow("Question #\(index)") { row in
                row.title = "Question #\(index)"
                row.placeholder = "Enter Your Question"
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)
            }
            //Answers:
            <<< TextAreaRow("Answer #\(index) - 1") { row in
                row.title = "Answer #\(index) - 1"
                row.placeholder = "Answer 1"
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)

            }
            <<< TextAreaRow("Answer #\(index) - 2") { row in
                row.title = "Answer #\(index) - 2"
                row.placeholder = "Answer 2"
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)

            }
            <<< TextAreaRow("Answer #\(index) - 3") { row in
                row.title = "Answer #\(index) - 3"
                row.placeholder = "Answer 3"
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)

            }
            <<< TextAreaRow("Answer #\(index) - 4") { row in
                row.title = "Answer #\(index) - 4"
                row.placeholder = "Answer 4"
                row.textAreaHeight = TextAreaHeight.dynamic(initialTextViewHeight: 30)

            }
            <<< IntRow("Correct#\(index)") { row in
                row.title = "Enter Correct Answer #"
                row.placeholder = "0"

            }

        }
        form +++ Section("Submit All")
        <<< ButtonRow("my Button") { row in
            row.title = "Submit"


            row.onCellSelection { cell, row in
                let valuesDictionary = self.form.values()
                print(valuesDictionary)

                let subjectName = valuesDictionary["Quiz Subject"] as? String ?? "No SubJect Entered"

                for i in 1...(((valuesDictionary.count - 2) / 5) - 1) {
                    let question = valuesDictionary["Question #\(i)"] as? String ?? ""
                    let questionId = Int(self.db.getLastInsertedId())
                    let answer1 = valuesDictionary["Answer #\(i) - 1"] as? String ?? ""
                    let answer2 = valuesDictionary["Answer #\(i) - 2"] as? String ?? ""
                    let answer3 = valuesDictionary["Answer #\(i) - 3"] as? String ?? ""
                    let answer4 = valuesDictionary["Answer #\(i) - 4"] as? String ?? ""
                    let correctAnswer = valuesDictionary["Correct#\(i)"] as? Int ?? 0

                    self.db.insertQuestions(subjectName: subjectName, questionText: question, correctAnswer: correctAnswer)
                    self.db.insertAnswers(questionId: questionId, answerText: answer1, sequence: 1)
                    self.db.insertAnswers(questionId: questionId, answerText: answer2, sequence: 2)
                    self.db.insertAnswers(questionId: questionId, answerText: answer3, sequence: 3)
                    self.db.insertAnswers(questionId: questionId, answerText: answer4, sequence: 4)
  
                }

            }

        }
    }


}

class myTextAreaRow: _TextAreaRow {
//    textAreaHeight = TextAreaHeight.fixed(cellHeight: 40)
}
