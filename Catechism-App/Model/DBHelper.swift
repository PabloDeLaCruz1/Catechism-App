//
//  DBHelper.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/12/22.
//

import Foundation

import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createUsersTable()
        createQuizSessionsTable()
    }

    let dbPath: String = "catechism.sqlite"
    var db: OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at:::::::::::::::::::::::::::::::::::::::::::::::: \(fileURL.path)")
            return db
        }
    }

    //:::::::::::::::::::::::::::::::::::::::::::
    //::::::::::::::TABLE CREATION ::::::::::::::
    //:::::::::::::::::::::::::::::::::::::::::::
    func createUsersTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Users(Id INTEGER PRIMARY KEY, name TEXT,password TEXT, subscriptionType INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Users table created.")
            } else {
                print("Users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }

    func createQuizSessionsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Quiz_Sessions(Id INTEGER PRIMARY KEY,user_id INTEGER, score INTEGER, session_date TEXT, subject_name TEXT);"
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

    //  Questions
    func createQuestionsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Questions(Id INTEGER PRIMARY KEY, subject_name TEXT, question_text TEXT, correct_answer TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Questions table created.")
            } else {
                print("Questions table could not be created.")
            }
        } else {
            print("CREATE TABLE   Questions statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    // MARK: Insert Data
    //:::::::::::::::::::::::::::::::::::::::::::
    //::::::::::Inserting Data into Tables ::::::
    //:::::::::::::::::::::::::::::::::::::::::::

    func insertUsers(id: Int, name: String, password: String, subscriptionType: Int)
    {
        let users = getUsers()
        for u in users
        {
            if u.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO Users(Id, name, password, subscriptionType) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)

            sqlite3_bind_int(insertStatement, 4, Int32(subscriptionType))

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

    func insertQuizSessions(id: Int, userId: Int, score: Int, sessionDate: String, subjectName: String)
    {
        let quiz = getUsers()
        for q in quiz
        {
            if q.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO Quiz_Sessions(Id, user_id, score, session_date, subject_name) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_int(insertStatement, 2, Int32(userId))
            sqlite3_bind_int(insertStatement, 3, Int32(score))
            sqlite3_bind_text(insertStatement, 4, (sessionDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (subjectName as NSString).utf8String, -1, nil)


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

    // MARK: -  Get Data
    //:::::::::::::::::::::::::::::::::::::::::::
    //::::::::::Reading Data from tables ::::::::
    //:::::::::::::::::::::::::::::::::::::::::::
    

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
    
    // Id INTEGER PRIMARY KEY, subject_name TEXT, question_text TEXT, correct_answer TEXT
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

        questions.append(Questions(id: Int(id), subject_name: subject_name, question_text: question_text,  corrrect_answer : corrrect_answer))
           
                print("Questions Sessions Query Result:")
                print("\(id) | \(subject_name) | \(question_text) | \(corrrect_answer)")
            }
        } else {
            print("Questions Sessions SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return questions
    }

    // MARK: -  Delete Data
    //:::::::::::::::::::::::::::::::::::::::::::
    //::::::::::Deleting Data from tables ::::::::
    //:::::::::::::::::::::::::::::::::::::::::::

    func deleteByID(id: Int) {
        let deleteStatementStirng = "DELETE FROM users WHERE Id = ?;"
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
