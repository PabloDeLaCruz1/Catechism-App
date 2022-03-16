//
//  ViewController.swift
//  Catechism-App
//
//  Created by Dream Team Pablo De La Cruz on 3/12/22.
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var personTable: UITableView!
  
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let cellReuseIdentifier = "cell"
    
    var db:DBHelper = DBHelper()
    
    var persons:[Person] = []
    
    @IBOutlet weak var tableViewEmail: UITextField!
    @IBOutlet weak var tableViewName: UITextField!
    @IBOutlet weak var tableViewRol: UITextField!
    
    @IBOutlet weak var buttonSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertData()
        populateValues()
    }
    
    @IBAction func bSave(_ sender: Any) {
        //getting values from textfields
        
        
        //displaying a success message
        print("Person saved successfully")
    }
    
    //MARK FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = "Name: " + persons[indexPath.row].name + ", " + "Age: " + String(persons[indexPath.row].age)
        return cell
    }
    
    private func populateValues() {
        textLabel.text = "Hello world!"
        currencyLabel.text = "10000"
        dateLabel.text = "07/08/2016"
        imageView.image = UIImage(named: "flag")
    }
    
    func insertData(){
        personTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        personTable.delegate = self
        personTable.dataSource = self
        
        db.deleteByID(id: 1)
        db.deleteByID(id: 2)
        db.insert(id: 11, name: "Pablo", age: 32)
        db.insert(id: 12, name: "Young", age: 25)
        db.insert(id: 13, name: "David", age: 23)
        persons = db.read()
    }
    
}

