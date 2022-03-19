//
//  Answers.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/18/22.
//

import Foundation

class Answers {
    var id: Int 
    var questionId: Int
    var answerText: String
    var sequence: Int

    init(id: Int, questionId: Int, answerText: String, sequence: Int)
    {
        self.id = id
        self.questionId = questionId
        self.answerText = answerText
        self.sequence = sequence
    }
}
