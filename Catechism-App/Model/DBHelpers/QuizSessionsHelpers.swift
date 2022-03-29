//
//  QuizSessionsHelpers.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import Foundation
import SQLite3



extension DBHelper{
    
    func createQuizSessionsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Quiz_Sessions(Id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER, score INTEGER, session_date TEXT, subject_name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Quiz_Sessions table created.")
            } else {
                print("Quiz_Sessions table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertQuizSessions(userId: Int, score: Int, sessionDate: String, subjectName: String) {
        
        let insertStatementString = "INSERT INTO Quiz_Sessions(user_id, score, session_date, subject_name) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(userId))
            sqlite3_bind_int(insertStatement, 2, Int32(score))
            sqlite3_bind_text(insertStatement, 3, (sessionDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (subjectName as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted quiz row.")
            } else {
                print("Could not insert quiz row.")
            }
        } else {
            print("Quiz Sessions INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getQuizSessions() -> [QuizSessions] {
        let queryStatementString = "SELECT * FROM Quiz_Sessions;"
        var queryStatement: OpaquePointer? = nil
        var quizSessions: [QuizSessions] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let userId = sqlite3_column_int(queryStatement, 1)

                let score = sqlite3_column_int(queryStatement, 2)
                let sessionDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let subjectName = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))

                quizSessions.append(QuizSessions(id: Int(id), userId: Int(userId), score: Int(score), sessionDate: sessionDate, subjectName: subjectName))
           
                print("Quiz Sessions Query Result:")
                print("\(id) | \(userId) | \(score) | \(sessionDate) | \(subjectName)")
            }
        } else {
            print("Quiz Sessions SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return quizSessions
    }
        
    func getQuizSessionsScore() -> [QuizSessions] {
        
        
        
        let queryStatementString = "SELECT * FROM Quiz_Sessions where id in (select min(id) from Quiz_Sessions group by user_id, subject_name  order by score) order by  subject_name,  score desc;"
        var queryStatement: OpaquePointer? = nil
        var quizSessions: [QuizSessions] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let userId = sqlite3_column_int(queryStatement, 1)

                let score = sqlite3_column_int(queryStatement, 2)
                let sessionDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let subjectName = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))

                quizSessions.append(QuizSessions(id: Int(id), userId: Int(userId), score: Int(score), sessionDate: sessionDate, subjectName: subjectName))
           
                print("Quiz Sessions Query Result:")
                print("\(id) | \(userId) | \(score) | \(sessionDate) | \(subjectName)")
            }
        } else {
            print("Quiz Sessions SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return quizSessions
    }
    
    
    
    
    func deleteByIDandTable(id: Int, table: String) {
        let deleteStatementStirng = "DELETE FROM \(table) WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row from \(table) .")
            } else {
                print("Could not delete row from \(table) .")
            }
        } else {
            print("DELETE statement for \(table) could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    //Fetch 5 quizes randomly for each session
    func get5Quizes(type: String) -> [QuestionSet] {
        
        let sql =
        "SELECT q.question_text AS 'question', q.correct_answer AS 'correct', 0 AS 'wrong', false AS 'tried', MAX(CASE WHEN a.sequence = 1 THEN a.answer_text  END) AS 'first', MAX(CASE WHEN a.sequence = 2 THEN a.answer_text  END) AS 'second',MAX(CASE WHEN a.sequence = 3 THEN a.answer_text  END) AS 'third', MAX(CASE WHEN a.sequence = 4 THEN a.answer_text  END) AS 'fourth' FROM questions q INNER JOIN answers a ON  q.id = a.question_id WHERE q.subject_name = ? AND q.id IN (SELECT Id FROM questions WHERE subject_name = ? ORDER BY random() LIMIT 5) GROUP BY question, correct, wrong, tried;"
        var getFiveStmt: OpaquePointer? = nil
        var questions : [QuestionSet] = []
        
        if sqlite3_prepare_v2(db, sql, -1, &getFiveStmt, nil) == SQLITE_OK {
            sqlite3_bind_text(getFiveStmt, 1, (type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(getFiveStmt, 2, (type as NSString).utf8String, -1, nil)
            while sqlite3_step(getFiveStmt) == SQLITE_ROW {
                let questionColumn = String(describing: String(cString: sqlite3_column_text(getFiveStmt, 0)))
                let firstAnswerColumn = String(describing: String(cString: sqlite3_column_text(getFiveStmt, 4)))
                let secondAnswerColumn = String(describing: String(cString: sqlite3_column_text(getFiveStmt, 5)))
                let thirdAnswerColumn = String(describing: String(cString: sqlite3_column_text(getFiveStmt, 6)))
                let fourthAnswerColumn = String(describing: String(cString: sqlite3_column_text(getFiveStmt, 7)))
                let correctAnswerColumn = sqlite3_column_int(getFiveStmt, 1)
               
                questions.append(QuestionSet(question: String(questionColumn), correctAnswer: Int(correctAnswerColumn),  wrongAnswer: 0, isAnswered: false, firstAnswer: String(firstAnswerColumn), secondAnswer: String(secondAnswerColumn), thirdAnswer: String(thirdAnswerColumn), fourthAnswer: String(fourthAnswerColumn)))
            }
        } else {
            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
        }
        sqlite3_finalize(getFiveStmt)
        return questions
    }
    
    //Check if user subscription_type type is free
    func checkFree(gameUser: Int) -> Int32 {
        let sql = "SELECT COUNT(*) FROM quiz_sessions WHERE user_id = ? AND subscription_type = 0 FROM quiz_sessions INNER JOIN users ON user_id = id GROUP BY user_id"
        
        var getFreeCntStmt: OpaquePointer? = nil
        var freeCount: Int32 = 0
        
        if sqlite3_prepare_v2(db, sql, -1, &getFreeCntStmt, nil) == SQLITE_OK {
            sqlite3_bind_int(getFreeCntStmt, 1, Int32(gameUser))
            while(sqlite3_step(getFreeCntStmt) == SQLITE_ROW){
                freeCount = sqlite3_column_int(getFreeCntStmt, 0)
            }
        } else {
            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
        }
        sqlite3_finalize(getFreeCntStmt)
        return freeCount
    }
    
    //Save a quiz session
    func createSessionRecord(uid: Int, type: String) {  //, date: String
        let sql = "INSERT INTO quiz_sessions(user_id, subject_name, session_date) values(?, ?, DATE('now'))"
        var insertStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, sql, -1, &insertStmt, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStmt, 1, Int32(uid))
            sqlite3_bind_text(insertStmt, 2, (type as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStmt) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
        }
        sqlite3_finalize(insertStmt)
    }
    
    //Updates Quiz Score
    func recordSessionScore(sid : Int, noOfCorrect: Int) {
        let sql = "UPDATE quiz_sessions SET score = ? WHERE quiz_id = ?;"
        var recordScoreStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, sql, -1, &recordScoreStmt, nil) == SQLITE_OK {
            sqlite3_bind_int(recordScoreStmt, 1, Int32(
            ))
            sqlite3_bind_int(recordScoreStmt, 2, Int32(sid))
            
            if sqlite3_step(recordScoreStmt) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
        }
        sqlite3_finalize(recordScoreStmt)
    }
}
