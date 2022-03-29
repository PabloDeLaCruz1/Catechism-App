//
//  MenuViewController.swift
//  Catechism-App
//
//  Created by David Gonzalez on 3/15/22.
//

import UIKit

//Entry Point After Launch Screen
class MenuViewController: UIViewController {

    @IBOutlet weak var startB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: Add to Seed file
        DBHelper.init().insertQuestions(subjectName: "Math", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "Science", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "iOS", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "GDC", questionText: "what is ", correctAnswer: 1)

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }

    @IBAction func startButtonPressed(_ sender: Any) {

        let storyBoard: UIStoryboard = UIStoryboard(name: "StartStoryboard", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginView") as! StartViewController

        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}
