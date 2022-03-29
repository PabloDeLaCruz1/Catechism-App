//
//  FeedbackTableViewController.swift
//  Catechism-App
//
//  Created by Pablo De La Cruz on 3/23/22.
//

import UIKit

class FeedbackTableViewController: UITableViewController {

    let db = DBHelper.init()
    let feedback = DBHelper.init().getFeedback()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedback.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
               return UITableView.automaticDimension
         }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackCell", for: indexPath) as! FeedbackTableViewCell
        cell.textView.text = feedback[indexPath.row].feedback
        
        return cell
    }
}
