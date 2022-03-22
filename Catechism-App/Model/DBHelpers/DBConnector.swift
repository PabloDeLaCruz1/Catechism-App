//
//  DBConnector.swift
//  TeamOne
//
//  Created by Young Ju on 3/17/22.
//
// MARK: temp use and to be deleted.

import Foundation
import SQLite3
//#import <sqlite3.h>
class DBConnector
{
    init()
    {
        _ = open()
    }
  
    let databaseName: String = "DB0.sqlite"
    var db: OpaquePointer?
    
     func open() -> Bool {
        let fileUrl = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(databaseName)

        if sqlite3_open_v2(fileUrl.path, &db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK {
//            print(fileUrl.path)
            return true
        }

        close()
         
        guard let bundleURL = Bundle.main.url(forResource: databaseName, withExtension: nil) else {
            print("Not found in bundle")
            return false
        }

        try? FileManager.default.copyItem(at: bundleURL, to: fileUrl)

        guard sqlite3_open_v2(fileUrl.path, &db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK else {
            let error = sqlite3_errmsg(db).flatMap { String(cString: $0, encoding: .utf8) }
            print(error ?? "Unknown error")
            close()
            return false
        }

         return true
    }

    func close() {
        sqlite3_close(db)
        db = nil
    }
    

    func get5Quizes(type: Int) -> [QuestionSet] {

        let queryQuizString =      //"select * from users"
        "SELECT q.question_text AS 'question', q.correct_answer AS 'correct', 0 AS 'wrong', false AS 'tried', MAX(CASE WHEN a.answer_seq = 1 THEN a.answer_text  END) AS 'first', MAX(CASE WHEN a.answer_seq = 2 THEN a.answer_text  END) AS 'secon',MAX(CASE WHEN a.answer_seq = 3 THEN a.answer_text  END) AS 'third', MAX(CASE WHEN a.answer_seq = 4 THEN a.answer_text  END) AS 'fourth' FROM questions q INNER JOIN answers a ON  q.question_id = a.question_id WHERE q.question_type = ? AND q.question_id IN (SELECT question_id FROM questions WHERE question_type = ? ORDER BY random() LIMIT 5) GROUP BY question, correct, wrong, tried;"

        var queryStatement: OpaquePointer? = nil
        var questions : [QuestionSet] = []
        
        if sqlite3_prepare_v2(db, queryQuizString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(type))
            sqlite3_bind_int(queryStatement, 2, Int32(type))
 while sqlite3_step(queryStatement) == SQLITE_ROW {
                 let questionColumn = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let firstAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let secondAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let thirdAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let fourthAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let correctAnswerColumn = sqlite3_column_int(queryStatement, 1)
                questions.append(QuestionSet(question: String(questionColumn), correctAnswer: Int(correctAnswerColumn),  wrongAnswer: 0, isAnswered: false, firstAnswer: String(firstAnswerColumn), secondAnswer: String(secondAnswerColumn), thirdAnswer: String(thirdAnswerColumn), fourthAnswer: String(fourthAnswerColumn)))
                print("Query Result: \(questionColumn):( \(correctAnswerColumn) ) \n \(firstAnswerColumn) \n \(secondAnswerColumn) \n \(thirdAnswerColumn) \n \(fourthAnswerColumn)")
            }
        } else {
            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
        }
        sqlite3_finalize(queryStatement)
        return questions
    }
    
    func startQuizSession(uid: Int, type: Int, date: String) {
        let insertSessionString =
    "INSERT INTO quiz_sessions(user_id, subject_name, session_date values(?, ?, ?)"
        
        var insertStatement: OpaquePointer? = nil
        var questions : [QuestionSet] = []
        
//        if sqlite3_prepare_v2(db, queryQuizString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(insertStatement, 1, Int32(type))
//            sqlite3_bind_int(insertStatement, 2, Int32(type))
//            sqlite3_bind_text(insertStatement, 3, (date as NSString).utf8String, -1, nil)
//
//            if sqlite3_step(insertStatement) == SQLITE_DONE {
//                print("Successfully inserted row.")
//            } else {
//                print("Could not insert row.")
//            }
// 
//            
//        } else {
//            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
//        }
//        sqlite3_finalize(queryStatement)
//        return questions

    }

    func recordSessionScore() {
    "UPDATE quiz_sessions(user_id, subject_name, score, session_date, login_timestamp)values(9, 3, 0, '', 'login_timestamp')"
    }

}

