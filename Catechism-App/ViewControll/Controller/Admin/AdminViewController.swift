//
//  AdmonViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/15/22.
//

import UIKit

class AdminViewController: UIViewController {
    let db = DBHelper.init()
    let users = DBHelper.init().getUsers()
    let quizSessions = DBHelper.init().getQuizSessions()

    @IBOutlet weak var adminLogo: UIImageView!
    @IBOutlet weak var createQuizBtn: UIButton!
    @IBOutlet weak var userScoresBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello Admin!!!-------------------")
        // Do any additional setup after loading the view.
        populateDataForTesting()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
        
        createQuizBtn.layer.cornerRadius = 40
        userScoresBtn.layer.cornerRadius =  40
        adminLogo.layer.cornerRadius = 15
    }


    @IBAction func createQuiz(_ sender: Any) {

    }

    func populateDataForTesting() {
//        usersTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//        usersTable.delegate = self
//        usersTable.dataSource = self

//        for u in 1...30 {
//            db.deleteByID(id: u)
//            db.deleteByIDandTable(id: u, table: "Answers")
//            db.deleteByIDandTable(id: u, table: "Questions")
//
//        }


        db.deleteByIDandTable(id: 1, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 2, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 3, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 4, table: "Quiz_Sessions")
        db.deleteByIDandTable(id: 5, table: "Quiz_Sessions")

        db.insertUsers(name: "Pablo", password: "32", subscriptionType: 1)
        db.insertUsers(name: "Pablo", password: "32", subscriptionType: 1)
        print("LAST ID -------------------------------------------------------")
        db.insertUsers(name: "Pablo", password: "32", subscriptionType: 1)
        db.insertUsers(name: "Pablo", password: "32", subscriptionType: 1)
        db.insertUsers(name: "Pablo", password: "32", subscriptionType: 1)

        db.insertUsers(name: "Young", password: "123", subscriptionType: 2)
        db.insertUsers(name: "David", password: "123", subscriptionType: 0)

        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "English")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 1, score: 3, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 2, score: 5, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 2, score: 2, sessionDate: "Mar-17-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 2, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")

    }




}



