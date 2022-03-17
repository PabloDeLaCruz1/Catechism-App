//
//  Questions.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/17/22.
//

import Foundation
class Questions {
    var id: Int = 0
    var subject_name: String = ""
    var question_text: String = ""
    var corrrect_answer: String

    init(id: Int, subject_name: String, question_text: String, corrrect_answer: String)
    {
        self.id = id
        self.subject_name = corrrect_answer
        self.question_text = question_text
        self.corrrect_answer = corrrect_answer
    }
}
