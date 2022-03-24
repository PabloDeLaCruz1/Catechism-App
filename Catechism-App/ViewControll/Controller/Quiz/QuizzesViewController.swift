//
//  QuizzesViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/24/22.
//

import UIKit

class QuizzesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    let db = DBHelper.init()
    let questionsSubjects = DBHelper.init().getQuestions()

    @IBOutlet weak var tableView: UITableView!
    let button = UIButton()
    var boolToggler = true
    let url = URL(string: "https://picsum.photos/400/600?random=1")

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self

        let image = UIImage(named: "newViewToggler.png")
        button.frame = CGRect(x: 15, y: 90, width: 400, height: 50)
        button.setBackgroundImage(image, for: UIControl.State.normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action:#selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        if tableView != nil {
            self.view.addSubview(tableView)

        }
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sky.jpeg")!)

    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func imageButtonTapped(_ sender:UIButton!){
        if boolToggler{
            let image = UIImage(named: "pastViewToggler.png")
            button.setBackgroundImage(image, for: UIControl.State.normal)
            boolToggler = false
        }else{
            let image = UIImage(named: "newViewToggler.png")
            button.setBackgroundImage(image, for: UIControl.State.normal)
            boolToggler = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 180
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell") as! QuizTableViewCell
//        cell.randomImgView.image = URLIm
        
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            cell.randomImgView.image = UIImage(data: imageData)
            
        }
        cell.quizTitleLabel.text = String(questionsSubjects[indexPath.row].subject_name)
//        cell.quizTitleLabel.text = questionsSubjects.subject_name

        cell.subTypeLabel.text = "Attempts: 2. Date: \(Date())"
        
        
        return cell

    }
    

    
    func seedData(){
        DBHelper.init().insertQuestions(subjectName: "Math", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "Science", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "iOS", questionText: "what is ", correctAnswer: 1)
        DBHelper.init().insertQuestions(subjectName: "GDC", questionText: "what is ", correctAnswer: 1)
    }

}


