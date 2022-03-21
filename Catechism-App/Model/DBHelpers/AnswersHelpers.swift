//
//  AnswersHelpers.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/18/22.
//

import Foundation
import SQLite3

extension DBHelper{
    
    func createAnswersTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Answers(Id INTEGER PRIMARY KEY AUTOINCREMENT, question_id INTEGER, answer_text TEXT, sequence INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Answers table created.")
            } else {
                print("Answers table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertAnswers(questionId: Int, answerText: String, sequence: Int) {
        
        let insertStatementString = "INSERT INTO Answers(question_id, answer_text, sequence) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(questionId))
            sqlite3_bind_text(insertStatement, 2, (answerText as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(sequence))


            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted Answer row.")
            } else {
                print("Could not insert Answer row.")
            }
        } else {
            print("Answer Sessions INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getAnswers() -> [Answers] {
        let queryStatementString = "SELECT * FROM Answers;"
        var queryStatement: OpaquePointer? = nil
        var answers: [Answers] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)

                let questionId = sqlite3_column_int(queryStatement, 1)
                
                let answerText = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))

                let sequence = sqlite3_column_int(queryStatement, 3)
                answers.append(Answers(id: Int(id), questionId: Int(questionId), answerText: answerText, sequence: Int(sequence)))
           
                print("Quiz Sessions Query Result:")
                print("\(questionId) | \(answerText) | \(sequence)")
            }
        } else {
            print("Quiz Sessions SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return answers
    }

}
