//
//  QuestionsHelpers.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/17/22.
//

import Foundation
import SQLite3


extension DBHelper {

    func createQuestionsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Questions(Id INTEGER PRIMARY KEY, subject_name TEXT, question_text TEXT, correct_answer TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Questions table created.")
            } else {
                print("Questions table could not be created.")
            }
        } else {
            print("CREATE TABLE Questions statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    func insertQuestions(subjectName: String, questionText: String, correctAnswer: Int) {
        
        let insertStatementString = "INSERT INTO Questions(subject_name, question_text, correct_answer) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 0, (subjectName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 1, (questionText as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(correctAnswer))


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
    
    func getQuestions() -> [Questions] {
        let queryStatementString = "SELECT * FROM Questions;"
        var queryStatement: OpaquePointer? = nil
        var questions: [Questions] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)

                let subject_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let question_text = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let corrrect_answer = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))

                questions.append(Questions(id: Int(id), subject_name: subject_name, question_text: question_text, corrrect_answer: corrrect_answer))

                print("Questions Sessions Query Result:")
                print("\(id) | \(subject_name) | \(question_text) | \(corrrect_answer)")
            }
        } else {
            print("Questions Sessions SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return questions
    }

//    func getLastInsertedId() -> Int {
//        let queryStatementString = "SSELECT LAST_INSERT_ROWID();"
//        var queryStatement: OpaquePointer? = nil
//        var questions: Int = 0
//    }
}
