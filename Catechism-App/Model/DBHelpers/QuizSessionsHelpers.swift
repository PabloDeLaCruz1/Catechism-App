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
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
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
}
