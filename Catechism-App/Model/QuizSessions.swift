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
    var score: String = ""
    var sessionDate: String = ""
    var subjectName: String = ""

    init(id: Int, userId: Int, score: String, sessionDate: String, subjectName: String)
    {
        self.id = id
        self.userId = userId
        self.score = score
        self.sessionDate = sessionDate
        self.subjectName = subjectName
    }
}
