//
//  AdmonViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/15/22.
//

import UIKit

class AdminViewController: UIViewController {
    let db = DBHelper.init()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello Admin!!!-------------------")
        // Do any additional setup after loading the view.
        populateDataForTesting()
    }


    @IBAction func createQuiz(_ sender: Any) {

    }

    func populateDataForTesting() {
//        usersTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//        usersTable.delegate = self
//        usersTable.dataSource = self

        for u in 1...db.getUsers().count {
            db.deleteByID(id: u)

        }
  

        db.deleteByIDandTable(id: 1, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 2, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 3, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 4, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 5, table: "Quiz_Sessions")

        db.insertUsers( name: "Pablo", password: "32", subscriptionType: 1)
        db.insertUsers( name: "Pablo", password: "32", subscriptionType: 1)

        db.insertUsers( name: "Pablo", password: "32", subscriptionType: 1)
        db.insertUsers( name: "Pablo", password: "32", subscriptionType: 1)
        db.insertUsers( name: "Pablo", password: "32", subscriptionType: 1)

//        db.insertUsers(id: 12, name: "Young", password: "123", subscriptionType: 2)
//        db.insertUsers(id: 13, name: "David", password: "123", subscriptionType: 0)

//        db.insertQuizSessions(id: 1, userId: 11, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
//        db.insertQuizSessions(id: 2, userId: 11, score: 3, sessionDate: "Mar-17-2022", subjectName: "Math")
//        db.insertQuizSessions(id: 3, userId: 11, score: 5, sessionDate: "Mar-17-2022", subjectName: "Math")
//        db.insertQuizSessions(id: 4, userId: 12, score: 2, sessionDate: "Mar-17-2022", subjectName: "Math")
//        db.insertQuizSessions(id: 5, userId: 12, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
    }
    




}
