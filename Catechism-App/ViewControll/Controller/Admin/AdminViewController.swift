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
    @IBOutlet weak var feedbackBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello Admin!!!-------------------")
        // Do any additional setup after loading the view.
        populateDataForTesting()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
        
        createQuizBtn.layer.cornerRadius = 40
        userScoresBtn.layer.cornerRadius =  40
        feedbackBtn.layer.cornerRadius = 40

        adminLogo.layer.cornerRadius = 15
    }


    @IBAction func createQuiz(_ sender: Any) {

    }
    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func populateDataForTesting() {
//        usersTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//        usersTable.delegate = self
//        usersTable.dataSource = self

//        for u in 1...db.getUsers().count {
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
        db.insertUsers(name: "Pedro", password: "32", subscriptionType: 1)
        print("LAST ID -------------------------------------------------------")
        db.insertUsers(name: "Paul", password: "32", subscriptionType: 1)
        db.insertUsers(name: "Paolo", password: "32", subscriptionType: 1)
        db.insertUsers(name: "Pat", password: "32", subscriptionType: 1)

        db.insertUsers(name: "Young", password: "123", subscriptionType: 2)
        db.insertUsers(name: "David", password: "123", subscriptionType: 0)
        db.insertUsers(name: "David2", password: "123", subscriptionType: 3)

        
        db.insertFeedback(feedback: "Pablo is the best developer in the world!")
        
        db.insertFeedback(feedback: "The Dream Team is ALIVE")
        
        db.insertFeedback(feedback: "Steak on Young. Thank you!")
        
        
        db.insertFeedback(feedback: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "English")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 1, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 1, score: 3, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 2, score: 5, sessionDate: "Mar-17-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 2, score: 2, sessionDate: "Mar-17-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 2, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")
        
        db.insertQuizSessions(userId: 3, score: 4, sessionDate: "Mar-37-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 3, score: 4, sessionDate: "Mar-37-2022", subjectName: "English")
        db.insertQuizSessions(userId: 3, score: 4, sessionDate: "Mar-37-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 3, score: 4, sessionDate: "Mar-37-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 3, score: 4, sessionDate: "Mar-37-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 3, score: 3, sessionDate: "Mar-37-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 2, score: 5, sessionDate: "Mar-37-2022", subjectName: "Math")
        db.insertQuizSessions(userId: 2, score: 2, sessionDate: "Mar-37-2022", subjectName: "Science")
        db.insertQuizSessions(userId: 2, score: 4, sessionDate: "Mar-17-2022", subjectName: "Math")

    }




}



