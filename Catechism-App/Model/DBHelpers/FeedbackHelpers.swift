//
//  FeedbackHelpers.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/29/22.
//

import Foundation
import SQLite3

extension DBHelper{
    
    func createFeedbackTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Feedback(feedback TEXT);"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Feedback table created.")
            } else {
                print("Feedback table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertFeedback(feedback: String ) {
        let insertStatementString = "INSERT INTO Feedback( feedback) VALUES (?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (feedback  as NSString).utf8String, -1, nil)
                    
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row in feedback.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getFeedback() -> [Feedback] {
        let queryStatementString = "SELECT * FROM feedback;"
        var queryStatement: OpaquePointer? = nil
        var psns: [Feedback] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let feedback = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                psns.append(Feedback(feedback: feedback))
                print("Query Result Feedback:")
                print("\(feedback)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
}
