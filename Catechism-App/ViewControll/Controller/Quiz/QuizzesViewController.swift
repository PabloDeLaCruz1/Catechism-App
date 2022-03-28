//
//  QuizzesViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/24/22.
//

import UIKit

class QuizzesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let questionsSubjects = DBHelper.init().getQuestions()
    var userData = Users()
    @IBOutlet weak var tableView: UITableView!
    let button = UIButton()
    var boolToggler = true
    var selectedSubject = ""
    var attempts = 2
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self

        let image = UIImage(named: "newViewToggler.png")
        button.frame = CGRect(x: 15, y: 90, width: 400, height: 50)
        button.setBackgroundImage(image, for: UIControl.State.normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(button)

        if tableView != nil {
            self.view.addSubview(tableView)
        }
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @objc func imageButtonTapped(_ sender: UIButton!) {
        if boolToggler {
            let image = UIImage(named: "pastViewToggler.png")
            button.setBackgroundImage(image, for: UIControl.State.normal)
            boolToggler = false
        } else {
            let image = UIImage(named: "newViewToggler.png")
            button.setBackgroundImage(image, for: UIControl.State.normal)
            boolToggler = true
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if attempts > 0 {
            attempts -= 1
            selectedSubject = String(self.questionsSubjects[indexPath.row].subject_name)
            self.performSegue(withIdentifier: "ShowQuizViewController", sender: userData)
        } else {
            print("Out of attempts!")
            self.dismiss(animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowQuizViewController" {
            if let nextVC = segue.destination as? ShowQuizViewController {
                nextVC.selectedSubject = selectedSubject
                nextVC.userData = sender as! Users
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: QuizTableViewCell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as! QuizTableViewCell

        self.configureCell(cell: cell, indexPath: indexPath)
        return cell
    }

    private func configureCell(cell: QuizTableViewCell, indexPath: IndexPath) {

        //MARK: need to save images for reuse so cell lag gets fixed.
        let url = URL(string: "https://picsum.photos/400/600?random=1")

        let data = (try? Data(contentsOf: url!))!
        let imagedata = UIImage(data: data)

        let subjectName = String(self.questionsSubjects[indexPath.row].subject_name)
        let date = "Attempts: \(attempts). Date: \(Date().formatted())"

        cell.randomImgView.image = imagedata
        cell.quizTitleLabel.text = subjectName
        cell.subTypeLabel.text = date

    }

    func seedData() {
        DBHelper.init().insertQuestions(subjectName: "Math", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "Science", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "iOS", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "GDC", questionText: "what is ", correctAnswer: 1)
    }
}


