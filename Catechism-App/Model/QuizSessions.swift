//
//  QuizSessions.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/16/22.
//

import Foundation

class QuizSessions {
    var id: Int = 0
    var userId: Int = 0
    var score: Int = 0
    var sessionDate: String = ""
    var subjectName: String = ""

    init(id: Int, userId: Int, score: Int, sessionDate: String, subjectName: String)
    {
        self.id = id
        self.userId = userId
        self.score = score
        self.sessionDate = sessionDate
        self.subjectName = subjectName
    }
}
