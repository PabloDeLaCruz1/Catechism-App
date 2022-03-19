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

        }
        form +++ Section("Submit All")
        <<< ButtonRow("my Button") { row in
            row.title = "Button"
            
            let userId: TextRow? = form.rowBy(tag: "MyRowTag")
            let value = row.value

//            db.insertQuestions()
//            db.insertAnswers(answerId: <#T##Int#>, answerText: <#T##String#>, sequence: <#T##Int#>)
        }
//            .onCellSelection { cell, row in
//            //do whatever you want  }
//        }

    }


}

class myTextAreaRow: _TextAreaRow {
//    textAreaHeight = TextAreaHeight.fixed(cellHeight: 40)
}
