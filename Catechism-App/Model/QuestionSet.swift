//
//  Question.swift
//  TeamOne
//
//  Created by Young Ju on 3/17/22.
//

import Foundation

class QuestionSet
{

    var question: String = ""
    var correctAnswer: Int = 0
    var wrongAnswer: Int = 0
    var isAnswered: Bool = false
    var firstAnswer: String = ""
    var secondAnswer: String = ""
    var thirdAnswer: String = ""
    var fourthAnswer: String = ""

    init(question: String, correctAnswer: Int, wrongAnswer: Int, isAnswered: Bool,
         firstAnswer: String,  secondAnswer: String,  thirdAnswer: String,  fourthAnswer: String)
    {
        self.question = question
        self.correctAnswer = correctAnswer
        self.wrongAnswer = wrongAnswer
        self.isAnswered = isAnswered
        self.firstAnswer = firstAnswer
        self.secondAnswer = secondAnswer
        self.thirdAnswer = thirdAnswer
        self.fourthAnswer = fourthAnswer
    }
}
