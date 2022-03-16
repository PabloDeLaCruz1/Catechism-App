//
//  ViewController.swift
//  Catechism-App
//
//  Created by Dream Team Pablo De La Cruz on 3/12/22.
//

import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var usersTable: UITableView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let cellReuseIdentifier = "cell"
    
    var db:DBHelper = DBHelper()
    
    var users:[Users] = []
    
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
        print("Users saved successfully")
    }
    
    //MARK FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.text = "Name: " + users[indexPath.row].name + ", " + "password: " + String(users[indexPath.row].password)
        return cell
    }
    
    private func populateValues() {
        textLabel.text = "Hello world!"
        currencyLabel.text = "10000"
        dateLabel.text = "07/08/2016"
        imageView.image = UIImage(named: "flag")
    }
    
    func insertData(){
        usersTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        usersTable.delegate = self
        usersTable.dataSource = self
        
        db.deleteByID(id: 11)
        db.deleteByID(id: 12)
        db.deleteByID(id: 13)

        db.insertUsers(id: 11, name: "Pablo", password: "32" , subscriptionType: 1)
        db.insertUsers(id: 12, name: "Young", password: "123", subscriptionType: 2)
        db.insertUsers(id: 13, name: "David", password: "123", subscriptionType: 0)
        users = db.read()
    }
    
}

