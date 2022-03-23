//
//  DBHelper.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/12/22.
//

import Foundation

import SQLite3

class DBHelper {

    init() {
        db = openDatabase()
        createUsersTable()
        createQuizSessionsTable()
        createQuestionsTable()
        createAnswersTable()
    }

    let dbPath: String = "catechism.sqlite"
    var db: OpaquePointer?

    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at:::::::::::::::::::::::::::::::::::::::::::::::: \(fileURL.path)")
            return db
        }
    }

    func createUsersTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Users(Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,password TEXT, subscriptionType INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Users table created.")
            } else {
                print("Users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    func insertUsers(name: String, password: String, subscriptionType: Int) {
        let insertStatementString = "INSERT INTO Users( name, password, subscriptionType) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -1, nil)

            sqlite3_bind_int(insertStatement, 3, Int32(subscriptionType))

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }

    func getUsers() -> [Users] {
        let queryStatementString = "SELECT * FROM users;"
        var queryStatement: OpaquePointer? = nil
        var psns: [Users] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))

                let subscriptionType = sqlite3_column_int(queryStatement, 3)
                psns.append(Users(id: Int(id), name: name, password: password, subscriptionType: Int(subscriptionType)))
                print("Query Result:")
                print("\(id) | \(name) | \(password) | \(subscriptionType)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func getUserById(id: Int) -> [Users] {
        let queryStatementString = "SELECT * FROM users WHERE Id = \(id) ;"
        var queryStatement: OpaquePointer? = nil
        var psns: [Users] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
           
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))

                let subscriptionType = sqlite3_column_int(queryStatement, 3)
                psns.append(Users(id: Int(id), name: name, password: password, subscriptionType: Int(subscriptionType)))
                print("Query Result:")
                print("\(id) | \(name) | \(password) | \(subscriptionType)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        print("User by ID",queryStatementString)
        return psns
    }
    
    
    
    
    
    func getLastInsertedId() -> Int32 {
        let queryStatementString = "SELECT LAST_INSERT_ROWID();"
        var queryStatement: OpaquePointer? = nil
        var lastId: Int32 = 0

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                lastId = sqlite3_column_int(queryStatement, 0)
            }
        } else {
            print("SELECT Last ID statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        print("last ID: ", lastId)
        return lastId
    }

    func deleteByID(id: Int) {
        let deleteStatementStirng = "DELETE FROM Users WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }

    func blockUserById(id: Int) {
        let updateStatementStirng = "UPDATE Users SET subscriptionType = 3 WHERE Id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementStirng, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(updateStatement, 1, Int32(id))
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully blocked user with ID: \(id)")
            } else {
                print("Could not block user with ID: \(id)")
            }
        } else {
            print("Block user with ID: \(id) statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
//    init()
//    {
//        _ = open()
//    }
//
//    let databaseName: String = "DB0.sqlite"
//    var db: OpaquePointer?
//
//     func open() -> Bool {
//        let fileUrl = try! FileManager.default
//            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//            .appendingPathComponent(databaseName)
//
//        if sqlite3_open_v2(fileUrl.path, &db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK {
////            print(fileUrl.path)
//            return true
//        }
//
//        close()
//
//        guard let bundleURL = Bundle.main.url(forResource: databaseName, withExtension: nil) else {
//            print("Not found in bundle")
//            return false
//        }
//
//        try? FileManager.default.copyItem(at: bundleURL, to: fileUrl)
//
//        guard sqlite3_open_v2(fileUrl.path, &db, SQLITE_OPEN_READWRITE, nil) == SQLITE_OK else {
//            let error = sqlite3_errmsg(db).flatMap { String(cString: $0, encoding: .utf8) }
//            print(error ?? "Unknown error")
//            close()
//            return false
//        }
//
//         return true
//    }
//
//    func close() {
//        sqlite3_close(db)
//        db = nil
//    }
    

    func get5Quizes(type: String) -> [QuestionSet] {

        let getFiveStmtText =      //"select * from users"
        "SELECT q.question_text AS 'question', q.correct_answer AS 'correct', 0 AS 'wrong', false AS 'tried', MAX(CASE WHEN a.sequence = 1 THEN a.answer_text  END) AS 'first', MAX(CASE WHEN a.sequence = 2 THEN a.answer_text  END) AS 'second',MAX(CASE WHEN a.sequence = 3 THEN a.answer_text  END) AS 'third', MAX(CASE WHEN a.sequence = 4 THEN a.answer_text  END) AS 'fourth' FROM questions q INNER JOIN answers a ON  q.Id = a.question_id WHERE q.subject_name = ? AND q.Id IN (SELECT Id FROM questions WHERE subject_name = ? ORDER BY random() LIMIT 5) GROUP BY question, correct, wrong, tried;"

        var queryStmt: OpaquePointer? = nil
        var questions : [QuestionSet] = []
        
        if sqlite3_prepare_v2(db, getFiveStmtText, -1, &queryStmt, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStmt, 1, (type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStmt, 2, (type as NSString).utf8String, -1, nil)
 while sqlite3_step(queryStmt) == SQLITE_ROW {
                 let questionColumn = String(describing: String(cString: sqlite3_column_text(queryStmt, 0)))
                let firstAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStmt, 4)))
                let secondAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStmt, 5)))
                let thirdAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStmt, 6)))
                let fourthAnswerColumn = String(describing: String(cString: sqlite3_column_text(queryStmt, 7)))
                let correctAnswerColumn = sqlite3_column_int(queryStmt, 1)
                questions.append(QuestionSet(question: String(questionColumn), correctAnswer: Int(correctAnswerColumn),  wrongAnswer: 0, isAnswered: false, firstAnswer: String(firstAnswerColumn), secondAnswer: String(secondAnswerColumn), thirdAnswer: String(thirdAnswerColumn), fourthAnswer: String(fourthAnswerColumn)))
            }
        } else {
            NSLog("Database returned error %d: %s", sqlite3_errcode(db), sqlite3_errmsg(db))
        }
        sqlite3_finalize(queryStmt)
        return questions
    }
    
    func createSessionRecord(uid: Int, type: String) {  //, date: String
        let insertSessionStmtText =
    "INSERT INTO quiz_sessions(user_id, subject_name, session_date values(?, ?, DATE('now')"
        
        var insertStmt: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertSessionStmtText, -1, &insertStmt, nil) == SQLITE_OK {
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

    func recordSessionScore(sid : Int, noOfCorrect: Int) {
        
        var recordScoreStmt: OpaquePointer? = nil

        let recordScoreStmtText = "UPDATE quiz_sessions SET score = ? WHERE quiz_id = ?;"
        
        if sqlite3_prepare_v2(db, recordScoreStmtText, -1, &recordScoreStmt, nil) == SQLITE_OK {
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
