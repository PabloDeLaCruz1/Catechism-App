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

    func blockUserById(id: Int){
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

}
